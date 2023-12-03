//
//  AppError.swift
//  MimX
//
//  Created by Furkan Güryel on 13.11.2023.
//

import Foundation

enum AppError: Error , LocalizedError {
    
    case firestoreError(description: String)
    case storageError(description: String)
    case databaseError(description: String)
    case filemanagerError(description:String)
    case imageGenerator(description: String)
    
    var errorDescription: String? {
        switch self {
        case .firestoreError(let description):
            return NSLocalizedString("Database Error:\n "  + description,comment: "")
        case .storageError(let description):
            return NSLocalizedString("Storage Error:\n " + description, comment: "")
        case .databaseError(let description):
            return NSLocalizedString("Database Error:\n " + description, comment: "")
        case .filemanagerError(description: let description):
            return NSLocalizedString("File Manager Error:\n " + description , comment: "")
        case .imageGenerator(description: let description):
            return NSLocalizedString("Image Generator Error:\n " + description,comment: "")
        }
    }
}

struct ErrorType: Identifiable{
    var id = UUID()
    var errorType : AppError
}



