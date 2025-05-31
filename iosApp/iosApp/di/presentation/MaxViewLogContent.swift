//
//  MaxViewLogContent.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 19/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import shared

struct MaxViewLogContent: View {
    var goalLogs: [GoalLog]
    var loadMore: () -> Void
    var addNewLog: () -> Void
    var retryUpload: (String) -> Void
    
    @State private var fullyVisibleIndices: [Int] = []
    @Namespace private var scrollSpace
    
    var body: some View {
        ZStack {
            VStack {
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        logListView()
                            .padding(.horizontal, 8)
                            .background(backgroundGeometryReader())
                    }
                    .rotationEffect(.degrees(180))
                    .scaleEffect(x: -1, y: 1, anchor: .center)
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddNewEntryFAB(addNewLog: addNewLog)
                        .padding(.bottom, 24)
                        .padding(.trailing, 16)
                }
            }
        }
    }
    
    /// Extracted LazyVStack
    private func logListView() -> some View {
        LazyVStack(spacing: 8) {
            ForEach(Array(goalLogs.enumerated()), id: \.1.id) { index, log in
                logView(log: log, index: index)
            }
        }
    }
    
    /// Extracted Log View
    private func logView(log: GoalLog, index: Int) -> some View {
        switch UploadStatus.Companion().fromString(s: log.uploadStatus) {
        case .inProgress:
            return AnyView(InProgressLogMaxCardComponent(data: log)
                .rotationEffect(.degrees(180))
                .scaleEffect(x: -1, y: 1, anchor: .center)
                .onAppear {
                    if index == goalLogs.count - 1 {
                        loadMore()
                    }
                })
            
        case .successful:
            return AnyView(
                GoalLogMaxCardComponent(data: log, canPlay: false)
                    .rotationEffect(.degrees(180))
                    .scaleEffect(x: -1, y: 1, anchor: .center)
                    .onAppear {
                        if index == goalLogs.count - 1 {
                            loadMore()
                        }
                    }
            )
            
        case .failed:
            return AnyView(
                FailedLogMaxCardComponent(data: log, retryUpload: retryUpload)
                    .rotationEffect(.degrees(180))
                    .scaleEffect(x: -1, y: 1, anchor: .center)
                    .onAppear {
                        if index == goalLogs.count - 1 {
                            loadMore()
                        }
                    }
            )
            
        default:
            return AnyView(EmptyView())
        }
    }
    
    /// Extracted Background GeometryReader
    private func backgroundGeometryReader() -> some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    updateVisibleIndices(proxy: proxy)
                }
                .onChange(of: proxy.size) { _ in
                    updateVisibleIndices(proxy: proxy)
                }
        }
    }
    
    /// Updates the indices of fully visible items based on their frame in the viewport.
    private func updateVisibleIndices(proxy: GeometryProxy) {
        DispatchQueue.main.async {
            fullyVisibleIndices = goalLogs.indices.filter { index in
                let frame = proxy.frame(in: .global)
                let itemFrame = proxy.frame(in: .global)
                return itemFrame.minY >= frame.minY && itemFrame.maxY <= frame.maxY
            }
        }
    }
}

struct AddNewEntryFAB: View {
    let addNewLog: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "camera") // Replace with your custom icon if needed
                .resizable()
                .frame(width: 16, height: 16)
                .onTapGesture {
                    addNewLog()
                }
            
            MsText(
                text: "New Entry",
                action: addNewLog,
                style: .semibold12
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16) // Replace with SquircleShape if you have one
                .fill(Color(.lightGray).opacity(0.6))
        )
        .contentShape(Rectangle())
        .onTapGesture {
            addNewLog()
        }
    }
}

