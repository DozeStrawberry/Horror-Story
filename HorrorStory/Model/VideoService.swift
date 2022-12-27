//
//  CoreDataModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/16.
//

import Foundation
import CoreData


class VideoService {
    
    let coreData = CoreDataStack()
    
    //static let shared = VideoService(moc: coreData.persistentContainer.viewContext)
    
 
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
    
    
    func updateVideo(currentVideo video: CoreVideo, isLike newValue: Bool) {
        video.cIsLike = newValue
        
        do {
            try moc.save()
            
        } catch {
            print("update video bool value have error: \(error.localizedDescription)")
        }
    }

    
    
    
}
