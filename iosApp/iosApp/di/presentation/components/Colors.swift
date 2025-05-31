//
//  Colors.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 04/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct Colors {
        static let disabledTextGrey = Color(hex: 0xFFAAAAAA)
        static let regentGray = Color(hex: 0x8795A7FF)
        static let jetGray = Color(hex: 0xFF636F7E)
        static let textColorNew = Color(hex: 0xFF404040)
        static let drGreyBorder = Color(hex: 0xFFF1F4F6)
        static let charcoalGrey = Color(hex: 0xFF38424F)
        static let charcoalGrey30 = Color(hex: 0x4D38424F)
        static let black2d = Color(hex: 0xFF2D2D2D)
        static let p2pGrey = Color(hex: 0xFFA5B6C5)
        static let mgy65 = Color(hex: 0xFF808080)
        static let blueOrchid = Color(hex: 0xFF004DEC)
        static let blueBlack = Color(hex: 0xFF101C45)
        static let gray = Color(hex: 0xFF404040)
        static let brightGray = Color(hex: 0xFFECECEC)
        static let dustyGrey = Color(hex: 0xFF9A9A9A)
        static let switchTailColor = Color(hex: 0xFFE6E6E6)
        static let white = Color(hex: 0xFFFAFAFA)
        static let white1 = Color(hex: 0xFFFFFFFF)
        static let newGrey = Color(hex: 0xFFE8ECEF)
        static let gradientOne = Color(hex: 0xFF2D51D1)
        static let gradientTwo = Color(hex: 0xFF4AC8DA)
        static let disabledGrey = Color(hex: 0xFFF4F8FB)
        static let textNewGrey = Color(hex: 0xFF999999)
        static let greenishTeal = Color(hex: 0xFF40BF7F)
        static let greenCyan = Color(hex: 0xFF339966)
        static let azureBlue = Color(hex: 0xFF6698FF)
        static let pinkishRed2 = Color(hex: 0xFFD42B48)
        static let pinkishRed = Color(hex: 0xFFFF2171)
        static let mbkBrown = Color(hex: 0xFFB1903A)
        static let mbkPink = Color(hex: 0xFFFF5A5A)
        static let cadetBlue = Color(hex: 0xFFA5B3C5)
        static let mbkLightYellow = Color(hex: 0xFFFFF9E9)
        static let borderBackgroundColor = Color(hex: 0xFFF3F5F6)
        static let orderItemBackground = Color(hex: 0xFFF1FDFD)
        static let orderItemBorder = Color(hex: 0xFFE5F8F8)
        static let orderItemBorderShadow = Color(hex: 0xFFD4F2F9)
        static let addNewAddressBorder = Color(hex: 0xFFDDE4E9)
        static let bgGreyColor = Color(hex: 0xFFDDE4E9)
        static let textGreyColor = Color(hex: 0xFF9E9E9E)
        static let transparent = Color(hex: 0x00000000)
        static let black = Color(hex: 0xFF000000)
        static let black40 = Color(hex: 0xFF000000)
        static let dashedColor = Color(hex: 0xFFB3CBFF)
        static let loanDueBG = Color(hex: 0xFFF5F8FF)
        static let loanTextColor = Color(hex: 0xFF636F7E)
        static let bgGrey = Color(hex: 0xFFF7F8F9)
        static let black2 = Color(hex: 0xFF292D32)
        static let whiteDrift = Color(hex: 0xFFF7F8F9)
        static let lilyWhite = Color(hex: 0xFFebf9fe)
        static let lightCarminePinkColor = Color(hex: 0xFFE4677C)
        static let goldenText = Color(hex: 0xFF956E22)
        static let gradientStroke = Color(hex:0xFFD6E0FC)
        static let greyTint = Color(hex: 0xFF8A8A8A)
        static let settlementAppBarColor = Color(hex: 0xFFECF9F2)
        static let greenCircleColor = Color(hex: 0xFF37B34A)
        static let yellowCircleColor = Color(hex: 0xFFECB833)
        static let brightRed = Color(hex: 0xFFEC2B2B)
        static let failedCircleColor = Color(hex: 0xFFFBE9EC)
        static let initiatedCircleColor = Color(hex: 0xFFFBF5E9)
        static let refundButtonColor = Color(hex: 0xFFAD1F36)
        static let growBusinessGradient = Color(hex: 0xFFECF7FF)
        static let brandYellow = Color(hex: 0xFFFFC300)
        static let ltGrey = Color(hex: 0xFFD9D9D9)
        static let lightYellow = Color(hex: 0xFFF7F1DE)
        static let offWhite = Color(hex: 0xFFF3F3F3)
        static let yellowGrey = Color(hex: 0xFFE5E3DB)
        static let dirtyYellow = Color(hex: 0xFF8A8261)
        static let nomadGrey = Color(hex: 0xFF637587)
        static let borderGrey = Color(hex: 0xFFAFAFAF)
        static let indicatorGrey = Color(hex: 0xFFD4D0C1)
        static let textGreyNew = Color(hex: 0xFFA7AAB7)
        static let dangerRed = Color(hex: 0xFFCF0000)

    static let greyBd = Color(hex: 0xFF55635E)

    static let textGrey = Color(hex: 0xFF464F4C)

    static let brdGrey = Color(hex: 0xFFB3B3B3)
}

extension Color {
    init(hex: UInt32) {
        let alpha = Double((hex & 0xFF000000) >> 24) / 255.0
        let red   = Double((hex & 0x00FF0000) >> 16) / 255.0
        let green = Double((hex & 0x0000FF00) >> 8) / 255.0
        let blue  = Double((hex & 0x000000FF)) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}



