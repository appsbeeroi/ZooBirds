import SwiftUI

struct AddInspectionView: View {

    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var viewModel: HealthViewModel
    
    @State var inspection: Inspection
    
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
                        vet
                        procedure
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
            inspection.birdIDs = birdIDs
        }
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
                        viewModel.save(inspection)
                    } label: {
                        Text("Done")
                            .foregroundStyle(.defaultYellow.opacity(inspection.isLock ? 0.5 : 1))
                    }
                    .disabled(inspection.isLock)
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
        Image(.Images.Health.inspection)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private var datePicker: some View {
        DatePicker("", selection: $inspection.date, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.wheel)
            .colorScheme(.dark)
    }
    
    private var vet: some View {
        VStack(spacing: 2) {
            Text("Vet")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $inspection.vet, isFocused: $isFocused)
        }
    }
    
    private var procedure: some View {
        VStack(spacing: 2) {
            Text("Procedure")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $inspection.procedure, isFocused: $isFocused)
        }
    }
    
    private var notes: some View {
        VStack(spacing: 2) {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $inspection.notes, isFocused: $isFocused)
        }
    }
}

#Preview {
    AddInspectionView(inspection: Inspection(isMock: true), birdIDs: [])
}



