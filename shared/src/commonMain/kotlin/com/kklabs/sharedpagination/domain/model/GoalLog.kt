package com.kklabs.sharedpagination.domain.model

import com.kklabs.sharedpagination.data.local.UploadStatus
import com.kklabs.sharedpagination.data.local.entity.GoalLogDbEntity
import com.kklabs.sharedpagination.data.remote.response.GoalLogResponse

data class GoalLog(
    val id: String,
    val content: String,
    val dateCreated: String,
    val goalId: Long,
    val type: String,
    val userId: Long,
    val caption: String?,
    val preview: String?,
    val logCount: Long?,
    val uploadStatus: String,
)

fun GoalLogDbEntity.toGoalLog(): GoalLog {
    return GoalLog(
        id = id,
        content = content,
        dateCreated = dateCreated.toString(),
        goalId = goalId.toLong(),
        type = type,
        userId = userId.toLong(),
        caption = caption,
        preview = preview,
        logCount = logCount?.toLong(),
        uploadStatus = uploadStatus
    )
}

fun GoalLogResponse.toGoalLog(): GoalLog {
    return GoalLog(
        id = id,
        content = content,
        dateCreated = dateCreated.toString(),
        goalId = goalId.toLong(),
        type = type,
        userId = userId.toLong(),
        caption = caption,
        preview = preview,
        logCount = logCount.toLong(),
        uploadStatus = UploadStatus.SUCCESSFUL.value
    )
}
