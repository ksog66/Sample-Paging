package com.kklabs.sharedpagination.platformdomain

import com.kklabs.sharedpagination.utils.NsBundleConfig

actual class ApiConfigProviderImpl actual constructor(): ApiConfigProvider {
    actual override fun getApiUrl(): String = NsBundleConfig.getValue("BASE_URL")
    actual override fun getApiKey(): String = NsBundleConfig.getValue("API_KEY")
}