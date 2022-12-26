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
    var coreDataArray = CoreVideo()
    
    
    func getAPIVideo(_ viedoArray: [VideoModel]) {
        let context = coreData.persistentContainer.viewContext
        
        for response in viedoArray {
            //let video = coreDataArray(context: self.coreData)
            
            coreDataArray.cChannelTitle = response.channelTitle
            coreDataArray.cTitle = response.title
            coreDataArray.cDescription = response.description
            coreDataArray
        }
    }
    //
//
//    var Models = [LikeVideo]()
//
//    // Core Data，取得物件
//      func getAllItems() {
//          
//          do {
//              //獲取請求
//              models = try context.fetch(ToDoListItem.fetchRequest())
//              //主畫面更新
//              DispatchQueue.main.async {
//                  //self.tableView.reloadData()
//              }
//          } catch {
//              print("get All Items have error: ",error.localizedDescription)
//          }
//
//      }
    
}
