//
//  login.swift
//  ScannerApp
//
//  Created by Joel Lozano on 14/03/25.
//

import SwiftUI
import Combine
import LocalAuthentication
import SwiftData


struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = LoginViewModel()
    @State private var showDetail = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .font(Font.system(size: 30))
                    .padding(.vertical)
                
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                
                CustomTextField(placeHolder: "email", text: $viewModel.email)
                    .padding(.vertical)
                
                CustomPasswordTextField(placeholder: "Password", password: $viewModel.password)
                    .padding(.vertical)
                
                CustomButton(title:"Iniciar Sesión", action: viewModel.authenticateUser)
                    .padding(.vertical)
                    .disabled(!viewModel.isLoginEnabled)
                    .opacity(viewModel.isLoginEnabled ? 1 : 0.5)
                
                CustomFaceIDButton(action: viewModel.authenticateWithFaceID)
                
                Spacer()
                
                Button {
                    showDetail = true
                } label: {
                    Text("Registrate")
                }.fullScreenCover(isPresented: $showDetail) {
                    RegisterView()
                }
            }
            .padding(40)
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(UIColor(red: 33/255, green: 18/255, blue: 49/255, alpha: 1.0))
            )
            .alert(isPresented: $viewModel.shouldShowAlert) {
                Alert(title: Text("Mensaje"), message: Text(viewModel.errorauth), dismissButton: .default(Text("OK")))
            }
        }.fullScreenCover(isPresented: $viewModel.goToDashboard) {
            HomeView()
        }
        
    }
}

#Preview {
    LoginView()
        .modelContainer(for: User.self, inMemory: true)
}
