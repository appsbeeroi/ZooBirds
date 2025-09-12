import SwiftUI

struct HomeAddBirdView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    @State var bird: Bird
    
    @State private var isShowImagePicker = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 13) {
                        image
                        idBlock
                        nameBlock
                        speciesBlock
                        genderBlock
                        age
                        statusBlock
                        aviaryBlock
                    }
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
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $bird.image)
        }
    }
    
    private var navigation: some View {
        ZStack {
            Text("Add bird")
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
                        viewModel.save(bird)
                    } label: {
                        Text("Done")
                            .foregroundStyle(.defaultYellow.opacity(bird.isLock ? 0.5 : 1))
                    }
                    .disabled(bird.isLock)
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
        Button {
            isShowImagePicker.toggle()
        } label: {
            ZStack {
                if let image = bird.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 123, height: 123)
                        .clipped()
                        .cornerRadius(300)
                } else {
                    Circle()
                        .foregroundStyle(.defaultBlue)
                        .frame(width: 123, height: 123)
                }
                
                Image(systemName: "photo.on.rectangle.angled.fill")
                    .font(.system(size: 60, weight: .medium))
                    .foregroundStyle(.defaultWhite.opacity(0.5))
            }
        }
    }
    
    private var idBlock: some View {
        VStack(spacing: 2) {
            Text("ID")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $bird.nameID, isFocused: $isFocused)
        }
    }
    
    private var nameBlock: some View {
        VStack(spacing: 2) {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $bird.name, isFocused: $isFocused)
        }
    }
    
    private var speciesBlock: some View {
        VStack(spacing: 2) {
            Text("Species")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $bird.species, isFocused: $isFocused)
        }
    }
    
    private var genderBlock: some View {
        VStack(spacing: 2) {
            Text("Gender")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            HStack(spacing: 4) {
                ForEach(Gender.allCases) { gender in
                    HomeGenderButton(gender: gender, selectedGender: $bird.gender)
                }
            }
        }
    }
    
    private var age: some View {
        VStack(spacing: 2) {
            Text("Age")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $bird.age, keyboardType: .numberPad, isFocused: $isFocused)
        }
    }
    
    private var statusBlock: some View {
        VStack(spacing: 2) {
            Text("Status")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    BirdStatusButton(status: .display, selectedStatus: $bird.status)
                    BirdStatusButton(status: .quarantine, selectedStatus: $bird.status)
                }
                
                HStack {
                    BirdStatusButton(status: .aviary, selectedStatus: $bird.status)
                        .frame(width: UIScreen.main.bounds.width - 70 - 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var aviaryBlock: some View {
        VStack(spacing: 8) {
            Text("Aviary")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            if bird.aviaries.count > 0,
               let aviary = bird.aviaries.first?.value {
                AviaryCellView(aviary: aviary) {} editAction: {} removeAction: {}
                    .disabled(true)
            } else {
                aviariesList
            }
        }
    }
    
    private var aviariesList: some View {
        LazyVStack(spacing: 8) {
            ForEach(viewModel.aviaries) { aviary in
                HomeBirdDetailAviaryCellView(aviary: aviary) {
                    bird.aviaries[Date()] = aviary
                }
            }
        }
    }
}



#Preview {
    HomeAddBirdView(bird: Bird(isMock: true))
        .environmentObject(HomeViewModel())
}

#Preview {
    HomeAddBirdView(bird: Bird(isMock: false))
        .environmentObject(HomeViewModel())
}
