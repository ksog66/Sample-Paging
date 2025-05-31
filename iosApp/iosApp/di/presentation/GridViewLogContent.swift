//
//  GridViewLogContent.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 19/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import shared

struct GridViewLogContent: View {
    var goalLogs: [GoalLog]
    let loadMore: () -> Void
    var addNewLog: () -> Void
    var retryUpload: (String) -> Void
    
    private let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    @State private var hasAppeared = false
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVGrid(columns: columns) {
                        
                        AddNewLogItem(
                            onItemClick: addNewLog
                        )
                        .rotationEffect(.degrees(180))
                        .scaleEffect(x: -1, y: 1, anchor: .center)
                        .id("addNewLog")
                        
                        logItemsView()
                    }
                    .environment(\.layoutDirection, .rightToLeft)
                }
                .rotationEffect(.degrees(180))
                .scaleEffect(x: -1, y: 1, anchor: .center)
                .onAppear {
                    if !hasAppeared {
                        hasAppeared = true
                        proxy.scrollTo("addNewLog", anchor: .bottom)
                    }
                }
            }
            
            if goalLogs.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
        }
        .background(Color.white)
    }
    
    private func logItemsView() -> some View {
        ForEach(Array(goalLogs.enumerated()), id: \.1.id) { index, log in
            LogItemView(
                log: log,
                retryUpload: retryUpload
            )
            .rotationEffect(.degrees(180))
            .scaleEffect(x: -1, y: 1, anchor: .center)
            .onAppear {
                if hasAppeared && index == goalLogs.count - 1 {
                    loadMore()
                }
            }
        }
        .padding(.horizontal, MsDimensions.dimen4)
    }
}

private struct LogItemView: View {
    var log: GoalLog
    var retryUpload: (String) -> Void
    
    var body: some View {
        let uploadStatus = UploadStatus.Companion().fromString(s: log.uploadStatus)
        
        switch uploadStatus {
        case .inProgress:
            InProgressLogGridComponent(data: log)
                .frame(minHeight: 0, maxHeight: .infinity)
                .id(log.id)
            
        case .successful:
            GoalLogGridComponent(data: log)
                .frame(minHeight: 0, maxHeight: .infinity)
                .id(log.id)
            
        case .failed:
            FailedLogGridComponent(
                data: log,
                retryUpload: retryUpload
            )
            .frame(minHeight: 0, maxHeight: .infinity)
            .id(log.id)
            
        default:
            EmptyView()
        }
    }
}
