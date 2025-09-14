import SwiftUI

struct AviaryDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: AviaryViewModel
    
    @State var aviary: Aviary
    
    @State private var isShowDeleteAlert = false
    @State private var isToastVisible = false
    @State private var isShowCareTasksView = false
    @State private var isShowHistoryView = false
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        header
                        size
                        
                        if aviary.species.contains(where: { $0 != "" }) {
                            species
                        }
                        
                        careTask
                        movementHistory
                    }
                    .padding(.top, 5)
                    .padding(.horizontal, 35)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowCareTasksView) {
            CareTasksView(aviary: aviary) { aviary in
                self.aviary = aviary
            }
        }
        .navigationDestination(isPresented: $isShowHistoryView) {
            AviaryHistoryView()
        }
        .alert("", isPresented: $isShowDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.remove(aviary)
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
                    viewModel.save(aviary)
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
                
                HStack(spacing: 16) {
                    NavigationLink {
                        AddAviaryView(aviary: aviary)
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
                
                Text(aviary.name)
                    .font(.system(size: 25, weight: .heavy))
                    .foregroundStyle(.defaultWhite)
            }
        }
    }
    
    private var image: some View {
        Image(uiImage: aviary.image ?? UIImage())
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
    
    private var size: some View {
        HStack {
            Text("Size")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.defaultGray)
            
            Text("\(aviary.size) m")
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.defaultWhite)
        }
        .frame(height: 60)
        .padding(.horizontal, 12)
        .background(.defaultBlue)
        .cornerRadius(18)
    }
    
    private var species: some View {
        VStack(spacing: 5) {
            Text("Compatible Species")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.defaultGray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 5) {
                    ForEach(aviary.species, id: \.self) { specie in
                        if specie != "" {
                            Text(specie)
                                .frame(minHeight: 45)
                                .padding(.horizontal, 10)
                                .font(.system(size: 17, weight: .medium))
                                .foregroundStyle(.defaultWhite)
                                .background(.defaultBlue)
                                .cornerRadius(14)
                        }
                    }
                }
            }
        }
    }
    
    private var careTask: some View {
        ZStack {
            HStack {
                VStack {
                    Text("Care Tasks")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .font(.system(size: 17, weight: .heavy))
                        .foregroundStyle(.defaultWhite)
                    
                    Button {
                        isShowCareTasksView = true
                    } label: {
                        Text("Open")
                            .frame(width: 74, height: 38)
                            .foregroundStyle(.black)
                            .background(.defaultWhite)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                Image(.Images.Aviary.care)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 154, height: 230)
            }
            .frame(height: 144)
            .padding(10)
            .background(.defaultBlue)
            .cornerRadius(18)
        }
    }
    
    private var movementHistory: some View {
        ZStack {
            HStack {
                VStack {
                    Text("Movement History")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .font(.system(size: 17, weight: .heavy))
                        .foregroundStyle(.defaultWhite)
                    
                    Button {
                        isShowHistoryView.toggle()
                    } label: {
                        Text("Open")
                            .frame(width: 74, height: 38)
                            .foregroundStyle(.black)
                            .background(.defaultWhite)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                Image(.Images.Aviary.movement)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 154, height: 230)
            }
            .frame(height: 144)
            .padding(10)
            .background(.defaultBlue)
            .cornerRadius(18)
        }
    }
}

#Preview {
    AviaryDetailView(aviary: Aviary(isMock: true))
        .environmentObject(AviaryViewModel())
}

