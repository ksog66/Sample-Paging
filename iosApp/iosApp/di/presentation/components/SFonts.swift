import SwiftUI

enum OutfitFont {
    case thin
    case extralight
    case light
    case regular
    case medium
    case semibold
    case bold
    case extrabold
    case black
    
    var name: String {
        switch self {
        case .thin: return "Outfit-Thin"
        case .extralight: return "Outfit-ExtraLight"
        case .light: return "Outfit-Light"
        case .regular: return "Outfit-Regular"
        case .medium: return "Outfit-Medium"
        case .semibold: return "Outfit-SemiBold"
        case .bold: return "Outfit-Bold"
        case .extrabold: return "Outfit-ExtraBold"
        case .black: return "Outfit-Black"
        }
    }
    
    var weight: Font.Weight {
        switch self {
        case .thin: return .thin
        case .extralight: return .ultraLight
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .extrabold: return .heavy
        case .black: return .black
        }
    }
}

struct TextStyle {
    let font: OutfitFont
    let size: CGFloat
    let lineHeight: CGFloat
    let alignment: TextAlignment
    let color: Color
    
    var fontName: String {
        return font.name
    }
    
    var weight: Font.Weight {
        return font.weight
    }
}

// Base text styles
extension TextStyle {
    static let normal10 = TextStyle(font: .regular, size: MsDimensions.dimen10, lineHeight: MsDimensions.dimen12, alignment: .leading, color: .black)
    static let medium10 = TextStyle(font: .medium, size: MsDimensions.dimen10, lineHeight: MsDimensions.dimen12, alignment: .leading, color: .black)
    static let medium11 = TextStyle(font: .medium, size: MsDimensions.dimen11, lineHeight: MsDimensions.dimen12, alignment: .leading, color: .black)
    
    static let normal12 = TextStyle(font: .regular, size: MsDimensions.dimen12, lineHeight: MsDimensions.dimen16, alignment: .leading, color: .black)
    static let medium12 = TextStyle(font: .medium, size: MsDimensions.dimen12, lineHeight: MsDimensions.dimen16, alignment: .leading, color: .black)
    static let semibold12 = TextStyle(font: .semibold, size: MsDimensions.dimen12, lineHeight: MsDimensions.dimen16, alignment: .leading, color: .black)
    static let bold12 = TextStyle(font: .bold, size: MsDimensions.dimen12, lineHeight: MsDimensions.dimen16, alignment: .leading, color: .black)
    
    static let normal14 = TextStyle(font: .regular, size: MsDimensions.dimen14, lineHeight: MsDimensions.dimen20, alignment: .leading, color: .black)
    static let medium14 = TextStyle(font: .medium, size: MsDimensions.dimen14, lineHeight: MsDimensions.dimen20, alignment: .leading, color: .black)
    static let semibold14 = TextStyle(font: .semibold, size: MsDimensions.dimen14, lineHeight: MsDimensions.dimen20, alignment: .leading, color: .black)
    static let bold14 = TextStyle(font: .bold, size: MsDimensions.dimen14, lineHeight: MsDimensions.dimen20, alignment: .leading, color: .black)
    
    static let normal16 = TextStyle(font: .regular, size: MsDimensions.dimen16, lineHeight: MsDimensions.dimen24, alignment: .leading, color: .black)
    static let medium16 = TextStyle(font: .medium, size: MsDimensions.dimen16, lineHeight: MsDimensions.dimen24, alignment: .leading, color: .black)
    static let semibold16 = TextStyle(font: .semibold, size: MsDimensions.dimen16, lineHeight: MsDimensions.dimen24, alignment: .leading, color: .black)
    static let bold16 = TextStyle(font: .bold, size: MsDimensions.dimen16, lineHeight: MsDimensions.dimen24, alignment: .leading, color: .black)
    
    static let normal18 = TextStyle(font: .regular, size: MsDimensions.dimen18, lineHeight: MsDimensions.dimen24, alignment: .leading, color: .black)
    static let medium18 = TextStyle(font: .medium, size: MsDimensions.dimen18, lineHeight: MsDimensions.dimen24, alignment: .leading, color: .black)
    static let bold18 = TextStyle(font: .bold, size: MsDimensions.dimen18, lineHeight: MsDimensions.dimen24, alignment: .leading, color: .black)
    
    static let normal20 = TextStyle(font: .regular, size: MsDimensions.dimen20, lineHeight: MsDimensions.dimen28, alignment: .leading, color: .black)
    static let medium20 = TextStyle(font: .medium, size: MsDimensions.dimen20, lineHeight: MsDimensions.dimen28, alignment: .leading, color: .black)
    static let bold20 = TextStyle(font: .bold, size: MsDimensions.dimen20, lineHeight: MsDimensions.dimen28, alignment: .leading, color: .black)
    
    static let normal24 = TextStyle(font: .regular, size: MsDimensions.dimen24, lineHeight: MsDimensions.dimen32, alignment: .leading, color: .black)
    static let medium24 = TextStyle(font: .medium, size: MsDimensions.dimen24, lineHeight: MsDimensions.dimen32, alignment: .leading, color: .black)
    static let bold24 = TextStyle(font: .bold, size: MsDimensions.dimen24, lineHeight: MsDimensions.dimen32, alignment: .leading, color: .black)
    static let semibold40 = TextStyle(font: .semibold, size: MsDimensions.dimen40, lineHeight: MsDimensions.dimen48, alignment: .leading, color: .black)
    
    static let bold64 = TextStyle(font: .bold, size: MsDimensions.dimen64, lineHeight: MsDimensions.dimen72, alignment: .leading, color: .black)
    static let semibold28 = TextStyle(font: .semibold, size: MsDimensions.dimen28, lineHeight: MsDimensions.dimen36, alignment: .leading, color: .black)
    
    static let semibold22 = TextStyle(font: .semibold, size: MsDimensions.dimen22, lineHeight: MsDimensions.dimen30, alignment: .leading, color: .black)
    static let semibold24 = TextStyle(font: .semibold, size: MsDimensions.dimen24, lineHeight: MsDimensions.dimen32, alignment: .leading, color: .black)
    
    static let semibold18 = TextStyle(font: .semibold, size: MsDimensions.dimen18, lineHeight: MsDimensions.dimen26, alignment: .leading, color: .black)
}

// Extension to create Font from TextStyle
extension TextStyle {
    var customFont: Font {
        return Font.custom(fontName, size: size)
    }
    
    func copy(
        font: OutfitFont? = nil,
        size: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        alignment: TextAlignment? = nil,
        color: Color? = nil
    ) -> TextStyle {
        return TextStyle(
            font: font ?? self.font,
            size: size ?? self.size,
            lineHeight: lineHeight ?? self.lineHeight,
            alignment: alignment ?? self.alignment,
            color: color ?? self.color
        )
    }
}

// Extension to create Text with TextStyle
extension Text {
    init(_ string: String, style: TextStyle) {
        self = Text(string)
            .font(style.customFont)
            .lineSpacing(style.lineHeight - style.size)
            .multilineTextAlignment(style.alignment) as! Text
    }
}
