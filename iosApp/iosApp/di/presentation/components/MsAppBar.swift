//
//  MsAppBar.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 14/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct MsAppBar<Content: View>: View {
    var title: String?
    var navIcon: Image?
    var style: TextStyle = .normal12
    var backgroundColor: Color = .white
    var onNavIconClick: () -> Void = {}
    var navTint: Color = .gray
    var isCenterAligned: Bool = false
    let actions: Content
    
    init(
        title: String? = nil,
        navIcon: Image? = nil,
        style: TextStyle = .normal12,
        backgroundColor: Color = .white,
        navTint: Color = .gray,
        isCenterAligned: Bool = false,
        onNavIconClick: @escaping () -> Void = {},
        @ViewBuilder actions: () -> Content
    ) {
        self.title = title
        self.navIcon = navIcon
        self.backgroundColor = backgroundColor
        self.navTint = navTint
        self.style = style
        self.isCenterAligned = isCenterAligned
        self.onNavIconClick = onNavIconClick
        self.actions = actions()
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 8) {
                // Left Icon
                if let navIcon = navIcon {
                    Button(action: onNavIconClick) {
                        navIcon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: MsDimensions.dimen24, height: MsDimensions.dimen24)
                            .foregroundColor(navTint)
                    }
                    .frame(width: MsDimensions.dimen36, height: MsDimensions.dimen36)
                }
                
                if isCenterAligned {
                    Spacer()
                }
                
                // Title
                if let title = title, !isCenterAligned {
                    MsText(
                        text: LocalizedStringKey(title),
                        maxLines: 1,
                        style: style.copy(alignment: .center)
                    )
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: isCenterAligned ? .center : .leading)
                }
                
                Spacer()
                
                // Actions
                HStack(spacing: 8) {
                    actions
                }
            }
            .padding(.vertical, 8)
            .background(backgroundColor)
            
            if let title = title, isCenterAligned {
                MsText(
                    text: LocalizedStringKey(title),
                    maxLines: 1,
                    style: style.copy(alignment: .center)
                )
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: isCenterAligned ? .center : .leading)
            }
        }
        
    }
}

struct MsAppBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            MsAppBar(
                title: "Safar",
                navIcon: Image(systemName: "person.circle"),
                isCenterAligned: false,
                onNavIconClick: {
                    print("Nav Icon Clicked")
                }
            ) {
                // No actions
            }
            
            MsAppBar(
                title: "Safar",
                navIcon: Image(systemName: "person.circle"),
                isCenterAligned: true,
                onNavIconClick: {
                    print("Nav Icon Clicked")
                }
            ) {
                Button("Pro") {
                    print("Pro Clicked")
                }
                
                Button(action: {
                    print("Add Clicked")
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding()
    }
}
