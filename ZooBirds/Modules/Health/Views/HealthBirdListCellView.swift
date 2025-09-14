import SwiftUI

struct HealthBirdListCellView: View {
    
    let bird: Bird
    
    @Binding var selectedBirds: [Bird]
    
    var body: some View {
        Button {
            if let index = selectedBirds.firstIndex(where: { $0.id == bird.id }) {
                selectedBirds.remove(at: index)
            } else {
                selectedBirds.append(bird)
            }
        } label: {
            HStack(spacing: 0) {
                VStack(spacing: 6) {
                    HStack(spacing: 3) {
                        if let image = bird.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 63, height: 63)
                                .clipped()
                                .cornerRadius(300)
                                .overlay {
                                    Circle()
                                        .stroke(.defaultLightBlue, lineWidth: 1)
                                }
                        }
                        
                        Text(bird.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundStyle(.defaultWhite)
                    }
                    
                    HStack(spacing: 4) {
                        Text(bird.nameID)
                            .frame(height: 26)
                            .padding(.horizontal, 5)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.defaultYellow)
                            .background(.defaultLightBlue)
                            .cornerRadius(9)
                        
                        if let gender = bird.gender {
                            Image(gender.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 17, height: 17)
                                .frame(height: 26)
                                .padding(.horizontal, 8)
                                .background(.defaultLightBlue)
                                .cornerRadius(9)
                        }
                        
                        HStack(spacing: 4) {
                            if let status = bird.status {
                                Image(systemName: status.icon)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(.defaultWhite)
                                
                                Text(status.title)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(.defaultWhite)
                            }
                        }
                        .frame(height: 26)
                        .padding(.horizontal, 10)
                        .background(.defaultLightBlue)
                        .cornerRadius(9)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Circle()
                    .stroke(.defaultYellow, lineWidth: 1)
                    .frame(width: 26, height: 26)
                    .overlay {
                        if selectedBirds.contains(bird) {
                            Circle()
                                .frame(width: 14, height: 14)
                                .foregroundStyle(.defaultYellow)
                        }
                    }
            }
            .padding(8)
            .background(.defaultBlue)
            .cornerRadius(20)
        }
    }
}
