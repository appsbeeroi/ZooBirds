import SwiftUI

struct AviaryView: View {
    
    @StateObject var viewModel = AviaryViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var aviaryToEdit: Aviary?
    
    @State private var isShowAddView = false
    @State private var isShowDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.defaultDarkBlue
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    navigation
                    
                    if viewModel.aviaries.isEmpty {
                        stumb
                    } else {
                        aviaries
                    }
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .animation(.easeInOut, value: viewModel.aviaries)
            }
            .navigationDestination(isPresented: $isShowAddView) {
                AddAviaryView(aviary: aviaryToEdit ?? Aviary(isMock: false))
            }
            .navigationDestination(isPresented: $isShowDetailView) {
                AviaryDetailView(aviary: aviaryToEdit ?? Aviary(isMock: false))
            }
            .onAppear {
                isShowTabBar = true
                aviaryToEdit = nil
                viewModel.loadAviaries()
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    isShowAddView = false
                    viewModel.isCloseNavigation = false
                    isShowDetailView = false
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        VStack(spacing: 8) {
            Text("Aviary & Maintenance")
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
    
    private var stumb: some View {
        ZStack {
            Image(.Images.Aviary.birds)
                .resizable()
                .scaledToFit()
                .frame(width: 246, height: 371)
                .offset(y: -100)
            
            VStack(spacing: 16) {
                Text("There’s nothing here\nyet")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.defaultWhite)
                    .multilineTextAlignment(.center)
                
                addButton
            }
            .offset(y: 120)
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 16)
        .background(.defaultBlue)
        .cornerRadius(20)
        .padding(.horizontal, 35)
        .frame(maxHeight: .infinity)
    }
    
    private var addButton: some View {
        Button {
            isShowTabBar = false
            isShowAddView = true
        } label: {
            Text("Add Aviary")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.black)
                .background(.defaultWhite)
                .cornerRadius(20)
        }
    }
    
    private var aviaries: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                Text("Aviary")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 17, weight: .heavy))
                    .foregroundStyle(.defaultWhite)
                
                ForEach(viewModel.aviaries) { aviary in
                    AviaryCellView(aviary: aviary) {
                        isShowTabBar = false
                        aviaryToEdit = aviary
                        isShowDetailView = true
                    } editAction: {
                        isShowTabBar = false
                        aviaryToEdit = aviary
                        isShowAddView = true
                    } removeAction: {
                        viewModel.remove(aviary)
                    }
                }
                
                addButton
            }
            .padding(.top, 30)
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    AviaryView(isShowTabBar: .constant(false))
}

