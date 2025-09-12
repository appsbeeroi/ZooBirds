import SwiftUI

struct AviaryAddCareFrequancyCellView: View {
    
    let type: Frequancy
    
    @Binding var selectedType: Frequancy?
    
    var body: some View {
        Button {
            selectedType = type
        } label: {
            Text(type.title)
                .frame(minHeight: 45)
                .padding(.horizontal, 21)
                .foregroundStyle(.defaultWhite)
                .background(selectedType == type ? .defaultLightBlue : .defaultBlue)
                .cornerRadius(9)
        }
    }
}
