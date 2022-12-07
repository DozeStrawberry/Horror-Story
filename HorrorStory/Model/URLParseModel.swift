//
//  URLParse.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import Foundation

//取得影片協議
protocol ModelDelegate {
    
    func videosFetched(_ videos: [PlayListVideo])
}


class URLParseModel {
    
    var delegate: ModelDelegate?
    
    func getVideos(channelAPI: String) {
        
        let url = URL(string: channelAPI)
        
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
                //確定有值
                if response.items != nil {
                    
                    //主佇列更新畫面
                    DispatchQueue.main.async {
                        // Call the "videosFetched" method of the delegate
                        self.delegate?.videosFetched(response.items!)
                    }
                }
                
                //可以階層都印出來
                //dump(response)
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
        // Kick off the task
        dataTask.resume()
    }
}




//import Foundation
//
////取得影片協議
//protocol ModelDelegate {
//    func videosFetched(_ videos: [Video])
//}
//
//class Model {
//
//    var delegate: ModelDelegate?
//
//    func getVideos() {
//
//        // Create a URL object
//        let url = URL(string: Constants.API_URL)
//
//        guard url != nil else {
//            return
//        }
//        // Get a URLSession object
//        let session = URLSession.shared
//        // Get a data task from the URLSession object
//        let dataTask = session.dataTask(with: url!) { data, response, error in
//
//            // Check if there were any errors，出現錯誤
//            if error != nil || data == nil {
//                return
//            }
//
//            do {
//                // Parsing the data into video objects，解析json影片物件
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//
//                //取得資料庫
//                let response = try decoder.decode(Response.self, from: data!)
//                //確定有值
//                if response.items != nil {
//
//                    //主佇列更新畫面
//                    DispatchQueue.main.async {
//                        // Call the "videosFetched" method of the delegate
//                        self.delegate?.videosFetched(response.items!)
//                    }
//                }
//
//                //可以階層都印出來
//                //dump(response)
//            }
//            catch {
//
//            }
//
//        }
//        // Kick off the task
//        dataTask.resume()
//    }
//}
//
