//
//  TemporaryFileManager.swift
//  MimX
//
//  Created by Furkan Güryel on 26.12.2023.
//

import Foundation

class TemporaryFileManager {
    
    static let shared = TemporaryFileManager()
    
    private let temporaryDirectoryURL: URL
    
    private init() {
        // Geçici klasör oluştur
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryDirectoryName = "MyAppTempData"
        temporaryDirectoryURL = temporaryDirectory.appendingPathComponent(temporaryDirectoryName, isDirectory: true)
        
        // Geçici klasörü oluştur
        createTemporaryDirectory()
    }
    
    private func createTemporaryDirectory() {
        do {
            try FileManager.default.createDirectory(at: temporaryDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError("Geçici klasör oluşturulamadı: \(error.localizedDescription)")
        }
    }
    
    func saveDataToTemporaryDirectory(data: Data, fileName: String) -> URL {
        let fileURL = temporaryDirectoryURL.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
        } catch {
            fatalError("Veri geçici klasöre kaydedilemedi: \(error.localizedDescription)")
        }
        return fileURL
    }
    
    func removeDataFromTemporaryDirectory(fileName: String) {
        let fileURL = temporaryDirectoryURL.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Veri geçici klasörden silinemedi: \(error.localizedDescription)")
        }
    }
    
    func clearTemporaryDirectory() {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: temporaryDirectoryURL, includingPropertiesForKeys: nil, options: [])
            
            for fileURL in contents {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("Geçici klasör temizlenemedi: \(error.localizedDescription)")
        }
    }
    
    deinit {
        // Uygulama kapatıldığında geçici klasörü temizle
        clearTemporaryDirectory()
    }
}


