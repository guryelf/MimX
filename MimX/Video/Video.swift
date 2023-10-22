//
//  Video.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import Foundation


final class Video : Hashable,Identifiable{
    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }

    var id: String
    var tags : [String]
    var videoURL : String
    
    internal init(id: String, tags: [String], videoURL: String) {
        self.id = id
        self.tags = tags
        self.videoURL = videoURL
    }

}
