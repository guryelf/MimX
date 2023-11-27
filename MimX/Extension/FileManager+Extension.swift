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
    
}
