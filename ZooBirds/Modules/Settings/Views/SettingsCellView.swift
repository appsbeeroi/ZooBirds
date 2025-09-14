import SwiftUI

struct SettingsCellView: View {
    
    let cellType: SettingsCellType
    
    @Binding var notificationsEnabled: Bool
    
    let onTap: () -> Void
    
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Text(cellType.title)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.defaultWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                accessoryView
            }
            .frame(height: 60)
            .padding(.horizontal, 23)
            .background(.defaultBlue)
            .cornerRadius(20)
        }
    }
    
    @ViewBuilder
    private var accessoryView: some View {
        if cellType == .notification {
            Toggle("", isOn: $notificationsEnabled)
                .tint(.defaultYellow)
                .labelsHidden()
        } else {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.defaultWhite)
        }
    }
}
