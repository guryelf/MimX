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
    
    func createFolderAndSave(name:String,dataToWrite:[Data]) -> [URL]{
        let folderName = name
        var url = [URL]()
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let folderURL = documentsDirectory.appendingPathComponent(folderName)
            do {
                if !fileManager.fileExists(atPath: folderURL.path) {
                    try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
                } else {
                    print("Folder does exist : \(folderURL.path)")
                    url = try contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
                    url.sort { url9, url8 in
                        do{
                            let url1 = try url9.resourceValues(forKeys: [.creationDateKey])
                            let url2 = try url8.resourceValues(forKeys: [.creationDateKey])
                            
                            let date1 = url1.creationDate
                            let date2 = url2.creationDate
                            
                            return date1!<date2!
                        }catch{
                            print("Sorting error" , error.localizedDescription)
                        }
                        return false
                    }
                    return url
                }
                dataToWrite.forEach { 
                    let fileURL = folderURL.appendingPathComponent("name,\(UUID().uuidString).jpg")
                    try? $0.write(to: fileURL) }
                url = try contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            print("Direct not found")
        }
        return url
    }
    
}
