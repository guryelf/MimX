//
//  AddView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//
import Foundation
import SwiftUI
import PhotosUI
import CoreData

class AddViewModel : ObservableObject{
    private let container = FavouriteVideosContainer().persistentContainer
    @Published var picker : PhotosPickerItem?{
        didSet {
            Task{
                let data = try? await loadPhoto()
                try? await savePhoto(data: data!)
            }
        }
    }
    
    
    func loadPhoto() async throws -> Data{
        guard let item = picker else {return Data() }
        guard let videoData = try await item.loadTransferable(type: Data.self) else {return Data() }
        return videoData
    }
    func savePhoto(data:Data) async throws{
        let direct = FileManager.default.getDocDirect(fileName: "Video\(NSUUID().uuidString)")
        print(direct)
        do{
            try data.write(to: direct!)
            let video = Video(id: NSUUID().uuidString, tags: "", videoURL: direct!.debugDescription, thumbnail: "")
            CRUDManager.shared.createData(selectedVideo: video)
            print("Video saved!")
        }catch{
            print("Error occured while 'saving' video " + error.localizedDescription)
        }
    }
    
}
