//
//  ExtractionManager.swift
//  MimX
//
//  Created by Furkan Güryel on 28.12.2023.
//

import Foundation
import AVFoundation

class ExtractionManager{
    
    static let shared = ExtractionManager()
    
    func downloadVideo(video:Video) -> Data{
        var data = Data()
        URLSession.shared.dataTask(with: URL(string: video.videoURL)!) { (outputData, _, _) in
            guard let videoData = outputData else { return }
            data = videoData
        }.resume()
        return data
    }

    
    func extractAudioFromVideo(inputURL: URL, outputURL: URL, completion: @escaping (Error?) -> Void) {
        let asset = AVAsset(url: inputURL)
        let composition = AVMutableComposition()
        guard let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) else {
            completion(NSError(domain: "com.example", code: 1, userInfo: [NSLocalizedDescriptionKey: "audio failed"]))
            return
        }
        do {
            try audioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: asset.tracks(withMediaType: .audio)[0], at: CMTime.zero)
        } catch {
            completion(error)
            return
        }
        guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A) else {
            completion(NSError(domain: "com.example", code: 2, userInfo: [NSLocalizedDescriptionKey: "failed"]))
            return
        }
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .m4a
        
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(nil)
            case .failed:
                completion(exportSession.error)
            case .cancelled:
                completion(NSError(domain: "com.example", code: 3, userInfo: [NSLocalizedDescriptionKey: "cancelled"]))
            default:
                break
            }
        }
    }
    
}
