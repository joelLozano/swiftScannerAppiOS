//
//  ScannedCodesView.swift
//  ScannerApp
//
//  Created by Joel Lozano on 16/03/25.
//
import SwiftUI

struct QRCodeListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
                if !viewModel.qrCodesString.isEmpty {
                    ZStack {
                        Color(UIColor(red: 33/255, green: 18/255, blue: 49/255, alpha: 1.0))
                            .ignoresSafeArea()
                        
                    List {
                        ForEach(viewModel.qrCodesString, id: \.self) { code in
                            NavigationLink(destination: QRCodeDetailView(qrCode: code)) {
                                HStack {
                                    Image(systemName: "qrcode")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                    
                                    Text(code)
                                        .font(.body)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .foregroundColor(.white)
                                }
                            }
                            
                            .listRowBackground(Color.clear)
                                .padding()
                                .background(Color(red: 234/255, green: 48/255, blue: 240/255))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                        }.onDelete(perform: deleteItems)
                    }
                    }.scrollContentBackground(.hidden)
                        .background(Color.clear)
                }
            else {
                ZStack {
                    Color(UIColor(red: 33/255, green: 18/255, blue: 49/255, alpha: 1.0))
                        .ignoresSafeArea()
                    VStack {
                        Text("Tus QR")
                            .font(Font.system(size: 40))
                            .foregroundColor(Color(red: 234/255, green: 48/255, blue: 240/255))
                            .fontWeight(Font.Weight.bold)
                            .padding()
                        Spacer()
                        Text("No cuentas con registros aun")
                            .font(.title)
                            .foregroundColor(.white)
                        Spacer()
                    }.scrollContentBackground(.hidden)
                        .background(Color(UIColor(red: 33/255, green: 18/255, blue: 49/255, alpha: 1.0)))
                }
            }
        
        }
        .onAppear {
            viewModel.fetchQRCodes(modelContext: modelContext)
                }
        
    }
    
    func deleteItems(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { viewModel.qrCodes[$0] }
        let itemsToDeleteString = offsets.map { viewModel.qrCodesString[$0] }
        
        for item in itemsToDelete {
            modelContext.delete(item)
        }
        
        do {
            try modelContext.save()
            viewModel.qrCodesString.remove(atOffsets: offsets)
            viewModel.qrCodes.remove(atOffsets: offsets)
            viewModel.qrCodesString = viewModel.qrCodes.map { $0.code }
        } catch {
            print("Error al eliminar código QR: \(error.localizedDescription)")
        }
    }
    
}

struct QRCodeDetailView: View {
    let qrCode: String
    
    var body: some View {
        VStack {
            Image(systemName: "qrcode")
                .font(.system(size: 100))
                .foregroundColor(.purple)
            
            Text(qrCode)
                .font(.title)
                .padding()
        }
        .navigationTitle("Detalle QR")
    }
}

#Preview {
    QRCodeListView()
}


