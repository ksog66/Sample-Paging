package com.kklabs.sharedpagination.data.local

import androidx.room.ConstructedBy
import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.RoomDatabaseConstructor
import androidx.room.TypeConverters
import com.kklabs.sharedpagination.data.local.dao.RemoteKeysDao
import com.kklabs.sharedpagination.data.local.dao.GoalLogsDao
import com.kklabs.sharedpagination.data.local.dao.UploadLogsRequestDao
import com.kklabs.sharedpagination.data.local.entity.RemoteKeys
import com.kklabs.sharedpagination.data.local.entity.GoalLogDbEntity
import com.kklabs.sharedpagination.data.local.entity.UploadLogRequestEntity
import com.kklabs.sharedpagination.data.util.adapter.CustomDateAdapter


@Database(
    entities = [GoalLogDbEntity::class, RemoteKeys::class, UploadLogRequestEntity::class],
    version = 1,
    exportSchema = false
)
@ConstructedBy(SafarDBConstructor::class)
@TypeConverters(CustomDateAdapter::class)
abstract class SafarDB : RoomDatabase() {

    abstract fun goalLogsDao(): GoalLogsDao
    abstract fun remoteKeysDao(): RemoteKeysDao
    abstract fun uploadLogRequestDao(): UploadLogsRequestDao
}

@Suppress("NO_ACTUAL_FOR_EXPECT")
expect object SafarDBConstructor : RoomDatabaseConstructor<SafarDB> {
    override fun initialize(): SafarDB
}