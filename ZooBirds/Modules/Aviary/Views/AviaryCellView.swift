import SwiftUI
import SwipeActions

struct AviaryCellView: View {
    
    let aviary: Aviary
    let action: () -> Void
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
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
                            
                            HStack(spacing: 6) {
                                ForEach(Array(aviary.species.enumerated()), id: \.offset) { index, specie in
                                    if index < 3 {
                                        if specie != "" {
                                            Text(specie)
                                                .frame(height: 31)
                                                .padding(.horizontal, 10)
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundStyle(.defaultWhite)
                                                .background(.defaultLightBlue)
                                                .cornerRadius(9)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        }
                        
                        HStack {
                            Group {
                            Text(aviary.name)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.defaultWhite)
                            
                                HStack(spacing: 5) {
                                    Image(.Images.Icons.size)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 8, height: 8)
                                    
                                    Text("\(aviary.size) m")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(.defaultWhite)
                                }
                            }
                            .frame(height: 26)
                            .padding(.horizontal, 10)
                            .background(.defaultLightBlue)
                            .cornerRadius(8)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.defaultWhite)
                }
                .padding(8)
                .frame(maxHeight: 110)
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

#Preview {
    AviaryCellView(aviary: Aviary(isMock: true)) {} editAction: {} removeAction: {}
}
