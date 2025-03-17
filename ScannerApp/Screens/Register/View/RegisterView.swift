//
//  RegisterView.swift
//  ScannerApp
//
//  Created by Joel Lozano on 15/03/25.
//
import SwiftUI
import SwiftData

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = RegisterViewModel()
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var alertState = false
    @State private var showToast = false
    
    
    var body: some View {
        
        ZStack {
            VStack (spacing: 30)  {
                Text("Registro")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .font(Font.system(size: 30))
                    .padding(.vertical)
                
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                
                CustomTextField(placeHolder: "Nombre", text: $username)
                
                CustomTextField(placeHolder: "E-mail", text: $email)
                
                CustomPasswordTextField(placeholder: "password", password: $password)
                
                CustomButton(title: "Registrar") { _ in
                    if (viewModel.saveUser(username: username, email: email, password: password, modelContext: modelContext)) {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showToast = false
                            dismiss()
                        }
                    }
                }
                
            }.padding(40)
                .containerRelativeFrame([.horizontal, .vertical])
                .background(Color(UIColor(red: 33/255, green: 18/255, blue: 49/255, alpha: 1.0)))
                .alert(isPresented: $alertState) {
                    Alert(title: Text("Error en tu registro"), message: Text("Lo sentimos, algo ocurrio intenta mas tarde"), dismissButton: .default(Text("OK")))
                }
            
            if showToast {
                            ToastView(message: "Registro exitoso!")
                                .zIndex(1) // Asegura que esté encima de todo
                        }
        }.animation(.easeIn, value: showToast)
        
    }
}


#Preview {
    RegisterView()
        .modelContainer(for: [QRModel.self, User.self], inMemory: true)
}
