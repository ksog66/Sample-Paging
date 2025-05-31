//
//  HomeShimmer.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 15/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct HomeShimmer: View {
    var body: some View {
        VStack(spacing: MsDimensions.dimen12) {
            headerShimmer
            Spacer()
            contentShimmer
        }
        .padding(.horizontal, MsDimensions.dimen16)
        .background(Color.white)
    }
    
    private var headerShimmer: some View {
        HStack(spacing: MsDimensions.dimen12) {
            // Profile Icon Shimmer
            Circle()
                .fill(Color.gray.opacity(0.1))
                .frame(width: MsDimensions.dimen28, height: MsDimensions.dimen28)
                .shimmerEffect()
            
            // Title Shimmer
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 120, height: MsDimensions.dimen24)
                .shimmerEffect()
            
            Spacer()
            
            // Add Action Button Shimmer
            Circle()
                .fill(Color.gray.opacity(0.1))
                .frame(width: MsDimensions.dimen28, height: MsDimensions.dimen28)
                .shimmerEffect()
        }
        .frame(height: MsDimensions.dimen56)
        .padding(.horizontal, MsDimensions.dimen12)
    }
    
    private var contentShimmer: some View {
        VStack(spacing: MsDimensions.dimen24) {
            ForEach(0..<3, id: \.self) { _ in
                GoalItemShimmer()
            }
        }
    }
}

struct GoalItemShimmer: View {
    var body: some View {
        VStack(spacing: MsDimensions.dimen8) {
            headerView
            logBarsView
            calendarGridView
            footerView
        }
        .padding(MsDimensions.dimen12)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(MsDimensions.dimen8)
    }
    
    private var headerView: some View {
        HStack(spacing: MsDimensions.dimen12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 100, height: MsDimensions.dimen22)
                .shimmerEffect()
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 80, height: MsDimensions.dimen32)
                .shimmerEffect()
        }
    }
    
    private var logBarsView: some View {
        HStack(spacing: MsDimensions.dimen48) {
            ForEach(0..<4, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: MsDimensions.dimen16)
                    .shimmerEffect()
            }
        }
    }
    
    private var calendarGridView: some View {
        VStack(spacing: MsDimensions.dimen4) {
            ForEach(0..<7, id: \.self) { _ in
                HStack(spacing: MsDimensions.dimen2) {
                    ForEach(0..<15, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: MsDimensions.dimen24, height: MsDimensions.dimen24)
                            .shimmerEffect()
                    }
                }
            }
        }
    }
    
    private var footerView: some View {
        HStack(spacing: MsDimensions.dimen12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 80, height: MsDimensions.dimen16)
                .shimmerEffect()
            
            Circle()
                .fill(Color.gray.opacity(0.1))
                .frame(width: MsDimensions.dimen4, height: MsDimensions.dimen4)
                .shimmerEffect()
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 50, height: MsDimensions.dimen16)
                .shimmerEffect()
        }
    }
}

// MARK: - Preview

struct HomeShimmer_Previews: PreviewProvider {
    static var previews: some View {
        HomeShimmer()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
    }
}
