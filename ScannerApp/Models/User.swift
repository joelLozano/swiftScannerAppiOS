//
//  User.swift
//  ScannerApp
//
//  Created by Joel Lozano on 14/03/25.
//
import SwiftData

@Model
class User {
    var username: String
    var email: String
    var password: String
    
    init(username: String,email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}
