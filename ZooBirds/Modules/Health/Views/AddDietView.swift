import SwiftUI

struct AddDietView: View {

    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var viewModel: HealthViewModel
    
    @State var diet: Diet
    
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
                        foodType
                        quantity
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
            diet.birdIDs = birdIDs
        }
    }
    
    private var navigation: some View {
        ZStack {
            Text("Add ration")
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
                        viewModel.save(diet)
                    } label: {
                        Text("Done")
                            .foregroundStyle(.defaultYellow.opacity(diet.isLock ? 0.5 : 1))
                    }
                    .disabled(diet.isLock)
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
        Image(.Images.Health.diet)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private var datePicker: some View {
        VStack(spacing: 2) {
            Text("Feeding Time")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            DatePicker("", selection: $diet.date, displayedComponents: [.hourAndMinute])
                .labelsHidden()
                .datePickerStyle(.wheel)
                .colorScheme(.dark)
        }
    }
    
    private var foodType: some View {
        VStack(spacing: 2) {
            Text("Food type")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $diet.foodType, isFocused: $isFocused)
        }
    }
    
    private var quantity: some View {
        VStack(spacing: 2) {
            Text("Quantity")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $diet.quontity, keyboardType: .numberPad, isFocused: $isFocused)
        }
    }
    
    private var notes: some View {
        VStack(spacing: 2) {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $diet.notes, isFocused: $isFocused)
        }
    }
}

#Preview {
    AddDietView(diet: Diet(isMock: true), birdIDs: [])
}
