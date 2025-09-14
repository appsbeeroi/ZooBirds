import SwiftUI

struct AddAviaryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: AviaryViewModel
    
    @State var aviary: Aviary
    
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
                        nameBlock
                        sizeBlock
                        speciesBlock
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
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $aviary.image)
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
                        viewModel.save(aviary)
                    } label: {
                        Text("Done")
                            .foregroundStyle(.defaultYellow.opacity(aviary.isLock ? 0.5 : 1))
                    }
                    .disabled(aviary.isLock)
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
                if let image = aviary.image {
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
    
    private var nameBlock: some View {
        VStack(spacing: 2) {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $aviary.name, isFocused: $isFocused)
        }
    }
    
    private var sizeBlock: some View {
        VStack(spacing: 2) {
            Text("Size")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            BaseTextField(text: $aviary.size, keyboardType: .numberPad, isFocused: $isFocused)
        }
    }
    
    private var speciesBlock: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Compatible Species")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.defaultGray)
                
                Button {
                    if aviary.species.last != "" {
                        aviary.species.append("")
                    }
                } label: {
                    Text("+ Add")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.defaultYellow.opacity(aviary.species.count > 0 && aviary.species.last == "" ? 0.5 : 1))
                }
                .disabled(aviary.species.count > 0 && aviary.species.last == "")
            }
            
            LazyVStack(spacing: 5) {
                ForEach(Array(aviary.species.enumerated()), id: \.offset) { index, specie in
                    BaseTextField(text: $aviary.species[index], isFocused: $isFocused)
                }
            }
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 9)
        .background(.defaultSecondBlue)
        .cornerRadius(20)
        .animation(.easeInOut, value: aviary.species)
    }
}

#Preview {
    AddAviaryView(aviary: Aviary(isMock: true))
}

#Preview {
    AddAviaryView(aviary: Aviary(isMock: false))
}
