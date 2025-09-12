import SwiftUI

struct BirdMovementAviariesCellView: View {
    
    let aviary: Aviary
    let nextAviary: Aviary
    let date: Date
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 4) {
                HStack(spacing: 2) {
                    if let image = aviary.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 23, height: 23)
                            .cornerRadius(300)
                            .overlay {
                                Circle()
                                    .stroke(.defaultGray, lineWidth: 1)
                                    .frame(width: 23, height: 23)
                            }
                    }
                    
                    Text(aviary.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.defaultWhite)
                }
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.defaultWhite)
                
                HStack(spacing: 2) {
                    if let image = nextAviary.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 23, height: 23)
                            .cornerRadius(300)
                            .overlay {
                                Circle()
                                    .stroke(.defaultGray, lineWidth: 1)
                                    .frame(width: 23, height: 23)
                            }
                    }
                    
                    Text(nextAviary.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.defaultWhite)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(date.formatted(.dateTime.year().month(.twoDigits).day()))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.defaultGray)
            
            HStack(spacing: 4) {
                Text("Reason")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.defaultGray)
                
                Text("Routine transfer")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.defaultWhite)
            }
        }
        .padding(8)
        .background(.defaultBlue)
        .cornerRadius(20)
    }
}

#Preview {
    BirdMovementAviariesCellView(aviary: Aviary(isMock: true), nextAviary: Aviary(isMock: true), date: Date())
}
