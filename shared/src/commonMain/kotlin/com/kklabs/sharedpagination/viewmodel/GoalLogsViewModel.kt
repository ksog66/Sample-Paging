package com.kklabs.sharedpagination.viewmodel

import androidx.paging.PagingData
import androidx.paging.cachedIn
import androidx.paging.map
import com.kklabs.sharedpagination.data.repo.GoalLogsRepository
import com.kklabs.sharedpagination.domain.model.GoalLog
import com.kklabs.sharedpagination.domain.model.toGoalLog
import com.rickclephas.kmp.nativecoroutines.NativeCoroutinesState
import com.rickclephas.kmp.observableviewmodel.ViewModel
import com.rickclephas.kmp.observableviewmodel.coroutineScope
import com.rickclephas.kmp.observableviewmodel.launch
import com.rickclephas.kmp.observableviewmodel.stateIn
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.update
import org.koin.core.component.KoinComponent
import org.koin.core.component.getScopeName
import org.koin.core.component.inject

class GoalLogsViewModel() : ViewModel(), KoinComponent {

    private val repository: GoalLogsRepository by inject()

    private val _uiState = MutableStateFlow(GoalLogsUiState())
    @NativeCoroutinesState
    val uiState: StateFlow<GoalLogsUiState> = _uiState.stateIn(
        viewModelScope,
        SharingStarted.WhileSubscribed(),
        GoalLogsUiState()
    )

    private val _pagingData = MutableStateFlow<PagingData<GoalLog>>(PagingData.empty())
    @NativeCoroutinesState
    val pagingData: StateFlow<PagingData<GoalLog>>
        get() = _pagingData

    private var goalId: Long? = null

    fun fetchLogs(id: Long) = viewModelScope.launch {
        println("📱 ViewModel: Starting to fetch logs for goalId: $id")
        _uiState.update { it.copy(isLoading = true) }
        goalId = id
        try {
            repository.getPagedLogs(id)
                .cachedIn(viewModelScope.coroutineScope)
                .collectLatest { pagingData ->
                    println("📱 ViewModel: Received paging data from repository")
                    val mappedData = pagingData.map { it.toGoalLog() }
                    println("📱 ViewModel: Mapped paging data to GoalLog")
                    _pagingData.emit(mappedData)
                    println("📱 ViewModel: Emitted paging data to UI")
                    println("ViewModel: -> pagingData Scope name-> ${pagingData.map { it.toGoalLog() }.getScopeName()}")
                    println("ViewModel: -> paging data -> ${pagingData.map { it.toGoalLog() }}")
                    _uiState.update { it.copy(isLoading = false) }
                }
        } catch (e: Exception) {
            println("❌ ViewModel: Error fetching logs: ${e.message}")
            _uiState.update {
                it.copy(
                    isLoading = false,
                    error = e.message
                )
            }
        }
    }
}

data class GoalLogsUiState(
    val logs: List<GoalLog> = emptyList(),
    val isLoading: Boolean = false,
    val isAppending: Boolean = false,
    val error: String? = null
)
