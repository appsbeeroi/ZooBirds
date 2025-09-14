import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isNotificationSetup") var isNotificationSetup = false
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedType: SettingsCellType?
    @State private var isNotificationEnable = false
    @State private var isShowNotificationAlert = false
    @State private var isShareApp = false
    #warning("ВСТАВИТЬ ID")
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack {
                navigation
                cells
                shareButton
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            
            if let selectedType,
               let url = URL(string: selectedType.path) {
                WebView(url: url) {
                    self.selectedType = nil
                    self.isShowTabBar = true
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .onAppear {
            isNotificationEnable = isNotificationSetup
        }
        .sheet(isPresented: $isShareApp) {
            ActivityView(activityItems: ["https://apps.apple.com/app/idYOUR_APP_ID"])
        }
        .onChange(of: isNotificationEnable) { isEnable in
            if isEnable {
                Task {
                    switch await NotificationCenterService.shared.permissionStatus {
                        case .authorized:
                            isNotificationSetup = isEnable
                        case .denied:
                            isShowNotificationAlert = true
                        case .notDetermined:
                            await NotificationCenterService.shared.requestPermission()
                    }
                }
            } else {
                isNotificationSetup = false
            }
        }
        .alert("Notification permission wasn't allowed", isPresented: $isShowNotificationAlert) {
            Button("Yes") {
                openSettings()
            }
            
            Button("No") {
                isNotificationEnable = false
            }
        } message: {
            Text("Open app settings?")
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
    
    private var shareButton: some View {
        Button {
            isShareApp.toggle()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.defaultWhite)
                    
                Text("Export")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.defaultWhite)
            }
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .background(.defaultOrange)
            .cornerRadius(14)
            .padding(.horizontal, 35)
        }
    }
    
    private var cells: some View {
        VStack(spacing: 8) {
            ForEach(SettingsCellType.allCases) { type in
                SettingsCellView(cellType: type, notificationsEnabled: $isNotificationEnable) {
                    guard type != .notification else { return }
                    isShowTabBar = false
                    selectedType = type
                }
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 35)
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

#Preview {
    SettingsView(isShowTabBar: .constant(false))
}
