import SwiftUI

struct MsButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = .black
    var cornerRadius: CGFloat = MsDimensions.dimen16
    var height: CGFloat = MsDimensions.dimen56
    var shadowRadius: CGFloat = MsDimensions.dimen2
    var leadingIcon: Image? = nil
    var textStyle: TextStyle = .medium16.copy(color: .white)
    var isLoading: Bool = false
    var enabled: Bool = true
    
    var body: some View {
        ZStack {
            if isLoading {
                MsLoader()
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
            } else {
                Button(action: action) {
                    HStack {
                        if let icon = leadingIcon {
                            icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: MsDimensions.dimen24, height: MsDimensions.dimen24)
                        }
                        MsText(
                            text: LocalizedStringKey(title),
                            action: action,
                            style: textStyle,
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .background(enabled ? backgroundColor : Colors.addNewAddressBorder)
                    .cornerRadius(cornerRadius)
                    .shadow(color: .black.opacity(0.1), radius: shadowRadius, x: 0, y: 2)
                    .contentShape(Rectangle())
                }
                .buttonStyle(MsButtonStyle())
                .disabled(!enabled)
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
    }
}

// Custom button style that handles the press animation
struct MsButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
