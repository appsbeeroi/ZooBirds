import SwiftUI

struct HealthVaccinationDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: HealthViewModel
    
    @State var vaccination: Vaccination
    
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
                        vaccine
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
                viewModel.remove(vaccination)
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
                    viewModel.save(vaccination)
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
                        AddVaccinationView(vaccination: vaccination, birdIDs: vaccination.birdIDs)
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
        Image(uiImage: .Images.Health.vaccination)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private var vaccine: some View {
        VStack(spacing: 16) {
            Text("Vaccine")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 25, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            VStack(spacing: 0) {
                HStack {
                    Text("Vaccine")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultGray)
                    
                    Text(vaccination.vaccine)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.defaultWhite)
                }
                .frame(height: 44)
                .padding(.horizontal, 12)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.defaultWhite.opacity(0.3))
                
                HStack {
                    Text("Date")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultGray)
                    
                    Text(vaccination.date.formatted(.dateTime.year().month(.twoDigits).day()))
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
                    
                    Text(vaccination.notes)
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
                if vaccination.birdIDs.contains(bird.id) {
                    HealthDetailBirdCellView(bird: bird) {
                        if let index = vaccination.birdIDs.firstIndex(where: { $0 == bird.id }) {
                            vaccination.birdIDs.remove(at: index)
                        }
                    }
                }
            }
        }
    }
}

#Preview(body: {
    HealthVaccinationDetailView(vaccination: Vaccination(isMock: true))
        .environmentObject(HealthViewModel())
})

