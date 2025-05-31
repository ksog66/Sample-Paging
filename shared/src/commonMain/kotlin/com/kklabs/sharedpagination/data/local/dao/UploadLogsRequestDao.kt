package com.kklabs.sharedpagination.data.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.kklabs.sharedpagination.data.local.entity.UploadLogRequestEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface UploadLogsRequestDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertOne(uploadRequest: UploadLogRequestEntity)

    @Query("UPDATE upload_log_request SET uploadStatus=:status WHERE id=:id")
    suspend fun updateStatus(id: String,status: String)

    @Query("SELECT * FROM UPLOAD_LOG_REQUEST WHERE goalId=:goalId")
    fun fetchInProgressLog(goalId: Int): Flow<List<UploadLogRequestEntity>>

    @Query("DELETE from upload_log_request WHERE id=:id")
    suspend fun deleteRequest(id: String)

    @Query("SELECT * FROM UPLOAD_LOG_REQUEST WHERE id=:id")
    suspend fun getUploadRequestById(id: String): UploadLogRequestEntity?

    @Query("UPDATE upload_log_request SET signedUrl=:signedUrl, contentUrl=:contentUrl WHERE id=:id")
    suspend fun updateSignedUrl(id: String, signedUrl: String, contentUrl: String)
}