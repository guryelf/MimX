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

class ContentViewModel : ObservableObject{
    @Published var isEditActive = false
    @Published var isSettingsActive = false
    @Published var index = 0
    @Published var isAddActive = false
    @Published var editView = false
    @Published var selectedVideo : Video?
    private let container = FavouriteVideosContainer().persistentContainer
    @Published var favourites = [Video]()
    @Published var changes = false
    
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
    
        private func deleteAllData(forEntity entity: String) {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
            do {
                try container.viewContext.execute(deleteRequest)
            } catch {
                print("Failed to delete data: \(error)")
            }
        }
    
    func retrieveData(){
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteVideos")
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! String
                let thumbnail = data.value(forKey: "thumbnail") as! String
                let videoURL = data.value(forKey: "videoURL") as! String
                let tags = data.value(forKey: "tags") as! String
                let video = Video(id: id , tags: tags, videoURL: videoURL, thumbnail: thumbnail)
                if let index = self.favourites.firstIndex(where: { $0.videoURL == video.videoURL }){
                    self.favourites.remove(at: index)
                }
                self.favourites.append(video)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createData(selectedVideo:Video){
        let context = container.viewContext
        let favouriteEntity = NSEntityDescription.entity(forEntityName: "FavouriteVideos", in: context)!
        
        let video = NSManagedObject(entity: favouriteEntity, insertInto: context)
        video.setValue(selectedVideo.id, forKey: "id")
        video.setValue(selectedVideo.videoURL, forKeyPath: "videoURL")
        video.setValue(selectedVideo.thumbnail, forKey: "thumbnail")
        video.setValue(selectedVideo.tags, forKey: "tags")
        do{
            try context.save()
            self.changes.toggle()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteData(selectedVideo:Video){
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteVideos")
        fetchRequest.predicate = NSPredicate(format: "id == %@", selectedVideo.id)
        let result = try? context.fetch(fetchRequest)
        let object = result?.first! as! NSManagedObject
        let id = object.value(forKey: "id") as! String
        if let index = self.favourites.firstIndex(where: { $0.id == id }){
            self.favourites.remove(at: index)
        }
        
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
            self.changes.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
}
