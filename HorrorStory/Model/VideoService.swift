//
//  CoreDataModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/16.
//

import Foundation
import CoreData


class VideoService {
    
    //let coreData = CoreDataStack()

 
    private let moc: NSManagedObjectContext
    private var videoArray = [CoreVideo]()
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc

    }
    

    func getAllVideos() -> [CoreVideo]? {

        let sortByTime = NSSortDescriptor(key: "cPublished", ascending: false)
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        request.sortDescriptors = [sortByTime]
        
        do {
            videoArray = try moc.fetch(request)
            
            return videoArray
            
        } catch let error as NSError {
            print("Error fetching students: \(error.localizedDescription)")
        }
        
        
        
        return nil
    }
    
    
    func getVideosByTitle(cChannelTitle:String?) -> [CoreVideo]? {

        let sortByTime = NSSortDescriptor(key: "cPublished", ascending: false)
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        
        if cChannelTitle != nil
        {
            request.predicate = NSPredicate(format:"cChannelTitle = %@", cChannelTitle!)
        }
        request.sortDescriptors = [sortByTime]
        
       
        
        do {
            videoArray = try moc.fetch(request)
            
            return videoArray
            
        } catch let error as NSError {
            print("Error fetching students: \(error.localizedDescription)")
        }

        return nil
    }

    
    func updateVideo(currentVideo video: CoreVideo, newValue: Bool) {
        
        video.isLike = newValue
        
        save()
        
    }
    
    
    private func save() {
        do {
            print("save")
            try moc.save()
            
            
        } catch let error as NSError {
            print("Save failed: \(error.localizedDescription)")
        }
    }
    
    
    func getLikeVideos() -> [CoreVideo]? {
        //let sortByTime = NSSortDescriptor(key: "cPublished", ascending: false)
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        //request.predicate = NSPredicate(format:"cIsLike = %@", 1)
        request.predicate = NSPredicate(format: "cIsLike == %@", NSNumber(value: true))
        //request.sortDescriptors = [sortByTime]
        do {
    
            videoArray = try moc.fetch(request)
            return videoArray
            
        } catch let error as NSError {
            print("Error fetching students: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    
    
    
}
