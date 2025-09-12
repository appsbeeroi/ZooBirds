import SwiftUI

struct CareTasksView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var aviary: Aviary
    
    let saveAction: (Aviary) -> Void
    
    @State private var careToEdit: AviaryCare?
    @State private var isShowAddView = false
    @State private var isShowDetailView = false
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                if aviary.cares.isEmpty {
                    stumb
                } else {
                    cares
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowAddView) {
            AviaryAddCareView(care: careToEdit ?? AviaryCare(isMock: false)) { care in
                if let index = aviary.cares.firstIndex(where: { $0.id == care.id }) {
                    aviary.cares[index] = care
                } else {
                    aviary.cares.append(care)
                }
            }
        }
        .navigationDestination(isPresented: $isShowDetailView) {
            AviaryCareDetailView(care: careToEdit ?? AviaryCare(isMock: false), aviary: aviary) { care in
                if let index = aviary.cares.firstIndex(where: { $0.id == care.id }) {
                    aviary.cares[index] = care
                } else {
                    aviary.cares.append(care)
                }
            } removeAction: { care in
                if let index = aviary.cares.firstIndex(where: { $0.id == care.id }) {
                    aviary.cares.remove(at: index)
                }
            }
        }
        .onAppear {
            careToEdit = nil
        }
    }
    
    private var navigation: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    saveAction(aviary)
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
    
    private var stumb: some View {
        ZStack {
            Image(.Images.Aviary.care)
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
            isShowAddView = true
        } label: {
            Text("Add Care")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.black)
                .background(.defaultWhite)
                .cornerRadius(20)
        }
    }
    
    private var cares: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                Text("Care")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 17, weight: .heavy))
                    .foregroundStyle(.white)
                
                ForEach(aviary.cares) { care in
                    AviaryCareCellView(care: care) {
                        careToEdit = care
                        isShowDetailView = true
                    } editAction: {
                        careToEdit = care
                        isShowAddView = true
                    } removeAction: {
                        if let index = aviary.cares.firstIndex(where: { $0.id == care.id }) {
                            aviary.cares.remove(at: index)
                        }
                    }
                }
                
                addButton
            }
            .padding(.top, 5)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CareTasksView(aviary: Aviary(isMock: false)) { _ in }
}

#Preview {
    CareTasksView(aviary: Aviary(isMock: true)) { _ in }
}
