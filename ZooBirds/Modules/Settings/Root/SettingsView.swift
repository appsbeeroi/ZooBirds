import SwiftUI

struct SettingsView: View {
    
    @Binding var isShowTabBar: Bool
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack {
                navigation
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private var navigation: some View {
        VStack(spacing: 8) {
                Text("Settings")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.defaultWhite)
                    .font(.system(size: 17, weight: .heavy))
            
            Rectangle()
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.defaultWhite.opacity(0.1))
        }
        .padding(.top, 13)
    }
}

#Preview {
    SettingsView(isShowTabBar: .constant(false))
}
