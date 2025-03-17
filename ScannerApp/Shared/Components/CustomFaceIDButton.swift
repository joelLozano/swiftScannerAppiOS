//
//  CustomFaceIDButton.swift
//  ScannerApp
//
//  Created by Joel Lozano on 15/03/25.
//
import SwiftUI

struct CustomFaceIDButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action ) {
            Image(systemName: "faceid")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .padding()
                .background(Color.purple.opacity(0.2))
                .clipShape(Circle())
        }
    }
}
