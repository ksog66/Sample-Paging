package com.kklabs.sharedpagination.data.mapper

import com.kklabs.sharedpagination.data.local.UploadStatus
import com.kklabs.sharedpagination.data.local.entity.GoalLogDbEntity
import com.kklabs.sharedpagination.data.remote.response.GoalLogResponse

fun GoalLogResponse.toActionlogDbEntity(): GoalLogDbEntity {
    return GoalLogDbEntity(
        content = content,
        id = id,
        dateCreated = dateCreated,
        goalId = goalId,
        type = type,
        userId = userId,
        caption = caption,
        logCount = logCount,
        preview = preview,
        uploadStatus = UploadStatus.SUCCESSFUL.value
    )
}