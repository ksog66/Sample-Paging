package com.kklabs.sharedpagination.di

import com.kklabs.sharedpagination.data.repo.GoalLogsRepository
import org.koin.dsl.module

val repositoryModule = module {

    single {
        GoalLogsRepository(get(), get())
    }
}