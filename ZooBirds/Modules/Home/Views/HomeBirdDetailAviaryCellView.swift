import SwiftUI

struct HomeBirdDetailAviaryCellView: View {
    
    let aviary: Aviary
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                VStack(spacing: 4) {
                    HStack {
                        if let image = aviary.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 63, height: 63)
                                .clipped()
                                .cornerRadius(300)
                                .overlay {
                                    Circle()
                                        .stroke(.defaultGray, lineWidth: 1)
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 5) {
                        Image(.Images.Icons.size)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 8)
                        
                        Text("\(aviary.size) m")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.defaultWhite)
                    }
                    .frame(height: 26)
                    .padding(.horizontal, 10)
                    .background(.defaultLightBlue)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Circle()
                    .stroke(.defaultYellow, lineWidth: 1)
                    .frame(width: 24, height: 24)
            }
            .padding(8)
            .frame(maxHeight: 110)
            .background(.defaultBlue)
            .cornerRadius(20)
        }
    }
}
