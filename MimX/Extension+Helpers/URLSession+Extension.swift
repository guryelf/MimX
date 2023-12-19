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
        URLSession.shared.dataTask(with: URL(string: video.videoURL)!) { (d, _, _) in
            guard let videoData = d else { return }
            data = videoData
        }.resume()
        return data
    }
}

    
