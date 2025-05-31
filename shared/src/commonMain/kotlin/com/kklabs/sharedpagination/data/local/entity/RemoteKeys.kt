package com.kklabs.sharedpagination.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "remote_keys")
data class RemoteKeys(
    @PrimaryKey val goalId: Int,
    val lastFetchedLogCount: Int?,
    val reachedStart: Boolean = false
)