//
//  CustomButton.swift
//  ScannerApp
//
//  Created by Joel Lozano on 15/03/25.
//
import SwiftUI
import SwiftData

struct CustomButton: View {
    var title: String
    var action: (ModelContext) -> Void
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Button(title) {
            action(modelContext)
        }
        .padding(20)
        
        .foregroundColor(Color.white)
        .background(Color(red: 234/255, green: 48/255, blue: 240/255))
        .fontWeight(Font.Weight.bold)
        .cornerRadius(25)
    }
}
