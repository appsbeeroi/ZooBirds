import SwiftUI

struct AviaryHistoryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                stumb
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 22, weight: .regular))
                        
                        Text("Back")
                            .font(.system(size: 16, weight: .regular))
                    }
                    .foregroundStyle(.defaultYellow)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .font(.system(size: 17, weight: .heavy))
            
            Rectangle()
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.defaultWhite.opacity(0.1))
        }
        .padding(.top, 13)
    }
    
    private var stumb: some View {
        VStack(spacing: 16) {
            Image(.Images.Aviary.movement)
                .resizable()
                .scaledToFit()
                .frame(width: 246, height: 371)
            
            Text("There’s nothing here\nyet")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.defaultWhite)
                .multilineTextAlignment(.center)
                .offset(y: -20)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(.defaultBlue)
        .cornerRadius(20)
        .padding(.horizontal, 35)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    AviaryHistoryView()
}
