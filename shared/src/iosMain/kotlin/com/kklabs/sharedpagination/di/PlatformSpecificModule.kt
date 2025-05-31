package com.kklabs.sharedpagination.di

import com.kklabs.safarkmm.platformdomain.getDatabaseBuilder
import com.kklabs.sharedpagination.data.local.SafarDB
import com.kklabs.sharedpagination.platformdomain.ApiConfigProvider
import com.kklabs.sharedpagination.platformdomain.ApiConfigProviderImpl
import org.koin.dsl.bind
import org.koin.dsl.module


actual fun platformSpecificModule() = module {

    single { ApiConfigProviderImpl() } bind (ApiConfigProvider::class)


    single<SafarDB> { getDatabaseBuilder() }
}