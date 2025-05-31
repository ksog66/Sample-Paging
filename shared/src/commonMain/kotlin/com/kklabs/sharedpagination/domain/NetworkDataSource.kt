package com.kklabs.sharedpagination.domain

import com.kklabs.sharedpagination.data.ApiResponse
import com.kklabs.sharedpagination.data.remote.response.GoalLogResponse

interface NetworkDataSource {
    suspend fun getGoalLogs(goalId: Int, lastFetchedLogId: Int?): ApiResponse<List<GoalLogResponse>>
}
