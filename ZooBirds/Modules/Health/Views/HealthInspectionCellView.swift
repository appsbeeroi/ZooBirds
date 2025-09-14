import SwiftUI
import SwipeActions

struct HealthInspectionCellView: View {
    
    let inspection: Inspection
    let birds: [Bird]
    
    let action: () -> Void
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            Button {
                action()
            } label: {
                HStack {
                    let firstFreeBirds = birds.filter { inspection.birdIDs.contains($0.id) }.prefix(3)
                    
                    ZStack {
                        HStack(spacing: -20) {
                            ForEach(firstFreeBirds) { bird in
                                if let image = bird.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 44, height: 44)
                                        .clipped()
                                        .cornerRadius(22)
                                        .overlay {
                                            Circle()
                                                .stroke(.defaultGray, lineWidth: 1)
                                        }
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 4) {
                        Text(inspection.vet)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.defaultWhite)
                        
                        Text(inspection.date.formatted(.dateTime.year().month(.twoDigits).day()))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.defaultGray)
                        
                    }
                    
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.defaultWhite)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 8)
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
    HealthInspectionCellView(inspection: Inspection(isMock: true), birds: [Bird(isMock: true)]) {} editAction: {} removeAction: {}
}
