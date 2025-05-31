package com.kklabs.sharedpagination.data.repo

import androidx.paging.ExperimentalPagingApi
import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import com.kklabs.sharedpagination.data.local.SafarDB
import com.kklabs.sharedpagination.data.local.entity.GoalLogDbEntity
import com.kklabs.sharedpagination.domain.NetworkDataSource
import com.kklabs.sharedpagination.domain.GoalLogsRemoteMediator
import kotlinx.coroutines.flow.Flow

class GoalLogsRepository(
    private val dataSource: NetworkDataSource,
    private val db: SafarDB
) {

    @OptIn(ExperimentalPagingApi::class)
    fun getPagedLogs(goalId: Long): Flow<PagingData<GoalLogDbEntity>>  {
        val pagingSourceFactory = { db.goalLogsDao().getGoalLogs(goalId.toInt()) }
        return Pager(
            config = PagingConfig(initialLoadSize = 19, pageSize = NETWORK_PAGE_SIZE, prefetchDistance = NETWORK_PRE_FETCH_DISTANCE, enablePlaceholders = false),
            remoteMediator = GoalLogsRemoteMediator(
                goalId.toInt(),
                dataSource,
                db
            ),
            pagingSourceFactory = pagingSourceFactory
        ).flow
    }

//    suspend fun getInitialGoalLogs(goalId: Long): List<GoalLog> {
//
//        val localLogs = db.goal_logQueries.getGoalLogs(goalId).executeAsList()
//
//        if (localLogs.isNotEmpty()) {
//            return localLogs.map { it.toGoalLog() }
//        }
//
//        return when (val response = dataSource.getGoalLogs(goalId.toInt(), null)) {
//            is ApiResponse.Success -> {
//                db.transaction {
//                    response.successBody.forEach { log ->
//                        addGoalLogs(log)
//                    }
//                }
//                response.successBody.map { it.toGoalLog() }
//            }
//            is ApiResponse.Error -> {
//                emptyList()
//            }
//        }
//    }

    companion object {
        const val NETWORK_PAGE_SIZE = 20
        const val NETWORK_PRE_FETCH_DISTANCE = 2
    }
}
