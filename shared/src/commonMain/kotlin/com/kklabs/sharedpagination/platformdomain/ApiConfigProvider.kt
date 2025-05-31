package com.kklabs.sharedpagination.platformdomain

interface ApiConfigProvider {
    fun getApiUrl(): String
    fun getApiKey(): String
}

expect class ApiConfigProviderImpl(): ApiConfigProvider {
    override fun getApiUrl(): String
    override fun getApiKey(): String
}