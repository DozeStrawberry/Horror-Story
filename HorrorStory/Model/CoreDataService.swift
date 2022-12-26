//
//  CoreDataModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/16.
//

import Foundation
import CoreData


class CoreDataService {
    
    static var shared = CoreDataService()
    let coreData = CoreDataStack()
    //var coreDataArray = CoreVideo()
    
//    func getAllItems() {
//          
//          do {
//              //獲取請求
//              models = try context.fetch(ToDoListItem.fetchRequest())
//              //主畫面更新
//              DispatchQueue.main.async {
//                  self.tableView.reloadData()
//              }
//          } catch {
//              print("get All Items have error: ",error.localizedDescription)
//          }
//          
//      }
    
//    
    func getAPIVideo(_ viedoArray: [VideoModel]) {
        let context = coreData.persistentContainer.viewContext
        
        for response in viedoArray {
            
            if response.videoId != response.videoId {
                
                let video = CoreVideo(context: context)
                
                video.cChannelTitle = response.channelTitle
                video.cTitle = response.title
                video.cDescription = response.description
                video.cPublished = response.published
                video.cIsLike = response.isLike
                video.cVideoId = response.videoId
            }
          
            
            do {
                  try context.save()
            
              } catch {
                  print("get API Video have error: ",error.localizedDescription)
              }
        }
    }
    
    //                        for item in response.items! {
    //
    //
    //                            let coreData = CoreVideo(context: moc)
    //
    //                            coreData.cIsLike = false
    //                            coreData.cThumbnail = item.thumbnail
    //                            coreData.cPublished = item.published
    //                            coreData.cVideoId = item.videoId
    //                            coreData.cDescription = item.description
    //                            coreData.cChannelTitle = item.channelTitle
    //                            coreData.cTitle = item.title
    //
    //                        }
    //
    //                        self.coreData.saveContext()

    
}
