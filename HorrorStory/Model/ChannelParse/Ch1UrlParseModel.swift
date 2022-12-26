//
//  Ch1UrlParseModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/15.
//
import Foundation
import CoreData


////取得影片協議
//protocol Ch1ModelDelegate {
//    func ch1VideosFetched(_ videos: [CoreVideo])
//}

class Ch1UrlParseModel {
    
    private var coreData = CoreDataStack()
    
    func checkData() {
        let moc = coreData.persistentContainer.viewContext
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        
        if let movieCount = try? moc.count(for: request), movieCount > 0 {
            return
        }
        
        getVideos()
        
    }
    
    
    func getVideos() {
        
        let moc = coreData.persistentContainer.viewContext
        
        // Create a URL object
        let url = URL(string: Constants.S01_API_URL)
        
        guard url != nil else {
            return
        }
        // Get a URLSession object
        let session = URLSession.shared
        // Get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check if there were any errors，出現錯誤
            if error != nil || data == nil {
                return
            }
            
            do {
                // Parsing the data into video objects，解析json影片物件
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                //取得資料庫
                let response = try decoder.decode(PlayListResponse.self, from: data!)
//                var newVideos: [VideoModel] = []
//                for item in response.items! {
//                    let newVideo = VideoModel(videoId: item.videoId, title: item.title, description: item.description, thumbnail: item.thumbnail, published: item.published, channelTitle: item.channelTitle)
//
//                    newVideos += [newVideo]
                    //print("\(newVideos.count)")
                
                for item in response.items! {
                    
                    let coreData = CoreVideo(context: moc)
                    
                    coreData.cIsLike = false
                    coreData.cThumbnail = item.thumbnail
                    coreData.cPublished = item.published
                    coreData.cVideoId = item.videoId
                    coreData.cDescription = item.description
                    coreData.cChannelTitle = item.channelTitle
                    coreData.cTitle = item.title
                    
                   // }
                //coreData.saveContext()
                }
                
                
                //確定有值
                if response.items != nil {
                    
                    //主佇列更新畫面
                    DispatchQueue.main.async {
                        
                        self.coreData.saveContext()
                        
                        
//                        if newVideos[0].channelTitle == "X調查", newVideos.count > 0 {
//
//                        }
                        // Call the "videosFetched" method of the delegate
                        //self.delegate?.ch1VideosFetched(coreData)
                    }
                }
                
                //可以階層都印出來
                //dump(response.items)
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
        // Kick off the task
        dataTask.resume()
    }
}
