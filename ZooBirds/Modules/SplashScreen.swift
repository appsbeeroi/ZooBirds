import SwiftUI

struct SplashScreen: View {
    
    @Binding var isMainFlow: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resizeAndFill()
            
            VStack {
                ProgressView()
                    .tint(.defaultYellow)
                    .scaleEffect(4)
                
                StrokeText("Zoo\nBirds", fontSize: 78)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isMainFlow = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isMainFlow: .constant(false))
}
