//
//  QRView.swift
//  ScannerApp
//
//  Created by Joel Lozano on 16/03/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var selectedTab = 0
    @State private var scannedCode: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selectedTab) {
                    QRCodeListView()
                        .environmentObject(viewModel)
                        .tabItem {
                            Label("Codigos", systemImage: "qrcode.viewfinder")
                        }
                        .tag(0)
                    
                    ScannerView(selectedTab: $selectedTab)
                        .edgesIgnoringSafeArea(.all)
                        .tabItem {
                            Label("Escanear", systemImage: "qrcode.viewfinder")
                        }
                        .environmentObject(viewModel)
                        .tag(1)
                    
                }
            }
            .background(Color(UIColor(red: 33/255, green: 18/255, blue: 49/255, alpha: 1.0)))
        }
    }
}


#Preview {
    HomeView()
        .modelContainer(for: [QRModel.self, User.self], inMemory: true)
}

