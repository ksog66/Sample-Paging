//
//  GoallogsView.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 07/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import shared
import KMPObservableViewModelSwiftUI
import Foundation
import KMPNativeCoroutinesAsync

struct GoalLogsRoute: View {
    @StateViewModel var viewModel = GoalLogsViewModel()
    
    let addNewLog: () -> Void
    let logViewType: GoalLogViewType
    
    init(
        addNewLog: @escaping () -> Void,
        logViewType: GoalLogViewType
    ) {
        self.addNewLog = addNewLog
        self.logViewType = logViewType
    }
    
    @State private var items: [GoalLog] = []
    @State private var hasNextPage: Bool = false
    @State private var errorMessage: String? = nil
    @State private var showLoadingPlaceholder: Bool = false
    
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastType: MsToast.ToastType = .error
    
    private let delegate = SwiftUiPagingHelper<GoalLog>()
    
    //    private let pagingHelper = SwiftUiPagingHelper<GoalLog>()
    
    var body: some View {
        ZStack {
            GoalLogsScreen(
                viewType: viewModel.goalLogViewType ?? logViewType,
                goallogs: items,
                goalName: goalName,
                isNewGoal: isNewGoal,
                errorMessage: errorMessage,
                isLoading: showLoadingPlaceholder,
                isAppending: viewModel.uiState.isAppending,
                hasNextPage: hasNextPage,
                onChangeViewType: { type in
                    print("📱 SwiftUI: View type changed to: \(type)")
                    viewModel.changeViewType(id: Int32(goalId), type: type)
                },
                onEditGoal: {
                    
                },
                addNewLog: addNewLog,
                fetchLogData: {
                    print("📱 SwiftUI: Fetching logs for goalId: \(goalId)")
                    viewModel.fetchLogs(id: Int64(goalId))
                },
                loadMore: {
                    print("📱 SwiftUI: Loading more logs")
                    delegate.loadNextPage()
                },
                retryUpload: { id in
                    
                },
                navigateBack: navigateBack
            )
            
            if showLoadingPlaceholder {
                ProgressView()
            }
            
            if let error = errorMessage {
                VStack {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Retry") {
                        viewModel.fetchLogs(id: Int64(goalId))
                    }
                    .padding()
                }
            }
        }
        .task {
            print("📱 SwiftUI: Setting up paging data")
            await setupPagingData()
        }
        .task {
            print("📱 SwiftUI: Starting to observe page updates")
            await observePagesUpdates()
        }
        .task {
            print("📱 SwiftUI: Starting to observe load states")
            await observeLoadStates()
        }
    }
    
    private func setupPagingData() async {
        print("📱 SwiftUI: Setting up paging data")
        await withTaskCancellationHandler(
            operation: {
                viewModel.fetchLogs(id: Int64(goalId))
                try? await delegate.submitData(pagingData: viewModel.pagingData)
            },
            onCancel: {
                print("📱 SwiftUI: Paging setup cancelled")
            }
        )
    }
    
    private func observePagesUpdates() async {
        do {
            print("📱 SwiftUI: Starting to observe page updates")
            for try await _ in asyncSequence(for: delegate.onPagesUpdatedFlow) {
                self.items = delegate.getItems()
            }
        } catch {}
    }
    
    private func observeLoadStates() async {
        print("📱 SwiftUI: Starting to observe load states")
        for try await loadState in asyncSequence(for: delegate.loadStateFlow) {
                    print("📱 SwiftUI: Load state changed: \(loadState)")
                    switch onEnum(of: loadState.append) {
                    case .error(let errorState):
                        self.errorMessage = errorState.error.message
                        print("📱 SwiftUI: Append error: \(errorState.error.message)")
                        break
                    case .loading(_):
                        print("📱 SwiftUI: Append loading")
                        break
                    case .notLoading(let notLoadingState):
                        self.hasNextPage = !notLoadingState.endOfPaginationReached
                        print("📱 SwiftUI: Append not loading, hasNextPage: \(self.hasNextPage)")
                        break
                    }
        
                    switch onEnum(of: loadState.refresh) {
                    case .error(let errorState):
                        self.errorMessage = errorState.error.message
                        self.showLoadingPlaceholder = false
                        print("📱 SwiftUI: Refresh error: \(errorState.error.message)")
                        break
                    case .loading(_):
                        self.showLoadingPlaceholder = true
                        print("📱 SwiftUI: Refresh loading")
                        break
                    case .notLoading(_):
                        self.showLoadingPlaceholder = false
                        print("📱 SwiftUI: Refresh not loading")
                        break
                    }
                }
    }
}

