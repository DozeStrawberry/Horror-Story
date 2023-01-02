//
//  Ch1UrlParseModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/15.
//
import Foundation
import CoreData


class ChannelUrlParseModel {
    
    private var coreData = CoreDataStack()
    
    func checkData() {
        let moc = coreData.persistentContainer.viewContext
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        
        if let movieCount = try? moc.count(for: request), movieCount > 0 {
            print("already")
            return
        }
        
        var urlAry:[String] = []
        
        urlAry = [Constants.S01_API_URL,
                  Constants.S02_API_URL,
                  Constants.S03_API_URL,
                  Constants.S04_API_URL,
                  Constants.S05_API_URL,
                  Constants.S06_API_URL]
        
        getVideosAry(urlAry) { success in
            
        }
        
    }
    
    
    func getVideosAry(_ urlString: [String], completion: @escaping(_ success: Bool)->Void) {
        
        let moc = coreData.persistentContainer.viewContext
        
        
        for urlString in urlString
        {
            let url = URL(string: urlString)
            
            guard url != nil else {
                return
            }
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url!) { data, response, error in
                
                if error != nil || data == nil {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let response = try decoder.decode(PlayListResponse.self, from: data!)
                    
                    var newVideos: [CoreVideo] = []
                    
                    for item in response.items! {
                        
                        let newVideo = CoreVideo(context: moc)
                        
                        //CoreVideo.setValue(false, forKey: "cIsLike")
                        newVideo.isLike = false
                        //newVideo.cIsLike = false
                        newVideo.cThumbnail = item.thumbnail
                        newVideo.cPublished = item.published
                        newVideo.cVideoId = item.videoId
                        newVideo.cDescription = item.description
                        newVideo.cChannelTitle = item.channelTitle
                        newVideo.cTitle = item.title
                        
                        newVideos += [newVideo]
                        
                    }
                    
                    self.coreData.saveContext()
                    
                    
                    //可以階層都印出來
                    //dump(response.items)
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
            dataTask.resume()
        }
    }
    
    
    func getVideos(_ urlString: String, cChannelTitle:String?) {
        
        let moc = coreData.persistentContainer.viewContext
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        let request: NSFetchRequest<CoreVideo> = CoreVideo.fetchRequest()
        
        if cChannelTitle != nil
        {
            request.predicate = NSPredicate(format:"cChannelTitle = %@", cChannelTitle!)
        }
        
        if let movieCount = try? moc.count(for: request), movieCount > 0 {
            print("get already")
            return
        }
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error != nil || data == nil {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(PlayListResponse.self, from: data!)
                
                var newVideos: [CoreVideo] = []
                
                for item in response.items! {
                    
                    let newVideo = CoreVideo(context: moc)
                    
                    //CoreVideo.setValue(false, forKey: "cIsLike")
                    newVideo.isLike = false
                    //newVideo.cIsLike = false
                    newVideo.cThumbnail = item.thumbnail
                    newVideo.cPublished = item.published
                    newVideo.cVideoId = item.videoId
                    newVideo.cDescription = item.description
                    newVideo.cChannelTitle = item.channelTitle
                    newVideo.cTitle = item.title
                    
                    newVideos += [newVideo]
                    
                }
                
                self.coreData.saveContext()
                
                
                //可以階層都印出來
                //dump(response.items)
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
    }
    
    
    func updateVideos(_ channelVideos:[CoreVideo], completion: @escaping(_ success: Bool)->Void) {
        
        var urlAry:[String] = []
        
        urlAry = [Constants.S01_API_URL,
                  Constants.S02_API_URL,
                  Constants.S03_API_URL,
                  Constants.S04_API_URL,
                  Constants.S05_API_URL,
                  Constants.S06_API_URL]
        
        getVideosAry(urlAry) { success in
            
        
    }
    
//    func updateAPIVideos(_ channelVideos:[CoreVideo], completion: @escaping(_ success: Bool)->Void) {
//
//        let moc = coreData.persistentContainer.viewContext
//
//        var urlAry:[String] = []
//
//        urlAry = [Constants.S01_API_URL,
//                  Constants.S02_API_URL,
//                  Constants.S03_API_URL,
//                  Constants.S04_API_URL,
//                  Constants.S05_API_URL,
//                  Constants.S06_API_URL]
//
//        for i in 0 ... urlAry.count - 1 {
//
//            let url = URL(string: urlAry[i])
//
//            guard url != nil else {
//                return
//            }
//
//            let session = URLSession.shared
//
//            let dataTask = session.dataTask(with: url!) { data, response, error in
//
//                //request.predicate = NSPredicate(format: "videoId == %@", response.)
//
//                if error != nil || data == nil {
//                    return
//                }
//
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .iso8601
//
//                    let response = try decoder.decode(PlayListResponse.self, from: data!)
//
//                    //var videoList: [NSManagedObject] = []
//                    var newVideos: [CoreVideo] = []
//
//                    for index in 0 ... channelVideos.count - 1 {
//
//                    for item in response.items! {
//
//                        if item.channelTitle == channelVideos[index].cChannelTitle {
//
//                            if  item.videoId != channelVideos[index].cVideoId{
//                                let newVideo = CoreVideo(context: moc)
//
//                                newVideo.isLike = false
//                                newVideo.cThumbnail = item.thumbnail
//                                newVideo.cPublished = item.published
//                                newVideo.cVideoId = item.videoId
//                                newVideo.cDescription = item.description
//                                newVideo.cChannelTitle = item.channelTitle
//                                newVideo.cTitle = item.title
//
//                                newVideos += [newVideo]
//
//                            }
//                        }
//
//
//                        }
//
//                        self.coreData.saveContext()
//                    }
//
//
//                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreVideo")
//                    let coreNumber = try moc.count(for: fetchRequest)
//                    print("coreNumber is \(coreNumber)")
//
//                }
//                catch {
//                    print(error.localizedDescription)
//                }
//
//            }
//            dataTask.resume()
//
//        }
//    }
}
}
