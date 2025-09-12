import SwiftUI

struct HomeBirdDetailView: View {
        
    @EnvironmentObject var viewModel: HomeViewModel
    
    @State var bird: Bird
        
    @State private var isShowDeleteAlert = false
    @State private var isToastVisible = false
    @State private var isShowHistory = false
    @State private var isShowLoader = false
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        header
                        mainInfo
                        status
                        aviary
                        
                        if bird.aviaries.count >= 1 && viewModel.aviaries.count > 1 {
                            movements
                        }
                    }
                    .padding(.horizontal, 35)
                    
                    Color.clear
                        .frame(height: 30)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.smooth, value: bird)
            
            if isToastVisible {
                ToastView(text: "Text copied")
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, 12)
                    .zIndex(1)
            }
            
            if isShowLoader {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.defaultGray)
                    .overlay {
                        ProgressView()
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowHistory) {
            AddMovementView(bird: bird, aviaries: viewModel.aviaries) { aviary in
                bird.aviaries[Date()] = aviary
            }
        }
        .alert("", isPresented: $isShowDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.remove(bird)
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
                    isShowLoader = true
                    viewModel.save(bird)
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
                        HomeAddBirdView(bird: bird)
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
    
    private var header: some View {
        VStack(spacing: 16) {
            VStack(spacing: 12) {
                image
                
                Text(bird.name)
                    .font(.system(size: 25, weight: .heavy))
                    .foregroundStyle(.defaultWhite)
            }
            
            Button {
                copyToClipboard(bird.nameID)
            } label: {
                HStack(spacing: 6) {
                    Text(bird.nameID)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.defaultYellow)
                    
                    Image(.Images.Icons.copy)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .background(.defaultBlue)
                .cornerRadius(9)
            }
        }
    }
    
    private var image: some View {
        Image(uiImage: bird.image ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(width: 174, height: 174)
            .clipped()
            .cornerRadius(300)
            .overlay {
                Circle()
                    .stroke(.defaultGray, lineWidth: 1)
            }
    }
    
    private var mainInfo: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Species")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.defaultGray)
                
                Text(bird.species)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.defaultWhite)
            }
            .frame(height: 44)
            .padding(.horizontal, 12)
            
            Rectangle()
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.defaultWhite.opacity(0.3))
            
            HStack {
                Text("Gender")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.defaultGray)
                
                if let gender = bird.gender {
                    HStack(spacing: 2) {
                        Image(gender.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        Text(gender.title)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.defaultWhite)
                    }
                }
            }
            .frame(height: 44)
            .padding(.horizontal, 12)
            
            Rectangle()
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.defaultWhite.opacity(0.5))
            
            HStack {
                Text("Age")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.defaultGray)
                
                Text("\(bird.age) years")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.defaultWhite)
            }
            .frame(height: 44)
            .padding(.horizontal, 12)
        }
        .padding(.vertical, 12)
        .background(.defaultBlue)
        .cornerRadius(20)
    }
    
    private var status: some View {
        VStack(spacing: 5) {
            Text("Status")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.defaultGray)
            
            if let status = bird.status {
                HStack(spacing: 2) {
                    Image(systemName: status.icon)
                        .font(.system(size: 20, weight: .medium))
                    
                    Text(status.title)
                        .font(.system(size: 16, weight: .semibold))
                }
                .frame(height: 45)
                .padding(.horizontal, 10)
                .foregroundStyle(.defaultWhite)
                .background(.defaultBlue)
                .cornerRadius(14)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var aviary: some View {
        VStack(spacing: 8) {
            Text("Aviary")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            let sortedDates = bird.aviaries.keys.sorted(by: > )
            
            if bird.aviaries.count > 0,
               let firstData = sortedDates.first,
               let firstAviary = bird.aviaries[firstData] {
                AviaryCellView(aviary: firstAviary) {} editAction: {} removeAction: {}
                    .disabled(true)
            } else {
                aviariesList
            }
        }
    }
    
    private var aviariesList: some View {
        LazyVStack(spacing: 8) {
            let sortedDates = bird.aviaries.keys.sorted(by: > )
            
            ForEach(viewModel.aviaries) { aviary in
                if let firstData = sortedDates.first,
                   let firstAviary = bird.aviaries[firstData],
                   firstAviary.id != aviary.id {
                    HomeBirdDetailAviaryCellView(aviary: aviary) {
                        bird.aviaries[Date()] = aviary
                    }
                } else if bird.aviaries.count == 0 {
                    HomeBirdDetailAviaryCellView(aviary: aviary) {
                        bird.aviaries[Date()] = aviary
                    }
                }
            }
        }
    }
    
    private var movements: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Movement History")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.defaultGray)
                
                Button {
                    isShowHistory = true
                } label: {
                    Text("+ Add")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.defaultYellow)
                }
            }
            
            let sortedDates = bird.aviaries.keys.sorted(by: > )
                
            if bird.aviaries.count > 1 {
                ForEach(Array(sortedDates.enumerated()), id: \.offset) { index, date in
                    if index > 0,
                       let value = bird.aviaries[date],
                       let nextValue = bird.aviaries[sortedDates[index - 1]] {
                        BirdMovementAviariesCellView(aviary: value, nextAviary: nextValue, date: sortedDates[index - 1])
                    }
                }
            } else {
                Text("There’s nothing here\nyet")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .font(.system(size: 16, weight: .bold))
                    .background(.defaultBlue)
                    .foregroundStyle(.defaultWhite)
                    .multilineTextAlignment(.center)
                    .cornerRadius(15)
            }
        }
    }
    
    private func copyToClipboard(_ value: String) {
        guard !value.isEmpty else { return }
        UIPasteboard.general.string = value
        
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
            isToastVisible = true
        }
        
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation(.easeOut(duration: 0.25)) {
                isToastVisible = false
            }
        }
    }
}

#Preview {
    HomeBirdDetailView(bird: Bird(isMock: true))
        .environmentObject(HomeViewModel())
}

