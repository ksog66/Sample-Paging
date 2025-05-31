import SwiftUI

struct MsToast: View {
    let message: String
    let type: ToastType
    @Binding var isShowing: Bool
    
    enum ToastType {
        case success
        case error
        case info
        
        var backgroundColor: Color {
            switch self {
            case .success:
                return Color.green.opacity(0.9)
            case .error:
                return Color.red.opacity(0.9)
            case .info:
                return Color.blue.opacity(0.9)
            }
        }
        
        var icon: String {
            switch self {
            case .success:
                return "checkmark.circle.fill"
            case .error:
                return "xmark.circle.fill"
            case .info:
                return "info.circle.fill"
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 12) {
                Image(systemName: type.icon)
                    .foregroundColor(.white)
                
                MsText(
                    text: LocalizedStringKey(message),
                    style: .medium14
                )
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(type.backgroundColor)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut, value: isShowing)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isShowing = false
                }
            }
        }
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let type: MsToast.ToastType
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                VStack {
                    Spacer()
                    MsToast(message: message, type: type, isShowing: $isShowing)
                }
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String, type: MsToast.ToastType) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message, type: type))
    }
} 
