package com.kklabs.sharedpagination.data.util

import com.kklabs.sharedpagination.data.ErrorResponse
import com.kklabs.sharedpagination.data.ApiResponse
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*

suspend inline fun <reified T : Any> HttpClient.safeApiCall(
    urlString: String,
    method: HttpMethod = HttpMethod.Get,
    body: Any? = null,
    crossinline block: HttpRequestBuilder.() -> Unit = {}
): ApiResponse<T> {
    return try {
        val response: HttpResponse = request {
            url(urlString)
            this.method = method
            if (body != null) {
                setBody(body)
            }
            block()
        }

        if (response.status.isSuccess()) {
            val responseBody = response.body<T>()
            ApiResponse.Success(responseBody)
        } else {
            val errorResponse = response.body<ErrorResponse>()
            ApiResponse.Error(errorResponse)
        }
    } catch (e: Exception) {
        ApiResponse.Error(
            ErrorResponse(
                e.message ?: "Unknown error occurred",
                statusCode = -1
            )
        )
    }
}


