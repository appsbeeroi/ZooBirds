import SwiftUI

struct AviaryAddCareTypeCellView: View {
    
    let type: CareType
    
    @Binding var selectedType: CareType?
    
    var body: some View {
        Button {
            selectedType = type
        } label: {
            HStack(spacing: 8) {
                Circle()
                    .stroke(.defaultYellow, lineWidth: 1)
                    .frame(width: 20, height: 20)
                    .overlay {
                        if selectedType == type {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(.defaultYellow)
                        }
                    }
                
                Text(type.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.defaultWhite)
            }
            .frame(height: 56)
            .padding(.horizontal, 12)
            .background(.defaultBlue)
            .cornerRadius(17)
        }
    }
}
