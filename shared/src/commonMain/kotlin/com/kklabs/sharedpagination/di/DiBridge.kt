package com.kklabs.sharedpagination.di

import com.kklabs.sharedpagination.data.repo.GoalLogsRepository
import org.koin.mp.KoinPlatform.getKoin


@Throws(Exception::class)
fun getGoalLogsRepository(): GoalLogsRepository = getKoin().get()