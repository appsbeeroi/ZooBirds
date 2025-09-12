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
                    .scaleEffect(5)
                
                StrokeText("Zoo\nBirds", fontSize: 78)
            }
        }
    }
}

#Preview {
    SplashScreen(isMainFlow: .constant(false))
}
