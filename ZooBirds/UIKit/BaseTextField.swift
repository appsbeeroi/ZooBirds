import SwiftUI

struct BaseTextField: View {
    
    @Binding var text: String
    
    let keyboardType: UIKeyboardType
    
    @FocusState.Binding var isFocused: Bool
    
    init(
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.keyboardType = keyboardType
        self._isFocused = isFocused
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text("Write here...")
                .foregroundColor(.defaultWhite.opacity(0.5)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.defaultWhite)
                .keyboardType(keyboardType)
                .focused($isFocused)
            
            if text != "" {
                Button {
                    text = ""
                    isFocused = false 
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.defaultGray.opacity(0.5))
                }
            }
        }
        .frame(height: 56)
        .padding(.horizontal, 12)
        .background(.defaultBlue)
        .cornerRadius(18)
    }
}

#Preview {
    @FocusState var isFocused: Bool
    
    return BaseTextField(text: .constant(""), isFocused: $isFocused)
}
