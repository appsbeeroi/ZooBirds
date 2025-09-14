import SwiftUI

struct AddVaccinationView: View {

    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var viewModel: HealthViewModel
    
    @State var vaccination: Vaccination
    
    let birdIDs: [UUID]
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        image
                        datePicker
                        vaccine
                        notes
                    }
                    .padding(.top, 35)
                    .padding(.horizontal, 35)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Button("Done") {
                                    isFocused = false
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    
                    Color.clear
                        .frame(height: 30)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            vaccination.birdIDs = birdIDs
        }
    }
    
    private var navigation: some View {
        ZStack {
            Text("Add vaccination")
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
                        viewModel.save(vaccination)
                    } label: {
                        Text("Done")
                            .foregroundStyle(.defaultYellow.opacity(vaccination.isLock ? 0.5 : 1))
                    }
                    .disabled(vaccination.isLock)
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
    
    private var image: some View {
        Image(.Images.Health.vaccination)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private var datePicker: some View {
        DatePicker("", selection: $vaccination.date, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.wheel)
            .colorScheme(.dark)
    }
    
    private var vaccine: some View {
        VStack(spacing: 2) {
            Text("Vaccine")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $vaccination.vaccine, isFocused: $isFocused)
        }
    }
    
    private var notes: some View {
        VStack(spacing: 2) {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $vaccination.notes, isFocused: $isFocused)
        }
    }
}

#Preview {
    AddVaccinationView(vaccination: Vaccination(isMock: true), birdIDs: [])
}
