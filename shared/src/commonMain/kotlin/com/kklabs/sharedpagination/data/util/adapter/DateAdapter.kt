package com.kklabs.sharedpagination.data.util.adapter

import androidx.room.TypeConverter
import kotlinx.datetime.Instant

object CustomDateAdapter {
    @TypeConverter
    fun fromTimestamp(value: String?): Instant? {
        return value?.let { Instant.parse(it) }
    }

    @TypeConverter
    fun dateToTimestamp(date: Instant?): String? {
        return date?.toString()
    }
}