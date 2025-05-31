package com.kklabs.sharedpagination.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.datetime.Instant

@Entity
class GoalLogDbEntity (
    @PrimaryKey
    val id: String,
    val content: String,
    val dateCreated: Instant,
    val goalId: Int,
    val type: String,
    val userId: Int,
    val caption: String?,
    val preview: String?,
    val logCount: Int?,
    val uploadStatus: String
)