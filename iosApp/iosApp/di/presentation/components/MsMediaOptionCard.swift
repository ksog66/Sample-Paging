//
//  MsMediaOptionCard.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 20/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct MediaOptionCard: View {
    var icon: String // Use SF Symbol or custom image name
    var title: String
    var subtitle: String
    var isProFeature: Bool = false
    var isUserPro: Bool = false
    var navigateToPro: () -> Void = {}
    var onClick: () -> Void

    var body: some View {
        let isLocked = isProFeature && !isUserPro

        Button(action: {
            isLocked ? navigateToPro() : onClick()
        }) {
            HStack(alignment: .center, spacing: 16) {
                // Icon inside circular background
                ZStack {
                    Circle()
                        .fill(Color(white: 0.95)) // white1
                        .frame(width: 56, height: 56)

                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(isLocked ? Color.gray : Color(white: 0.3)) // ltGrey or nomadGrey
                }

                // Title + subtitle + optional PRO badge
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(title)
                            .font(.custom("Outfit-SemiBold", size: 14))
                            .foregroundColor(isLocked ? Color.gray : Color.black)

                        if isLocked {
                            Text("PRO")
                                .font(.custom("Outfit-SemiBold", size: 14))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                    }

                    Text(subtitle)
                        .font(.custom("Outfit-Medium", size: 14))
                        .foregroundColor(
                            isLocked ? Color.gray.opacity(0.7) : Color.gray.opacity(0.7)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Optional lock icon
                if isLocked {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.gray)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
