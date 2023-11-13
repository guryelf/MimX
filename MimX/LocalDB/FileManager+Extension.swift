//
//  FileManager+Extension.swift
//  MimX
//
//  Created by Furkan Güryel on 13.11.2023.
//

import Foundation

extension FileManager{
    
    func getDocDirect(fileName:String) -> URL?{
        let docDirect = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirect.appendingPathComponent(fileName)
    }
    
}
