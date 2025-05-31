//
//  MsLoader.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 08/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//
import SwiftUI
import Lottie

struct MsLoader: View {
    var size: CGFloat = 150
    
    var body: some View {
        LottieView(animation: .named("four_dot_animation"))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .frame(width: size, height: size)
    }
}

#Preview {
    MsLoader(size: 100)
}
