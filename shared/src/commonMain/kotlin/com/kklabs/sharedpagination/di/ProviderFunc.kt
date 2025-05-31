package com.kklabs.sharedpagination.di

import com.kklabs.sharedpagination.platformdomain.ApiConfigProvider
import io.ktor.client.HttpClient
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.defaultRequest
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.plugins.logging.Logging
import io.ktor.client.request.header
import io.ktor.http.URLProtocol
import io.ktor.serialization.kotlinx.json.json


fun provideHttpClient(
    apiConfigProvider: ApiConfigProvider,
): HttpClient {
    return HttpClient {
        defaultRequest {
            url {
                protocol = URLProtocol.HTTPS
                host = apiConfigProvider.getApiUrl()
            }

            header("Content-Type", "application/json;charset=utf-8")
            header("Connection", "keep-alive")
            header("Accept", "application/json")
            header("x-api-key", apiConfigProvider.getApiKey())
        }

        install(ContentNegotiation) {
            json()
        }

        install(HttpTimeout) {
            requestTimeoutMillis = 30_000
        }

        // Logging (optional)
        install(Logging) {
            level = LogLevel.INFO
        }
    }
}

fun provideFileUploadHttpClient(): HttpClient {
    return HttpClient {
        install(HttpTimeout) {
            requestTimeoutMillis = 120_000
            connectTimeoutMillis = 60_000
            socketTimeoutMillis = 120_000
        }

        install(Logging) {
            level = LogLevel.HEADERS // or NONE if you want silence during upload
        }
    }
}
