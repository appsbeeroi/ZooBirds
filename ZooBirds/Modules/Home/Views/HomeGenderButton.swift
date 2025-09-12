import SwiftUI

struct HomeGenderButton: View {
    
    let gender: Gender
    let isSwitchOffed: Bool
    
    @Binding var selectedGender: Gender?
    
    init(
        gender: Gender,
        isSwitchOffed: Bool = false,
        selectedGender: Binding<Gender?>
    ) {
        self.gender = gender
        self.isSwitchOffed = isSwitchOffed
        self._selectedGender = selectedGender
    }
    
    var body: some View {
        Button {
            if isSwitchOffed {
                selectedGender = selectedGender == gender ? nil : gender
            } else {
                selectedGender = gender
            }
        } label: {
            HStack(spacing: 2) {
                Image(gender.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(gender.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.defaultWhite)
            }
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .background(selectedGender == gender ? .defaultLightBlue : .defaultBlue)
            .cornerRadius(14)
        }
    }
}
