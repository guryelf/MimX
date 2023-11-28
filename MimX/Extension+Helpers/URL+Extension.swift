//
//  URL+Extension.swift
//  MimX
//
//  Created by Furkan Güryel on 29.11.2023.
//

import Foundation

extension URL : Comparable{
    public static func < (lhs: URL, rhs: URL) -> Bool {
        do{
            let url1 = try lhs.resourceValues(forKeys: [.creationDateKey])
            let url2 = try rhs.resourceValues(forKeys: [.creationDateKey])
            
            let date1 = url1.creationDate
            let date2 = url2.creationDate
            
            return date1!<date2!
        }catch{
            print("Sorting error" , error.localizedDescription)
        }
        return false
    }
}



