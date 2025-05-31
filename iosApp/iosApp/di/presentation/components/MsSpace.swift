//
//  MsSpace.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 04/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//
import SwiftUI

struct VerticalSpace: View {
    var height: CGFloat
    
    var body: some View {
        Spacer()
            .frame(height: height)
    }
}

struct HorizontalSpace: View {
    var width: CGFloat
    
    var body: some View {
        Spacer()
            .frame(width: width)
    }
}
