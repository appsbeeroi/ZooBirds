import SwiftUI

struct AviaryCareDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var care: AviaryCare
    let aviary: Aviary
    
    let saveAction: (AviaryCare) -> Void
    let removeAction: (AviaryCare) -> Void
    
    @State private var isShowDeleteAlert = false
    @State private var isShowAddView = false
    
    var body: some View {
        ZStack {
            Color.defaultDarkBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                navigation
                
                VStack(spacing: 24) {
                    cleaning
                    aviaryInfo
                }
                .padding(.top, 5)
                .padding(.horizontal, 35)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .alert("", isPresented: $isShowDeleteAlert) {
            Button("Delete", role: .destructive) {
                removeAction(care)
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
                    saveAction(care)
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
                        AviaryAddCareView(care: care) { newCare in
                            care = newCare
                        }
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
    
    private var cleaning: some View {
        VStack(spacing: 8) {
            Text("Cleaning")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            VStack(spacing: 0) {
                time
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundStyle(.defaultWhite.opacity(0.5))
                
                frequancy
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundStyle(.defaultWhite.opacity(0.5))
                
                if care.note != "" {
                    note
                }
            }
            .background(.defaultBlue)
            .cornerRadius(20)
        }
    }
    
    private var time: some View {
        HStack {
            Text("Time")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.defaultGray)
            
            Text(care.time.formatted(.dateTime.hour().minute()))
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.defaultWhite)
        }
        .padding(12)
        .frame(height: 44)
    }
    
    private var frequancy: some View {
        HStack {
            Text("Frequancy")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.defaultGray)
            
            Text(care.frequancy?.title ?? "N/A")
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.defaultWhite)
        }
        .padding(12)
        .frame(height: 44)
    }
    
    private var note: some View {
        VStack(spacing: 2) {
            Text("Note")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.defaultGray)
            
            Text(care.note)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.defaultWhite)
                .multilineTextAlignment(.leading)
        }
        .padding(12)
    }
    
    private var aviaryInfo: some View {
        VStack(spacing: 8) {
            Text("Aviary")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20, weight: .heavy))
                .foregroundStyle(.defaultWhite)
            
            AviaryCellView(aviary: aviary) {} editAction: {} removeAction: {}
                .disabled(true)
        }
    }
}

#Preview {
    AviaryCareDetailView(care: AviaryCare(isMock: true), aviary: Aviary(isMock: true)) { _ in } removeAction: { _ in }
}
