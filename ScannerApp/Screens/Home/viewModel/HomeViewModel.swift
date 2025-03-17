//
//  HomeViewModel.swift
//  ScannerApp
//
//  Created by Joel Lozano on 16/03/25.
//
import SwiftData
import Foundation

class HomeViewModel: ObservableObject {
    
    //    @Published var showToast: Bool = false
    @Published var qrCodes: [QRModel] = []
    @Published var qrCodesString: [String] = []
    
    func saveQR(code: String, modelContext: ModelContext) -> Bool{
        let qrModel = QRModel(id: UUID(), code: code)
        modelContext.insert(qrModel)
        
        do {
            try modelContext.save()
            DispatchQueue.main.async { [weak self] in
                self?.fetchQRCodes(modelContext: modelContext)
            }
            return true
        }
        catch {
            print("Error")
        }
        return false
    }
    
    func fetchQRCodes(modelContext: ModelContext) {
        let request = FetchDescriptor<QRModel>()
        do {
            let qrItems = try modelContext.fetch(request)
            DispatchQueue.main.async { [weak self] in
                self?.qrCodes = qrItems.map { $0 }
                self?.qrCodesString = qrItems.map { $0.code }
            }
        } catch {
            print("Error al obtener los códigos QR: \(error.localizedDescription)")
        }
    }
    
    func deleteItems(at offsets: IndexSet, modelContext: ModelContext) {
        for index in offsets {
            let codeToDelete = qrCodes[index] // Obtén el objeto a eliminar
            modelContext.delete(codeToDelete)
        }
        
        do {
            try modelContext.save()
            
            DispatchQueue.main.async { [weak self] in
                self?.qrCodes.remove(atOffsets: offsets)
                self?.qrCodesString = self?.qrCodes.map { $0.code } ?? [""]
            }
        } catch {
            print("Error al eliminar código QR: \(error.localizedDescription)")
        }
    }

}
