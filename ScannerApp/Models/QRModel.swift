//
//  QRModel.swift
//  ScannerApp
//
//  Created by Joel Lozano on 16/03/25.
//
import Foundation
import SwiftData

@Model
class QRModel {
    var id: UUID
    var code: String
    
    init(id: UUID, code: String) {
        self.id = id
        self.code = code
    }
}
