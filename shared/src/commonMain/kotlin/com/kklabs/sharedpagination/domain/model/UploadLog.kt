package com.kklabs.sharedpagination.domain.model

import com.kklabs.sharedpagination.data.local.entity.UploadLogRequestEntity
import kotlinx.datetime.Instant

data class UploadLog(
    val id: String,
    val fileName: String,
    val signedUrl: String,
    val contentUrl: String,
    val contentUri: String,
    val mimeType: String?,
    val preview: String?,
    val type: String,
    val goalId: Long,
    val dateCreated: Instant,
    val caption: String?,
    val uploadStatus: String
)

fun UploadLogRequestEntity.toUploadLog(): UploadLog {
    return UploadLog(
        id = id,
        fileName = fileName,
        signedUrl = signedUrl,
        contentUrl = contentUrl,
        contentUri = contentUri,
        mimeType = mimeType,
        preview = preview,
        type = type,
        goalId = goalId.toLong(),
        dateCreated = dateCreated,
        caption = caption,
        uploadStatus = uploadStatus,
    )
}