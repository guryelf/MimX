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
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryDirectoryName = "TempData"
        temporaryDirectoryURL = temporaryDirectory.appendingPathComponent(temporaryDirectoryName, isDirectory: true)
        createTemporaryDirectory()
    }
    
    private func createTemporaryDirectory() {
        do {
            try FileManager.default.createDirectory(at: temporaryDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    func returnTempDirect() -> URL{
        return temporaryDirectoryURL
    }
    
    func saveDataToTemporaryDirectory(data: Data, fileName: String) -> URL {
        let fileURL = temporaryDirectoryURL.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
        } catch {
            fatalError(error.localizedDescription)
        }
        return fileURL
    }
    
    func removeDataFromTemporaryDirectory(fileName: String) {
        let fileURL = temporaryDirectoryURL.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func clearTemporaryDirectory() {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: temporaryDirectoryURL, includingPropertiesForKeys: nil, options: [])
            
            for fileURL in contents {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    deinit {
        clearTemporaryDirectory()
    }
}


