import SwiftUI

struct HealthDietDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: HealthViewModel
    
    @State var diet: Diet
    
    @State private var isLoading = false
    @State private var isShowDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        image
                        foodType
                        birds
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 35)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if isLoading {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.defaultGray)
                    .overlay {
                        ProgressView()
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .alert("", isPresented: $isShowDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.remove(diet)
            }
            
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this?")
        }
    }
    
    private var navigation: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    isLoading = true
                    viewModel.save(diet)
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
                
                HStack(spacing: 16) {
                    NavigationLink {
                        AddDietView(diet: diet, birdIDs: diet.birdIDs)
                    } label: {
                        Text("Edit")
                            .foregroundStyle(.blue)
                    }
                    
                    Button {
                        isShowDeleteAlert.toggle()
                    } label: {
                        Text("Delete")
                            .foregroundStyle(.red)
                    }
                }
                .font(.system(size: 17, weight: .regular))
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
    
    private var image: some View {
        Image(uiImage: .Images.Health.diet)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private var foodType: some View {
        VStack(spacing: 16) {
            Text("Diet")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 25, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            VStack(spacing: 0) {
                HStack {
                    Text("Food type")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultGray)
                    
                    Text(diet.foodType)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.defaultWhite)
                }
                .frame(height: 44)
                .padding(.horizontal, 12)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.defaultWhite.opacity(0.3))
                
                HStack {
                    Text("Quantity")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultGray)
                    
                    Text("\(diet.quontity) g")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.defaultWhite)
                }
                .frame(height: 44)
                .padding(.horizontal, 12)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.defaultWhite.opacity(0.3))
                
                HStack {
                    Text("Time")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultGray)
                    
                    Text(diet.date.formatted(.dateTime.hour().minute()))
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.defaultWhite)
                }
                .frame(height: 44)
                .padding(.horizontal, 12)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.defaultWhite.opacity(0.3))
                
                VStack(spacing: 2) {
                    Text("Notes")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultGray)
                    
                    Text(diet.notes)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.defaultWhite)
                        .multilineTextAlignment(.leading)
                }
                .padding(12)
            }
            .padding(.vertical, 12)
            .background(.defaultBlue)
            .cornerRadius(20)
        }
    }
    
    private var birds: some View {
        VStack(spacing: 8) {
            Text("Birds")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            ForEach(viewModel.birds) { bird in
                if diet.birdIDs.contains(bird.id) {
                    HealthDetailBirdCellView(bird: bird) {
                        if let index = diet.birdIDs.firstIndex(where: { $0 == bird.id }) {
                            diet.birdIDs.remove(at: index)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HealthDietDetailView(diet: Diet(isMock: true))
        .environmentObject(HealthViewModel())
}
