package com.kklabs.sharedpagination.platformdomain

import com.kklabs.sharedpagination.BuildConfig

actual class ApiConfigProviderImpl: ApiConfigProvider {
    actual override fun getApiUrl(): String {
        return BuildConfig.BASE_URL
    }
    actual override fun getApiKey(): String {
        return BuildConfig.API_KEY
    }
}