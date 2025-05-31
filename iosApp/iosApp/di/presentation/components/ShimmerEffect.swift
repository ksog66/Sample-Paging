//
//  ShimmerEffect.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 15/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var size: CGSize = .zero
    @State private var startOffsetX: CGFloat = -200
    private let duration: Double = 1.5

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height

                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.gray.opacity(0.6),
                            Color.gray.opacity(0.2),
                            Color.gray.opacity(0.6)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: width * 3, height: height)
                    .offset(x: startOffsetX)
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: duration)
                                .repeatForever(autoreverses: false)
                        ) {
                            startOffsetX = width * 2
                        }
                    }
                }
            )
            .mask(content)
    }
}

extension View {
    func shimmerEffect() -> some View {
        self.modifier(ShimmerModifier())
    }
}
