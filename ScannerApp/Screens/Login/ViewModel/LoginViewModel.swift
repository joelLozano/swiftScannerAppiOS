//
//  LoginViewModel.swift
//  ScannerApp
//
//  Created by Joel Lozano on 14/03/25.
//

import Foundation
import Combine
import SwiftData
import SwiftUICore
import LocalAuthentication

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var email: String = "" {
        didSet { validateFields() }
    }
    @Published var password: String = "" {
        didSet { validateFields() }
    }
    @Published var isLoginEnabled = false
    @Published var isAuthenticated = false
    @Published var shouldShowAlert: Bool = false
    @Published var goToDashboard: Bool = false
    
    var errorauth: String = "Verifica tus credenciales"
    private var cancellables = Set<AnyCancellable>()
    
    func validateFields() {
        isLoginEnabled = !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func authenticateUser(modelContext: ModelContext) {
        guard isLoginEnabled else {
            self.errorauth = "Los campos no pueden estar vacíos"
            self.shouldShowAlert = true
            return
        }
        
        let hashedPassword = SecurityHelper.hashPassword(password)
        let request = FetchDescriptor<User>(predicate: #Predicate { $0.email == email && $0.password == hashedPassword })
        do {
            let users = try modelContext.fetch(request)
            if  email == users.first?.username && users.first?.password == hashedPassword {
                DispatchQueue.main.async {
                    self.goToDashboard = true
                }
            } else {
                DispatchQueue.main.async {
                    self.errorauth = "Usuario o contraseña incorrectos."
                    self.shouldShowAlert = true
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorauth = "Error al autenticar usuario."
                self.shouldShowAlert = true
            }
        }
    }
    
    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Deseas usar Face ID?"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        DispatchQueue.main.async {
                            self.goToDashboard = true
                        }
                    } else {
                        self.errorauth = authenticationError?.localizedDescription ?? "No se pudo autenticar con Face ID."
                        self.showAlert()
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorauth = "Face ID no está disponible 🥲"
                self.showAlert()
            }
        }
    }
    
    func showAlert() {
        shouldShowAlert = true
    }
}
