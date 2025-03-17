//
//  PasswordHash.swift
//  ScannerApp
//
//  Created by Joel Lozano on 16/03/25.
//
import SwiftData
import Foundation
import CryptoKit

struct SecurityHelper {
    static func hashPassword(_ password: String) -> String {
        let inputData = Data(password.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
