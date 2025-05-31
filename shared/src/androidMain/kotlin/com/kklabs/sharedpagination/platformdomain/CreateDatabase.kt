package com.kklabs.sharedpagination.platformdomain

import android.content.Context
import androidx.room.Room
import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import com.kklabs.sharedpagination.data.local.SafarDB
import kotlinx.coroutines.Dispatchers

fun getDatabaseBuilder(ctx: Context): SafarDB {
    val appContext = ctx.applicationContext
    val dbFile = appContext.getDatabasePath("safar.db")
    return Room.databaseBuilder<SafarDB>(
        context = appContext,
        name = dbFile.absolutePath
    )
        .fallbackToDestructiveMigrationOnDowngrade(true)
        .setDriver(BundledSQLiteDriver())
        .setQueryCoroutineContext(Dispatchers.IO)
        .build()
}