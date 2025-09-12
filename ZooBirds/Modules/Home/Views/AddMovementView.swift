import SwiftUI

struct AddMovementView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let bird: Bird
    let aviaries: [Aviary]
    let action: (Aviary) -> Void
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                grabber
                aviariesList
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 10)
            .padding(.horizontal, 35)
        }
    }
    
    private var grabber: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: 36, height: 5)
            .foregroundStyle(.defaultGray)
    }
    
    private var aviariesList: some View {
        VStack(spacing: 8) {
            Text("Aviaries")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            let sortedDate = bird.aviaries.keys.sorted(by: > )
            
            LazyVStack(spacing: 8) {
                ForEach(aviaries) { aviary in
                    if let firstDate = sortedDate.first,
                       let firstAviary = bird.aviaries[firstDate],
                       aviary != firstAviary {
                        HomeBirdDetailAviaryCellView(aviary: aviary) {
                            action(aviary)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
