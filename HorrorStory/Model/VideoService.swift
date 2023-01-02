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
    
    //檢查更新影片
    func getUpdateAllVideos(updateVideo: [VideoModel]) -> [CoreVideo]? {
        
        let sortByTime = NSSortDescriptor(key: "cPublished", ascending: false)
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        request.sortDescriptors = [sortByTime]
        
        do {
            videoArray = try moc.fetch(request)
            
            var newVideos: [CoreVideo] = []
            
            for i in 0 ..< videoArray.count {
                
                for index in 0 ..< updateVideo.count  {
                    
                    if updateVideo[index].channelTitle == videoArray[i].cChannelTitle {
                        
                        if updateVideo[index].videoId != videoArray[i].cVideoId {
                            print("core video have \(videoArray.count)")
                            print("update new video \(updateVideo[index].videoId)")
                            let newVideo = CoreVideo(context: moc)
                            
                            newVideo.isLike = false
                            newVideo.cVideoId = updateVideo[index].videoId
                            newVideo.cChannelTitle = updateVideo[index].channelTitle
                            newVideo.cTitle = updateVideo[index].title
                            newVideo.cDescription = updateVideo[index].description
                            newVideo.cThumbnail = updateVideo[index].thumbnail
                            newVideo.cPublished = updateVideo[index].published
                            
                            newVideos += [newVideo]
                            videoArray += newVideos
                            print("have new video \(newVideos.count)")
                        }
                    }
                }
            }
            save()
            return videoArray
            
        } catch let error as NSError {
            print("Error fetching students: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    

}