struct GoalLogsScreen: View {
    let viewType: GoalLogViewType
    let goallogs: [GoalLog]
    let goalName: String
    let isNewGoal: Bool
    let errorMessage: String?
    let isLoading: Bool
    let isAppending: Bool
    let hasNextPage: Bool
    let onChangeViewType: (GoalLogViewType) -> Void
    let onEditGoal: () -> Void
    let addNewLog: () -> Void
    let fetchLogData: () -> Void
    let loadMore: () -> Void
    let retryUpload: (String) -> Void
    let navigateBack: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            GoalLogsAppBar(
                title: goalName,
                viewType: viewType,
                onNavClick: navigateBack,
                onEditGoal: onEditGoal,
                onChangeViewType: onChangeViewType
            )
            .frame(maxWidth: .infinity)
            
            switch true {
            case isLoading, goallogs.isEmpty:
                InitialLoadingView()
            case errorMessage != nil, goallogs.isEmpty:
                GenericErrorView(
                    message: "please_check_internet_connection",
                    ctaText: "retry_literal",
                    onCtaClick: fetchLogData
                )
            case goallogs.isEmpty:
                if isNewGoal {
                    EmptyLogScreen(
                        addNewLog: addNewLog
                    )
                } else {
                    GenericErrorView(
                        message: "please_check_internet_connection",
                        ctaText: "retry_literal",
                        onCtaClick: fetchLogData
                    )
                }
            default:
                switch viewType {
                case GoalLogViewType.gridView:
                    GridViewLogContent(
                        goalLogs: goallogs,
                        loadMore: loadMore,
                        addNewLog: addNewLog,
                        retryUpload: retryUpload
                    )
                case GoalLogViewType.fullScreen:
                    MaxViewLogContent(goalLogs:goallogs, loadMore: loadMore,addNewLog: addNewLog, retryUpload: retryUpload)
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct GoalLogsAppBar: View {
    let title: String
    var viewType: GoalLogViewType
    let onNavClick: () -> Void
    let onEditGoal: () -> Void
    let onChangeViewType: (GoalLogViewType) -> Void
    
    @State private var isExpanded = false
    
    var body: some View {
        HStack {
            Button(action: onNavClick) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 12, height: 16)
                    .foregroundColor(.black)
                    .padding(.horizontal, 12)
            }
            Spacer()
            MsText(
                text: LocalizedStringKey(title),
                style: .semibold16
            )
            Spacer()
            
            Menu{
                Button("Grid View") {
                    onChangeViewType(.gridView)
                }
                Button("Full Screen") {
                    onChangeViewType(.fullScreen)
                }
                Button("Edit Goal") {
                    onEditGoal()
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.horizontal, 12)
            }
        }
        .frame(height: 56)
        .background(Color.white)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct DropdownMenuItem: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            MsText(
                text: LocalizedStringKey(title),
                style: .semibold16.copy(color: isSelected ? .blue : .white)
            )
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct InitialLoadingView: View {
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .frame(width: 42, height: 42)
                .padding(8)
        }
    }
}

struct EmptyLogScreen: View {
    let addNewLog: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            EmptyGoalLogsComponent()
                .frame(maxWidth: .infinity)
            
            MsText(
                text: "You don't have any logs",
                style: .bold20
            )
            
            MsText(
                text: "Click on tap to add to start your Safar",
                style: .normal12.copy(color: .gray)
            )
            
            VStack(spacing: 12) {
                MsButton(
                    title: "Tap to Add",
                    action: addNewLog,
                    leadingIcon: Image("camera")
                )
                .padding(.vertical, 12)
                .padding(.horizontal, 36)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue.opacity(0.6), style: StrokeStyle(lineWidth: 1, dash: [4]))
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .padding(.horizontal, 36)
        .padding(.vertical, 24)
    }
}

