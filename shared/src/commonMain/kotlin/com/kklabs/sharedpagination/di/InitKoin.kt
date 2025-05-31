package com.kklabs.sharedpagination.di

import org.koin.core.context.startKoin
import org.koin.dsl.KoinAppDeclaration

fun initKoin(appDeclaration: KoinAppDeclaration = {}) = startKoin {
    appDeclaration()
    printLogger()
    modules(platformSpecificModule(), networkModule, repositoryModule, viewModelModule)
}

// called by iOS etc
fun initKoin() = initKoin{}