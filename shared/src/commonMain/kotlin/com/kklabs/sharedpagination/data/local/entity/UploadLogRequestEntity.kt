package com.kklabs.sharedpagination.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.datetime.Instant

@Entity("upload_log_request")
data class UploadLogRequestEntity(
    @PrimaryKey
    val id: String,
    val fileName: String,
    val signedUrl: String,
    val contentUrl: String,
    val contentUri: String,
    val mimeType: String?,
    val preview: String?,
    val type: String,
    val goalId: Int,
    val dateCreated: Instant,
    val caption: String?,
    val uploadStatus: String
)
