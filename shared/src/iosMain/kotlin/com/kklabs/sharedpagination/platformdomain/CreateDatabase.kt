package com.kklabs.safarkmm.platformdomain

import androidx.room.Room
import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import com.kklabs.sharedpagination.data.local.SafarDB
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import platform.Foundation.NSDocumentDirectory
import platform.Foundation.NSFileManager
import platform.Foundation.NSUserDomainMask

fun getDatabaseBuilder(): SafarDB {
    val dbFilePath = documentDirectory() + "/safar.db"
    return Room.databaseBuilder<SafarDB>(
        name = dbFilePath,
    )
        .fallbackToDestructiveMigrationOnDowngrade(true)
        .setDriver(BundledSQLiteDriver())
        .setQueryCoroutineContext(Dispatchers.IO)
        .build()
}

fun documentDirectory(): String {
    val documentDirectory = NSFileManager.defaultManager.URLForDirectory(
        directory = NSDocumentDirectory,
        inDomain = NSUserDomainMask,
        appropriateForURL = null,
        create = false,
        error = null,
    )
    return requireNotNull(documentDirectory?.path)
}