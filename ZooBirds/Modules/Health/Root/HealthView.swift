import SwiftUI

struct HealthView: View {
    
    @StateObject private var viewModel = HealthViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State var inspectionToEdit: Inspection?
    @State var vaccinationToEdit: Vaccination?
    @State var dietToEdit: Diet?
    
    @State private var selectedActionType: HealthActionType = .diet
    
    @State private var isShowBirdsList = false
    @State private var isShowAddInspectionView = false
    @State private var isShowAddVaccinationView = false
    @State private var isShowAddDietView = false
    @State private var isShowInspectionDetailView = false
    @State private var isShowVaccinataionDetailView = false
    @State private var isShowDietDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.defaultDarkBlue
                    .ignoresSafeArea()
                
                VStack {
                    navigation
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            inspection
                            vaccination
                            diets
                        }
                        .padding(.top, 30)
                        .padding(.horizontal, 35)
                        
                        Color.clear
                            .frame(height: 100)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .animation(.easeInOut, value: viewModel.inspections)
                .animation(.easeInOut, value: viewModel.vaccinations)
                .animation(.easeInOut, value: viewModel.diets)
            }
            .navigationDestination(isPresented: $isShowBirdsList) {
                HealthBirdsListView(actionType: selectedActionType, birds: viewModel.birds)
            }
            .navigationDestination(isPresented: $isShowAddInspectionView) {
                AddInspectionView(
                    inspection: inspectionToEdit ?? Inspection(isMock: false),
                    birdIDs: inspectionToEdit?.birdIDs ?? [])
            }
            .navigationDestination(isPresented: $isShowAddVaccinationView) {
                AddVaccinationView(
                    vaccination: vaccinationToEdit ?? Vaccination(isMock: false),
                    birdIDs: vaccinationToEdit?.birdIDs ?? [])
            }
            .navigationDestination(isPresented: $isShowAddDietView) {
                AddDietView(
                    diet: dietToEdit ?? Diet(isMock: false),
                    birdIDs: dietToEdit?.birdIDs ?? [])
            }
            .navigationDestination(isPresented: $isShowInspectionDetailView) {
                HealthInspectionDetailView(inspection: inspectionToEdit ?? Inspection(isMock: false))
            }
            .navigationDestination(isPresented: $isShowVaccinataionDetailView) {
                HealthVaccinationDetailView(vaccination: vaccinationToEdit ?? Vaccination(isMock: false))
            }
            .navigationDestination(isPresented: $isShowDietDetailView) {
                HealthDietDetailView(diet: dietToEdit ?? Diet(isMock: false))
            }
            .onAppear {
                isShowTabBar = true
                inspectionToEdit = nil
                vaccinationToEdit = nil
                dietToEdit = nil
                viewModel.loadData()
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    isShowBirdsList = false
                    isShowAddDietView = false
                    isShowAddInspectionView = false
                    isShowAddVaccinationView = false
                    isShowInspectionDetailView = false
                    isShowVaccinataionDetailView = false
                    isShowDietDetailView = false
                    viewModel.isCloseNavigation = false
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        VStack(spacing: 8) {
            Text("Health & nutrition")
                .frame(maxWidth: .infinity)
                .foregroundStyle(.defaultWhite)
                .font(.system(size: 17, weight: .heavy))
            
            Rectangle()
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.defaultWhite.opacity(0.1))
        }
        .padding(.top, 13)
    }
    
    private var inspection: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Inspection log")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.defaultGray)
                
                Button {
                    isShowTabBar = false
                    selectedActionType = .inspection
                    isShowBirdsList.toggle()
                } label: {
                    Text("+ Add")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.defaultYellow)
                }
            }
            
            if viewModel.inspections.isEmpty {
                VStack {
                    Image(.Images.Health.inspection)
                        .resizable()
                        .scaledToFit()
                    
                    Text("There’s nothing here\nyet")
                        .padding(.bottom, 8)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultWhite)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 113)
                .frame(maxWidth: .infinity)
                .background(.defaultBlue)
                .cornerRadius(15)
            } else {
                LazyVStack(spacing: 5) {
                    ForEach(viewModel.inspections) { inspection in
                        HealthInspectionCellView(inspection: inspection, birds: viewModel.birds) {
                            isShowTabBar = false
                            inspectionToEdit = inspection
                            isShowInspectionDetailView.toggle()
                        } editAction: {
                            isShowTabBar = false
                            inspectionToEdit = inspection
                            isShowAddInspectionView.toggle()
                        } removeAction: {
                            viewModel.remove(inspection)
                        }
                    }
                }
            }
        }
    }
    
    private var vaccination: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Vaccination plan")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.defaultGray)
                
                Button {
                    isShowTabBar = false
                    selectedActionType = .vaccination
                    isShowBirdsList.toggle()
                } label: {
                    Text("+ Add")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.defaultYellow)
                }
            }
            
            if viewModel.vaccinations.isEmpty {
                VStack {
                    Image(.Images.Health.vaccination)
                        .resizable()
                        .scaledToFit()
                    
                    Text("There’s nothing here\nyet")
                        .padding(.bottom, 8)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultWhite)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 113)
                .frame(maxWidth: .infinity)
                .background(.defaultBlue)
                .cornerRadius(15)
            } else {
                LazyVStack(spacing: 5) {
                    ForEach(viewModel.vaccinations) { vaccination in
                        HealthVaccinationCellView(vaccination: vaccination, birds: viewModel.birds) {
                            isShowTabBar = false
                            vaccinationToEdit = vaccination
                            isShowVaccinataionDetailView.toggle()
                        } editAction: {
                            isShowTabBar = false
                            vaccinationToEdit = vaccination
                            isShowAddVaccinationView.toggle()
                        } removeAction: {
                            viewModel.remove(vaccination)
                        }
                    }
                }
            }
        }
    }
    
    private var diets: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Diet")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.defaultGray)
                
                Button {
                    isShowTabBar = false
                    selectedActionType = .diet
                    isShowBirdsList.toggle()
                } label: {
                    Text("+ Add")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.defaultYellow)
                }
            }
            
            if viewModel.diets.isEmpty {
                VStack {
                    Image(.Images.Health.diet)
                        .resizable()
                        .scaledToFit()
                    
                    Text("There’s nothing here\nyet")
                        .padding(.bottom, 8)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.defaultWhite)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 113)
                .frame(maxWidth: .infinity)
                .background(.defaultBlue)
                .cornerRadius(15)
            } else {
                LazyVStack(spacing: 5) {
                    ForEach(viewModel.diets) { diet in
                        HealthDietCellView(diet: diet, birds: viewModel.birds) {
                            isShowTabBar = false
                            dietToEdit = diet
                            isShowDietDetailView.toggle()
                        } editAction: {
                            isShowTabBar = false
                            dietToEdit = diet
                            isShowAddDietView.toggle()
                        } removeAction: {
                            viewModel.remove(diet)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HealthView(isShowTabBar: .constant(true))
}
