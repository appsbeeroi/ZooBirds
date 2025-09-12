import SwiftUI
import SwipeActions

struct HomeBirdCellView: View {
    
    let bird: Bird
    let action: () -> Void
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            Button {
                action()
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
                    
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.defaultWhite)
                }
                .padding(8)
                .background(.defaultBlue)
                .cornerRadius(20)
            }
        } trailingActions: { context in
            HStack(spacing: 4) {
                Button {
                    context.state.wrappedValue = .closed
                    editAction()
                } label: {
                    Image(.Images.Icons.edit)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 42)
                }
                
                Button {
                    context.state.wrappedValue = .closed
                    removeAction()
                } label: {
                    Image(.Images.Icons.remove)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 42)
                }
            }
        }
        .swipeMinimumDistance(30)
    }
}
