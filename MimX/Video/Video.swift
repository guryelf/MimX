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
    var audioURL : String
}

extension Video : Hashable {
    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    static let mockVideo = Video(id: UUID().uuidString, tags: " ", videoURL:"https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/Videos%2Fssstwitter.com_1698952443849.mp4?alt=media&token=bbdf85ed-8ce7-432f-803a-9c0fc18a076f" , thumbnail: "", audioURL: "https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/Audios%2Fssstwitter.com_1698952443849.mp3?alt=media&token=8b0f592b-1bd7-4955-a31d-dab1457be441")
}

extension Video: Transferable {

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { video in
            let data = try Data(contentsOf: URL(string: video.videoURL)!)
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("video\(NSUUID()).mp4")
            do {
                try data.write(to: fileURL)
            } catch {
                print(error)
            }
            return SentTransferredFile(fileURL)
        } importing: { received in
            let videoCopy = URL.documentsDirectory.appending(path: "video\(NSUUID()).mp4")
            let audioCopy = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("audio\(NSUUID()).m4a")
            DispatchQueue.main.sync {
                guard let _ = try? FileManager.default.copyItem(at: received.file, to: videoCopy) else {return }
                VideoPlayerManager.shared.extractAudioFromVideo(inputURL: received.file, outputURL: audioCopy) { error in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            }
            return Self.init(id: NSUUID().uuidString, tags: "", videoURL: videoCopy.absoluteString, thumbnail: "", audioURL: audioCopy.absoluteString)
        }
    }
}
