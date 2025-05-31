package com.kklabs.sharedpagination.data.remote.response

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.datetime.*

@Serializable
data class GoalLogResponse(
    @SerialName("content")
    val content: String,
    @SerialName("date_created")
    val dateCreated: Instant,
    @SerialName("id")
    val id: String,
    @SerialName("goal_id")
    val goalId: Int,
    @SerialName("type")
    val type: String,
    @SerialName("user_id")
    val userId: Int,
    @SerialName("caption")
    val caption: String?,
    @SerialName("log_count")
    val logCount: Int,
    @SerialName("preview")
    val preview: String?
)