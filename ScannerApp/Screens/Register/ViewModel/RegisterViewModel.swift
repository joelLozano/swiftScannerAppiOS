//
//  RegisterViewModel.swift
//  ScannerApp
//
//  Created by Joel Lozano on 15/03/25.
//
import Security
import CryptoKit
import SwiftData
import Foundation

class RegisterViewModel: ObservableObject {
    
    func saveUser(username: String, email: String, password: String, modelContext: ModelContext) -> Bool {
        let newUser = User(username: username, email: email, password: hashPassword(password))
        savePasswordKeyChain(password, forUser: username)
        modelContext.insert(newUser)
        do {
            try modelContext.save()
            return true
        } catch {
            print("Error al guardar usuario: \(error.localizedDescription)")
        }
        return false
    }
    
    
    func savePasswordKeyChain(_ password: String, forUser username: String) {
        let hashedPassword = hashPassword(password)
        if let passwordData = hashedPassword.data(using: .utf8) {
            KeychainManager.shared.save(passwordData, forKey: username)
        }
    }
    
    func hashPassword(_ password: String) -> String {
        let inputData = Data(password.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
