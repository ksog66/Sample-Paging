package com.kklabs.sharedpagination.data

import com.kklabs.sharedpagination.data.NetworkConstants.CONNECTION_ERROR_CODE
import kotlinx.serialization.Serializable

@Serializable
data class ErrorResponse(
    val message: String,
    val statusCode: Int,
    val code: String? = null
) {

    fun error() = message

    fun isConnectionError() = CONNECTION_ERROR_CODE == statusCode

}