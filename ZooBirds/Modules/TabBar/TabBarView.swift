import SwiftUI

struct TabBarView: View {
    
    @State private var selectedState: TabBarState = .home
    @State private var isShowTabBar = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedState) {
                HomeView(isShowTabBar: $isShowTabBar)
                    .tag(TabBarState.home)
                
                HealthView(isShowTabBar: $isShowTabBar)
                    .tag(TabBarState.health)
                
                AviaryView(isShowTabBar: $isShowTabBar)
                    .tag(TabBarState.aviary)
                
                SettingsView(isShowTabBar: $isShowTabBar)
                    .tag(TabBarState.settings)
            }
            
            GeometryReader { _ in
                VStack {
                    HStack(spacing: 30) {
                        ForEach(TabBarState.allCases) { state in
                            Button {
                                selectedState = state
                            } label: {
                                VStack(spacing: 9) {
                                    Image(state.icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(state == selectedState ? .defaultYellow : .defaultWhite)
                                    
                                    Text(state.title)
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundStyle(state == selectedState ? .defaultYellow : .defaultWhite)
                                }
                                .frame(width: 52, height: 65)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 25)
                    .background(.defaultBlue)
                    .opacity(isShowTabBar ? 1 : 0)
                    .animation(.easeInOut, value: isShowTabBar)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    TabBarView()
}
