//
//  ContentViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 23.10.2023.
//

import Foundation
import SwiftUI
import CoreData
import Combine
import AVFoundation

class ContentViewModel : ObservableObject{
    @Published var isSettingsActive = false
    @Published var index = 0
    @Published var editView = false
    @Published var isVolume = false
    @Published var isLoading = false
    @Published var volume : Float = 1
    @Published var selectedVideo : Video?
    private let container = FavouriteVideosContainer().persistentContainer
    @Published var favourites = [Video]()
    @Published var changes = false
    private let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteVideos")
    
    init() {
        retrieveData()
        setup()
    }
    private var cancellables = Set<AnyCancellable>()
    private func setup(){
        self.$changes.sink { [weak self] _ in
            self?.retrieveData()
        }.store(in: &cancellables)
    }
    
//    private func deleteAllData(forEntity entity: String) {
//
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: self.fetchRequest)
//
//        do {
//            try container.viewContext.execute(deleteRequest)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    
    func retrieveData(){
        let objects = CRUDManager.shared.retrieveData()
        for object in objects {
            let videoURL = object.value(forKey: "videoURL") as! String
            let id = object.value(forKey: "id") as! String
            let thumbnail = object.value(forKey: "thumbnail") as! String
            let tags = object.value(forKey: "tags") as! String
            let audioURL = object.value(forKey: "audioURL") as! String
            let video = Video(id: id, tags: tags, videoURL: videoURL, thumbnail: thumbnail, audioURL: audioURL)
            if let index = self.favourites.firstIndex(where: { $0.videoURL == videoURL }){
                self.favourites.remove(at: index)
            }
            self.favourites.append(video)
        }
    }
    
    func write(selectedVideo:Video){
        CRUDManager.shared.createData(selectedVideo: selectedVideo)
        self.changes.toggle()
    }
    
    func deleteData(selectedVideo:Video){
        CRUDManager.shared.deleteData(selectedVideo: selectedVideo)
        if let index = self.favourites.firstIndex(where: { $0.id == selectedVideo.id }){
            self.favourites.remove(at: index)
        }
        self.changes.toggle()
    }
}
