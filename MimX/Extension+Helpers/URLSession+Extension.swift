//
//  URLSession+Extension.swift
//  MimX
//
//  Created by Furkan Güryel on 9.12.2023.
//

import Foundation

extension URLSession{
    func downloadVideo(video:Video) -> Data{
        var data = Data()
        URLSession.shared.dataTask(with: URL(string: video.videoURL)!) { (outputData, _, _) in
            guard let videoData = outputData else { return }
            data = videoData
        }.resume()
        return data
    }
    func downloadAudio(audioURL : String,completion: @escaping (URL) -> () ) {
        guard let audioURL = URL(string: audioURL) else {
            print("Geçersiz URL")
            return
        }
        URLSession.shared.dataTask(with: audioURL) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let url = TemporaryFileManager.shared.saveDataToTemporaryDirectory(data: data, fileName: "audio\(NSUUID()).m4a")
            completion(url)
        }.resume()
    }
}
    
