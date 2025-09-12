import SwiftUI

struct AviaryAddCareView: View {
    
    @Environment(\.dismiss) var dismiss

    @State var care: AviaryCare
    
    let saveAction: (AviaryCare) -> Void 
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        datePicker
                        careType
                        frequancyType
                        note
                    }
                    .padding(.horizontal, 35)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        ZStack {
            Text("Add aviary")
                .frame(maxWidth: .infinity)
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            VStack(spacing: 8) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 22, weight: .regular))
                            
                            Text("Back")
                                .font(.system(size: 16, weight: .regular))
                        }
                        .foregroundStyle(.defaultYellow)
                    }
                    
                    Spacer()
                    
                    Button {
                        saveAction(care)
                        dismiss()
                    } label: {
                        Text("Done")
                            .foregroundStyle(.defaultYellow.opacity(care.isLock ? 0.5 : 1))
                    }
                    .disabled(care.isLock)
                }
                .padding(.horizontal, 20)
                .font(.system(size: 17, weight: .heavy))
                
                Rectangle()
                    .frame(height: 0.5)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.defaultWhite.opacity(0.1))
            }
            .padding(.top, 13)
        }
    }
    
    private var datePicker: some View {
        VStack(spacing: 2) {
            Text("Time")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            DatePicker("", selection: $care.time, displayedComponents: [.hourAndMinute])
                .labelsHidden()
                .datePickerStyle(.wheel)
                .colorScheme(.dark)
        }
    }
    
    private var careType: some View {
        VStack(spacing: 5) {
            Text("Type of care")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            ForEach(CareType.allCases) { type in
                AviaryAddCareTypeCellView(type: type, selectedType: $care.type)
            }
        }
    }
    
    private var frequancyType: some View {
        VStack(spacing: 5) {
            Text("Frequancy")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            HStack(spacing: 4) {
                AviaryAddCareFrequancyCellView(type: .daily, selectedType: $care.frequancy)
                AviaryAddCareFrequancyCellView(type: .every2days, selectedType: $care.frequancy)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 4) {
                AviaryAddCareFrequancyCellView(type: .every3days, selectedType: $care.frequancy)
                AviaryAddCareFrequancyCellView(type: .twiceAWeek, selectedType: $care.frequancy)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 4) {
                AviaryAddCareFrequancyCellView(type: .weekly, selectedType: $care.frequancy)
                AviaryAddCareFrequancyCellView(type: .every10days, selectedType: $care.frequancy)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 4) {
                AviaryAddCareFrequancyCellView(type: .asNeeded, selectedType: $care.frequancy)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var note: some View {
        VStack(spacing: 5) {
            Text("Note(optional)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $care.note, isFocused: $isFocused)
        }
    }
}

#Preview {
    AviaryAddCareView(care: AviaryCare(isMock: true)) { _ in }
}
