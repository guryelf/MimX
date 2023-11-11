//
//  CRUDManager.swift
//  MimX
//
//  Created by Furkan Güryel on 11.11.2023.
//

import Foundation
import CoreData

class CRUDManager{
    
    static let manager = CRUDManager()
    private let container = FavouriteVideosContainer().persistentContainer
    private let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteVideos")
    
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
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteData(selectedVideo:Video){
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteVideos")
        fetchRequest.predicate = NSPredicate(format: "id == %@", selectedVideo.id)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieveData(){
        let context = container.viewContext
        do {
            let result = try context.fetch(self.fetchRequest)
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
}
