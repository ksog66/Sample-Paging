package com.kklabs.sharedpagination.utils

import androidx.paging.AsyncPagingDataDiffer
import androidx.paging.CombinedLoadStates
import androidx.paging.PagingData
import androidx.recyclerview.widget.DiffUtil
import com.rickclephas.kmp.nativecoroutines.NativeCoroutines
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow

// Making abstract causes the compilation error "Non-final Kotlin subclasses of Objective-C classes are not yet supported".
class SwiftUiPagingHelper<T : Any> {
    private val mainDispatcher: CoroutineDispatcher = Dispatchers.Main
    private val workerDispatcher: CoroutineDispatcher = Dispatchers.Default

    private val diffCallback = object : DiffUtil.ItemCallback<T>() {
        override fun areItemsTheSame(oldItem: T, newItem: T): Boolean = oldItem == newItem

        override fun areContentsTheSame(oldItem: T, newItem: T): Boolean = oldItem == newItem
    }

    private val differ = AsyncPagingDataDiffer(
        diffCallback,
        object : androidx.recyclerview.widget.ListUpdateCallback {
            override fun onInserted(position: kotlin.Int, count: kotlin.Int) {
            }

            override fun onRemoved(position: kotlin.Int, count: kotlin.Int) {
            }

            override fun onMoved(fromPosition: kotlin.Int, toPosition: kotlin.Int) {
            }

            override fun onChanged(
                position: kotlin.Int,
                count: kotlin.Int,
                payload: kotlin.Any?
            ) {
            }
        },
        mainDispatcher = mainDispatcher,
        workerDispatcher = workerDispatcher
    )

    suspend fun submitData(pagingData: PagingData<T>) {
        differ.submitData(pagingData)
    }

    fun retry() {
        differ.retry()
    }

    fun refresh() {
        differ.refresh()
    }

    fun loadNextPage() {
        val index = getItemCount() - 1
        // ignore the first time load with -1
        if (index < 0) return
        differ.getItem(index)
    }

    private fun getItemCount(): Int = differ.itemCount

    fun getItems() = differ.snapshot().items

    @NativeCoroutines
    val loadStateFlow: Flow<CombinedLoadStates> = differ.loadStateFlow

    @NativeCoroutines
    val onPagesUpdatedFlow: Flow<Unit> = differ.onPagesUpdatedFlow
}