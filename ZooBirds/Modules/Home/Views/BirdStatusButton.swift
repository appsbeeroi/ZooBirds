import SwiftUI

struct BirdStatusButton: View {
    
    let status: BirdStatus
    let isSwitchOffed: Bool
    
    @Binding var selectedStatus: BirdStatus?
    
    init(
        status: BirdStatus,
        isSwitchOffed: Bool = false,
        selectedStatus: Binding<BirdStatus?>
    ) {
        self.status = status
        self.isSwitchOffed = isSwitchOffed
        self._selectedStatus = selectedStatus
    }
    
    var body: some View {
        Button {
            if isSwitchOffed {
             selectedStatus = selectedStatus == status ? nil : status
            } else {
                selectedStatus = status
            }
        } label: {
            HStack(spacing: 2) {
                Image(systemName: status.icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.defaultWhite)
                
                Text(status.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.defaultWhite)
            }
            .frame(height: 45)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
            .background(selectedStatus == status ? .defaultLightBlue : .defaultBlue)
            .cornerRadius(14)
        }
    }
}

#Preview {
    BirdStatusButton(status: .aviary, selectedStatus: .constant(nil))
}
