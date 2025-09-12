import SwiftUI
import SwipeActions

struct AviaryCareCellView: View {
    
    let care: AviaryCare
    let action: () -> Void
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            Button {
                action()
            } label: {
                HStack(spacing: 8) {
                    HStack {
                        VStack(spacing: 5) {
                            Text(care.type?.title ?? "N/A")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.defaultWhite)
                            
                            Text(care.time.formatted(.dateTime.year().month(.twoDigits).day()))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.defaultGray)
                        }
                        
                        Text(care.frequancy?.title ?? "N/A")
                            .frame(height: 35)
                            .padding(.horizontal, 7)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.defaultWhite)
                            .background(.defaultLightBlue)
                            .cornerRadius(9)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                }
                .frame(height: 71)
                .padding(.vertical, 13)
                .padding(.horizontal, 10)
                .background(.defaultBlue)
                .cornerRadius(18)
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
    AviaryCareCellView(care: AviaryCare(isMock: true)) {} editAction: {} removeAction: {}
}
