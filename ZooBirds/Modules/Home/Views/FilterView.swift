import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var filter: FilterModel
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                grabber
                
                VStack(spacing: 18) {
                    gender
                    age
                    status
                }
                .padding(.horizontal, 35)
            }
            .padding(.top, 10)
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var grabber: some View {
        VStack(spacing: 7) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 36, height: 5)
                .foregroundStyle(.defaultGray)
            
            ZStack {
                Text("Filter")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.defaultWhite)
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundStyle(.white.opacity(0.3))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(height: 30)
            .padding(.horizontal, 14)
        }
    }
    
    private var gender: some View {
        VStack(spacing: 5) {
            Text("Gender")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            HStack(spacing: 4) {
                ForEach(Gender.allCases) { gender in
                    HomeGenderButton(gender: gender, isSwitchOffed: true, selectedGender: $filter.gender)
                }
            }
        }
    }
    
    private var status: some View {
        VStack(spacing: 5) {
            Text("Status")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            GeometryReader { geo in
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        BirdStatusButton(status: .display, isSwitchOffed: true, selectedStatus: $filter.status)
                        BirdStatusButton(status: .quarantine, isSwitchOffed: true, selectedStatus: $filter.status)
                    }
                    
                    HStack {
                        BirdStatusButton(status: .aviary, isSwitchOffed: true, selectedStatus: $filter.status)
                            .frame(width: geo.size.width / 2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
    
    private var age: some View {
        VStack(spacing: 5) {
            Text("Age")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            HStack(spacing: 5) {
                ForEach(AgeType.allCases) { type in
                    Button {
                        filter.age = filter.age == type ? nil : type
                    } label: {
                        Text(type.title)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.defaultWhite)
                            .padding(.leading, 8)
                            .background(filter.age == type ? .defaultLightBlue : .defaultBlue)
                            .cornerRadius(14)
                    }
                }
            }
        }
    }
}

#Preview {
    FilterView(filter: .constant(FilterModel()))
}
