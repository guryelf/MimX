//
//  Video.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import Foundation
import AVKit
import SwiftUI


struct Video : Identifiable,Decodable{

    let id: String
    var tags : String
    var videoURL : String
    var thumbnail : String

}

extension Video : Hashable {
    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    static let mockVideo = Video(id: UUID().uuidString, tags: " ", videoURL:"https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/ssstwitter.com_1697653735844.mp4?alt=media&token=54b821c3-2f1e-46b6-a775-3792185bd70d" , thumbnail: "")
}

extension Video: Transferable {

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { video in
            SentTransferredFile(URL(string: video.videoURL)!)
        } importing: { received in
            let copy = URL.documentsDirectory.appending(path: "video\(NSUUID()).mp4")

            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }

            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(id: NSUUID().uuidString, tags: "", videoURL: copy.absoluteString, thumbnail: "")
        }
    }
}
