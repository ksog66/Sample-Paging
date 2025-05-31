package com.kklabs.sharedpagination.domain

import androidx.paging.ExperimentalPagingApi
import androidx.paging.LoadType
import androidx.paging.PagingState
import androidx.paging.RemoteMediator
import androidx.room.immediateTransaction
import androidx.room.useWriterConnection
import com.kklabs.sharedpagination.data.ApiResponse
import com.kklabs.sharedpagination.data.local.SafarDB
import com.kklabs.sharedpagination.data.local.entity.GoalLogDbEntity
import com.kklabs.sharedpagination.data.local.entity.RemoteKeys
import com.kklabs.sharedpagination.data.mapper.toActionlogDbEntity
import com.kklabs.sharedpagination.data.remote.response.GoalLogResponse

@OptIn(ExperimentalPagingApi::class)
class GoalLogsRemoteMediator(
    private val goalId: Int,
    private val service: NetworkDataSource,
    private val db: SafarDB
) : RemoteMediator<Int, GoalLogDbEntity>() {

    override suspend fun initialize(): InitializeAction {
        return InitializeAction.LAUNCH_INITIAL_REFRESH
    }

    override suspend fun load(
        loadType: LoadType,
        state: PagingState<Int, GoalLogDbEntity>
    ): MediatorResult {

        val isLocalEmpty = db.goalLogsDao().getLogsCount(goalId) == 0

        val lastFetchedLogCount = when (loadType) {
            LoadType.REFRESH -> {
                null
            }
            LoadType.APPEND -> {
                val remoteKey = db.remoteKeysDao().getRemoteKey(goalId)
                if (remoteKey?.reachedStart == true) {
                    return MediatorResult.Success(endOfPaginationReached = true)
                }
                remoteKey?.lastFetchedLogCount
            }
            LoadType.PREPEND -> {
                return MediatorResult.Success(endOfPaginationReached = true)
            }
        }

        return try {
            val apiResponse = service.getGoalLogs(32, lastFetchedLogCount?.toInt())

            when (apiResponse) {
                is ApiResponse.Error -> {
                    MediatorResult.Error(Exception(apiResponse.body.message))
                }

                is ApiResponse.Success -> {
                    val logs = apiResponse.successBody
                        .map(GoalLogResponse::toActionlogDbEntity)

                    val endReached = logs.isEmpty()

                    db.useWriterConnection { transactor ->
                        transactor.immediateTransaction {

                        }
                        if (loadType == LoadType.REFRESH) {
                            db.remoteKeysDao().deleteByGoalId(goalId)
                            db.goalLogsDao().deleteLogsById(goalId)
                        }
                        db.goalLogsDao().insertAll(logs)

                        if (logs.isNotEmpty()) {
                            val newLastFetchedLogCount = logs.last().logCount
                            val remoteKey = db.remoteKeysDao().getRemoteKey(goalId)
                            val newReachedStart = if (loadType == LoadType.REFRESH) {
                                logs.any { it.logCount == 1 }
                            } else {
                                remoteKey?.reachedStart == true
                            }

                            db.remoteKeysDao().insertOne(
                                remoteKey = RemoteKeys(
                                    goalId = goalId,
                                    lastFetchedLogCount = newLastFetchedLogCount,
                                    newReachedStart
                                )
                            )
                        }
                    }

                    MediatorResult.Success(endOfPaginationReached = endReached)
                }
            }

        } catch (e: Exception) {
            MediatorResult.Error(e)
        }
    }
}
