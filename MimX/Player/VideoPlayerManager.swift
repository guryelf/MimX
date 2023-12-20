//
//  VideoPlayerManager.swift
//  MimX
//
//  Created by Furkan Güryel on 18.12.2023.
//

import Foundation
import AVKit

final class VideoPlayerManager :  CachingPlayerItemDelegate{
    var playerItem : AVPlayerItem?
    
    static let shared = VideoPlayerManager()
    
    func cachedPlayer(forKey: String) -> CachingPlayerItem{
        let playerItem = VideoCacheManager.shared.returnPlayerItem(forKey)
        return playerItem
    }
    
    
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded")
        VideoCacheManager.shared.videoStorage?.async.setObject(data, forKey: playerItem.url.absoluteString, completion: { _ in })
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

