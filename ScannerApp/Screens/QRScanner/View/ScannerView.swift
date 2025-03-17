//
//  QRScannerView.swift
//  ScannerApp
//
//  Created by Joel Lozano on 16/03/25.
//
import SwiftUI

struct ScannerView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var scannedCode: String?
    @State private var isScanning: Bool = true
    @Binding var selectedTab: Int
    
    @StateObject private var viewModel = HomeViewModel()
    
    
    var body: some View {
        VStack {
            Text("Scan QR")
                .font(.title)
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color(red: 234/255, green: 48/255, blue: 240/255))
                .padding()
            
            if isScanning {
                QRScannerView(scannedCode: $scannedCode, isScanning: $isScanning)
                    .frame(width: .infinity, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
            } else {
                VStack {
                    
                    Text(scannedCode ?? "")
                        .font(.title2)
                        .foregroundColor(Color(red: 234/255, green: 48/255, blue: 240/255))
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                    
                    HStack {
                        Button("Volver a Escanear") {
                            isScanning = true
                            scannedCode = nil
                        }
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        CustomButton(title: "Guardar") { _ in
                            if viewModel.saveQR(code: scannedCode ?? "", modelContext: modelContext) {
                                selectedTab = 0
                                isScanning = true
                                scannedCode = nil
                            }
                        }
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor(red: 33/255, green: 18/255, blue: 49/255, alpha: 1.0)))
        
    }
}

