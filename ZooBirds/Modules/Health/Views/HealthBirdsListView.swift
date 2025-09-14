import SwiftUI

struct HealthBirdsListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let actionType: HealthActionType
    let birds: [Bird]
    
    @State private var selectedBirds: [Bird] = []
    
    @State private var isShowAddInspectionView = false
    @State private var isShowAddVaccinationView = false
    @State private var isShowAddDietView = false
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        image
                        birdsList
                    }
                    .padding(.top, 35)
                    .padding(.horizontal, 35)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowAddInspectionView) {
            AddInspectionView(inspection: Inspection(isMock: false), birdIDs: selectedBirds.map { $0.id })
        }
        .navigationDestination(isPresented: $isShowAddVaccinationView) {
            AddVaccinationView(vaccination: Vaccination(isMock: false), birdIDs: selectedBirds.map { $0.id })
        }
        .navigationDestination(isPresented: $isShowAddDietView) {
            AddDietView(diet: Diet(isMock: false), birdIDs: selectedBirds.map { $0.id })
        }
    }
    
    private var navigation: some View {
        ZStack {
            Text(actionType.title)
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
                        switch actionType {
                            case .inspection:
                                isShowAddInspectionView.toggle()
                            case .vaccination:
                                isShowAddVaccinationView.toggle()
                            case .diet:
                                isShowAddDietView.toggle()
                        }
                    } label: {
                        Text("Next")
                            .foregroundStyle(.defaultYellow.opacity(selectedBirds.isEmpty ? 0.5 : 1))
                    }
                    .disabled(selectedBirds.isEmpty)
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
        Image(actionType.icon)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private var birdsList: some View {
        LazyVStack(spacing: 8) {
            ForEach(birds) { bird in
                HealthBirdListCellView(bird: bird, selectedBirds: $selectedBirds)
            }
        }
    }
}

#Preview {
    HealthBirdsListView(actionType: .diet, birds: [Bird(isMock: true)])
}

