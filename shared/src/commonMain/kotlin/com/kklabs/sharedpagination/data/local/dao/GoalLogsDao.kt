package com.kklabs.sharedpagination.data.local.dao

import androidx.paging.PagingSource
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.kklabs.sharedpagination.data.local.entity.GoalLogDbEntity

@Dao
interface GoalLogsDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(actionlogs: List<GoalLogDbEntity>)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertOne(actionlog: GoalLogDbEntity)

    @Query("SELECT * FROM goallogdbentity WHERE goalId=:goalId ORDER BY dateCreated DESC LIMIT 1")
    suspend fun getLastGoallog(goalId: Int): GoalLogDbEntity?

    @Query("SELECT * FROM goallogdbentity WHERE goalId=:goalId ORDER BY dateCreated DESC")
    fun getGoalLogs(goalId: Int): PagingSource<Int, GoalLogDbEntity>

    @Query("DELETE FROM goallogdbentity WHERE goalId=:goalId")
    suspend fun deleteLogsById(goalId: Int)

    @Query("SELECT COUNT(*) FROM goallogdbentity where goalId=:goalId")
    suspend fun getLogsCount(goalId: Int): Int

    @Query("UPDATE goallogdbentity SET uploadStatus=:status WHERE id=:id")
    suspend fun updateUploadStatus(id: String, status: String)
}