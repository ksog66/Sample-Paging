package com.kklabs.sharedpagination.di

import com.kklabs.sharedpagination.data.remote.NetworkDataSourceImpl
import com.kklabs.sharedpagination.domain.NetworkDataSource
import org.koin.core.qualifier.named
import org.koin.dsl.bind
import org.koin.dsl.module

val ApiClientQualifier = named("apiClient")
val FileUploadClientQualifier = named("fileUploadClient")

val networkModule = module {

    single(ApiClientQualifier) {
        provideHttpClient(apiConfigProvider = get())
    }

    single<NetworkDataSource> {
        NetworkDataSourceImpl(httpClient = get(ApiClientQualifier))
    } bind (NetworkDataSource::class)

    single(FileUploadClientQualifier) {
        provideFileUploadHttpClient()
    }
}

