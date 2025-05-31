import SwiftUI

struct MsTextField: View {
    @Binding var text: String
    var label: String = ""
    var placeholder: String = ""
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    var onReturn: () -> Void = {}
    var enabled: Bool = true
    var readOnly: Bool = false
    var labelTextStyle: TextStyle = .normal12
    var placeholderStyle: TextStyle = .medium16.copy(color: Colors.charcoalGrey30)
    var textStyle: TextStyle = .medium16
    var footerText: String? = nil
    var footerTextStyle: TextStyle = .normal12.copy(color:Colors.pinkishRed)

    @FocusState private var isFocused: Bool

    private var borderColor: Color {
        if isFocused {
            return Colors.black
        } else {
            return Colors.drGreyBorder
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: MsDimensions.dimen8) {
            if !label.isEmpty {
                MsText(
                    text: LocalizedStringKey(label),
                    style: labelTextStyle
                )
                .transition(.opacity)
                .animation(.easeInOut, value: isFocused || !text.isEmpty)
            }

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    MsText(
                        text: LocalizedStringKey(placeholder),
                        style: placeholderStyle
                    )
                    .padding(.leading, MsDimensions.dimen12)
                }

                Group {
                    if isSecure {
                        SecureField("", text: $text)
                            .font(.custom("Outfit-Regular", size: MsDimensions.dimen16))
                            .textContentType(.password)
                            .submitLabel(returnKeyType == .next ? .next : .done)
                            .onSubmit(onReturn)
                            .focused($isFocused)
                            .disabled(!enabled || readOnly)
                    } else {
                        TextField("", text: $text)
                            .font(.custom("Outfit-Regular", size: MsDimensions.dimen16))
                            .keyboardType(keyboardType)
                            .submitLabel(returnKeyType == .next ? .next : .done)
                            .onSubmit(onReturn)
                            .focused($isFocused)
                            .disabled(!enabled || readOnly)
                    }
                }
                .padding(.horizontal, MsDimensions.dimen12)
                .padding(.vertical, MsDimensions.dimen16)
                .background(
                    RoundedRectangle(cornerRadius: MsDimensions.dimen12)
                        .stroke(borderColor, lineWidth: 1)
                )
            }

            if let footerText = footerText {
                MsText(
                    text: LocalizedStringKey(footerText),
                    style: footerTextStyle
                )
                .padding(.top, MsDimensions.dimen4)
            }
        }
    }
}



// Preview
struct KMTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: MsDimensions.dimen20) {
            MsTextField(
                text: .constant(""),
                label: "Email",
                placeholder: "Enter your email",
                keyboardType: .emailAddress
            )
            
            MsTextField(
                text: .constant("password123"),
                label: "Password",
                placeholder: "Enter your password",
                isSecure: true
            )
            
            MsTextField(
                text: .constant("invalid@email"),
                label: "Email with Error",
                placeholder: "Enter your email",
                footerText: "Please enter a valid email address"
            )
        }
        .padding()
    }
} 
