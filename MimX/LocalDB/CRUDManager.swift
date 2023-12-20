//
//  CRUDManager.swift
//  MimX
//
//  Created by Furkan Güryel on 11.11.2023.
//

import Foundation
import CoreData

class CRUDManager{
    
    static let shared = CRUDManager()
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
        video.setValue(selectedVideo.audioURL, forKey: "audioURL")
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
    
    func retrieveData() -> [NSManagedObject]{
        let context = container.viewContext
        var result = [NSManagedObject]()
        do {
            result = try context.fetch(self.fetchRequest) as! [NSManagedObject]
        } catch {
            print(error.localizedDescription)
        }
        return result
    }
}
