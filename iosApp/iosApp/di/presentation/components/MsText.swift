//
//  MsText.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 04/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct MsText: View {
    let text: LocalizedStringKey
    var action: (() -> Void)?
    var maxLines: Int? = nil
    var textAlign: TextAlignment = .leading
    var style: TextStyle = .medium16
    var underline: Bool = false
    

    
    var body: some View {
        Text(text)
            .font(style.customFont)
            .foregroundColor(style.color)
            .underline(underline, color: style.color)
            .multilineTextAlignment(style.alignment)
            .onTapGesture {
                action?()
            }
            .lineLimit(maxLines)
            .multilineTextAlignment(textAlign)
    }
}

#Preview {
    VStack(spacing: 20) {
        MsText(
            text: "Bold 18",
            style: .bold18
        )
        
        MsText(
            text: "Medium 14",
            style: .medium14
        )
        
        MsText(
            text: "Normal 12",
            style: .normal12
        )
        
        MsText(
            text: "Semibold 12",
            style: .semibold12
        )
    }
}


