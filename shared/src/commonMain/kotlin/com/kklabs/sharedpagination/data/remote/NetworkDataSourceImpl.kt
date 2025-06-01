package com.kklabs.sharedpagination.data.remote

import com.kklabs.sharedpagination.data.ApiResponse
import com.kklabs.sharedpagination.data.util.safeApiCall
import com.kklabs.sharedpagination.data.remote.response.GoalLogResponse
import com.kklabs.sharedpagination.domain.NetworkDataSource
import io.ktor.client.HttpClient
import io.ktor.http.HttpMethod

class NetworkDataSourceImpl(
    private val httpClient: HttpClient
) : NetworkDataSource {

    override suspend fun getGoalLogs(goalId: Int , lastFetchedLogId: Int?): ApiResponse<List<GoalLogResponse>> {
        println("🌐 NetworkDataSource: Fetching goal logs for goalId: $goalId, lastFetchedLogId: $lastFetchedLogId")
        return httpClient.safeApiCall("/api/v2/goallog", HttpMethod.Get) {
            url {
                parameters.append("goal_id", goalId.toString())
                lastFetchedLogId?.let { parameters.append("last_fetched_log_count", it.toString()) }
            }
        }
    }
}
