//
//  Toast.swift
//  ScannerApp
//
//  Created by Joel Lozano on 16/03/25.
//

import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.green)
            .cornerRadius(10)
            .padding(.top, 50)
            .transition(.move(edge: .top).combined(with: .opacity))
        Spacer()
    }
}
