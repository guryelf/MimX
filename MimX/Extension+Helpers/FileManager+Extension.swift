//
//  FileManager+Extension.swift
//  MimX
//
//  Created by Furkan Güryel on 13.11.2023.
//

import Foundation

extension FileManager{
    
    func getDocDirect() -> URL{
        return self.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func createFilePath(name:String) -> URL{
        let folderName = name
        guard let documentDirect = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return URL(string: "")!}
        let folderPath = documentDirect.appendingPathComponent(folderName)
        if !fileExists(atPath: folderPath.path()){
            do {
                try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true)
            }catch{
                print("Creating folder path failed: " , error.localizedDescription)
            }
        }
        return folderPath
    }
    
    func isExists(name:String) -> [URL]?{
        let folderName = name
        var url = [URL]()
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let folderURL = documentsDirectory.appendingPathComponent(folderName)
            do {
                if fileManager.fileExists(atPath: folderURL.path) {
                    print("Folder does exist : \(folderURL.path)")
                    url = try contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
                    url = url.sorted()
                    return url
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            print("Direct not found")
        }
        return nil
    }
    
    func createFolderAndSave(name:String,dataToWrite:[Data]) -> [URL]{
        let folderName = name
        var url = [URL]()
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let folderURL = documentsDirectory.appendingPathComponent(folderName)
            do {
                if !fileManager.fileExists(atPath: folderURL.path) {
                    try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
                }
                dataToWrite.forEach {
                    let fileURL = folderURL.appendingPathComponent("name,\(UUID().uuidString).jpg")
                    try? $0.write(to: fileURL) }
                url = try contentsOfDirectory(at: folderURL, includingPropertiesForKeys: .none)
                url = url.sorted()
                return url
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            print("Direct not found")
        }
        return url
    }
    
}
