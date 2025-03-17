//
//  TexfieldUser.swift
//  ScannerApp
//
//  Created by Joel Lozano on 15/03/25.
//
import SwiftUI

struct CustomPasswordTextField: View {
    var placeholder: String
    @Binding var password: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if password.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.gray)
                    .font(.headline)
                    .padding(.leading, 30)
            }
            
            SecureField("", text: $password)
                .foregroundColor(Color(red: 234/255, green: 48/255, blue: 240/255))
                .font(.headline)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color.purple.opacity(0.3))
                .cornerRadius(18)
                .overlay(RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.purple, lineWidth: 1))
        }
    }
}
