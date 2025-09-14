import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var birdtToEdit: Bird?
    @State private var isShowAddView = false
    @State private var isShowDetailView = false
    @State private var isShowFilter = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.defaultDarkBlue
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    navigation
                    
                    if !viewModel.baseBirds.isEmpty {
                        filterTextField
                    }
                    
                    if viewModel.birds.isEmpty {
                        stumb
                    } else {
                        birds
                    }
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .animation(.easeInOut, value: viewModel.birds)
            }
            .navigationDestination(isPresented: $isShowAddView) {
                HomeAddBirdView(bird: birdtToEdit ?? Bird(isMock: false))
            }
            .navigationDestination(isPresented: $isShowDetailView) {
                HomeBirdDetailView(bird: birdtToEdit ?? Bird(isMock: false))
            }
            .onAppear {
                isShowTabBar = true
                birdtToEdit = nil
                viewModel.loadBirds()
            }
            .sheet(isPresented: $isShowFilter) {
                FilterView(filter: $viewModel.filter)
                    .presentationDetents([.medium])
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    isShowAddView = false
                    isShowDetailView = false
                    viewModel.isCloseNavigation = false
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Catalogue of birds")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.defaultWhite)
                
                if !viewModel.baseBirds.isEmpty {
                    Button {
                        isShowFilter.toggle()
                    } label: {
                        Text("Filter")
                            .foregroundStyle(.defaultYellow)
                    }
                }
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
    
    private var filterTextField: some View {
        BaseTextField(text: $viewModel.filterText, isFocused: $isFocused)
            .padding(.top, 16)
            .padding(.horizontal, 35)
    }
    
    private var stumb: some View {
        ZStack {
            Image(.Images.Home.birds)
                .resizable()
                .scaledToFit()
                .frame(width: 246, height: 371)
                .offset(y: -100)
            
            VStack(spacing: 16) {
                Text("You do not have any birds in\nthe catalogue yet")
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
        .padding(.bottom, viewModel.baseBirds.isEmpty ? 0 : 30)
    }
    
    private var addButton: some View {
        Button {
            isShowTabBar = false
            isShowAddView = true
        } label: {
            Text("Add bird")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.black)
                .background(.defaultWhite)
                .cornerRadius(20)
        }
    }
    
    private var birds: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 11) {
                ForEach(viewModel.birds) { bird in
                    HomeBirdCellView(bird: bird) {
                        birdtToEdit = bird
                        isShowTabBar = false
                        isShowDetailView = true
                    } editAction: {
                        birdtToEdit = bird
                        isShowTabBar = false
                        isShowAddView = true
                    } removeAction: {
                        viewModel.remove(bird)
                    }
                }
                
                addButton
            }
            .padding(.top, 30)
            .padding(.horizontal, 35)
            
            Color.clear
                .frame(height: 100)
        }
    }
}

#Preview {
    HomeView(isShowTabBar: .constant(false))
}





