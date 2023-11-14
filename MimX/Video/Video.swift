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
    
    static let mockVideo = Video(id: UUID().uuidString, tags: " ", videoURL:"https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/Videos%2Fssstwitter.com_1698952443849.mp4?alt=media&token=bbdf85ed-8ce7-432f-803a-9c0fc18a076f" , thumbnail: "")
}

extension Video: Transferable {

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { video in
            SentTransferredFile(URL(string: video.videoURL)!)
        } importing: { received in
            let copy = URL.documentsDirectory.appending(path: "video\(NSUUID()).mp4")

            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(id: NSUUID().uuidString, tags: "", videoURL: copy.absoluteString, thumbnail: "")
        }
    }
}
