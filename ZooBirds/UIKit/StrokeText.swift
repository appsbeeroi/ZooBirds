import SwiftUI

struct StrokeText: View {
    
    let text: String
    let fontSize: CGFloat
    let firstColor: Color?
    let secondColor: Color?
    let lineLimit: Int?
    
    init(
        _ text: String,
        fontSize: CGFloat,
        firstColor: Color? = nil,
        secondColor: Color? = nil,
        lineLimit: Int? = nil
    ) {
        self.text = text
        self.fontSize = fontSize
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        ZStack {
            Group {
                Text(text).offset(x: -2, y: -2)
                Text(text).offset(x: 0, y: -2)
                Text(text).offset(x: 2, y: -2)
                Text(text).offset(x: -2, y: 0)
                Text(text).offset(x: 2, y: 0)
                Text(text).offset(x: -2, y: 2)
                Text(text).offset(x: 0, y: 2)
                Text(text).offset(x: 2, y: 2)
                Text(text).offset(x: 0, y: 3)
                Text(text).offset(x: 0, y: 3)
                Text(text).offset(x: -1, y: 3)
                Text(text).offset(x: -2, y: 3)
                Text(text).offset(x: 1, y: 3)
                Text(text).offset(x: 2, y: 3)
            }
            .font(.system(size: fontSize, weight: .bold))
            .foregroundStyle(.defaultBrown)
            .multilineTextAlignment(.center)
            .lineSpacing(0)
            
            Text(text)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .defaultWhite,
                            .defaultYellow
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .multilineTextAlignment(.center)
                .lineLimit(lineLimit)
                .lineSpacing(0)
        }
    }
}

#Preview {
    ZStack {
        Color.black
        
        StrokeText("FIND THESE", fontSize: 56)
    }
}
