package com.kklabs.sharedpagination.di

import com.kklabs.sharedpagination.viewmodel.GoalLogsViewModel
import org.koin.dsl.module

val viewModelModule = module {
    factory { GoalLogsViewModel() }
}