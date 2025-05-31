//
//  UploadLoadingOverlay.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 20/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct UploadLoadingOverlay: View {
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack {
                VStack(spacing: 16) {
                    ZStack {
                        // Rotating outer circle
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 64, height: 64)
                            .rotationEffect(.degrees(rotation))

                        // Inner circle
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            )
                    }
                    .onAppear {
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            rotation = 360
                        }
                    }

                    MsText(
                        text: "Uploading Log",
                        style: .semibold14.copy(alignment: .center)
                    )
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 8)
                .frame(width: 200, height: 200)
            }
        }
    }
}


struct UploadLoadingOverlay_Preview: PreviewProvider {
    static var previews: some View {
        UploadLoadingOverlay()
    }
}
