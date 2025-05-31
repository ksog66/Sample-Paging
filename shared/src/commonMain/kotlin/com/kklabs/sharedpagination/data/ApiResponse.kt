package com.kklabs.sharedpagination.data

sealed class ApiResponse<out T : Any> {

    data class Success<T : Any>(val body: T?) : ApiResponse<T>()

    data class Error<T: Any>(val body: ErrorResponse) : ApiResponse<T>()

    val successBody: T
        get() = if (this is Success) {
            body ?: throw kotlin.Error("body is null")
        } else {
            throw kotlin.Error("Response is not success")
        }
}
