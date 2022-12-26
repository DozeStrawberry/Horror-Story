//
//  URLParse.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import Foundation

//取得影片協議
protocol ModelDelegate {
    
    func videosFetched(_ videos: [VideoModel])
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
            
            if error != nil || data == nil {
                return
            }
            
            do {
                // 解析json影片物件
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                //取得資料庫
                let response = try decoder.decode(PlayListResponse.self, from: data!)
                var newVideos: [VideoModel] = []
                for item in response.items! {
                    let newVideo = VideoModel(videoId: item.videoId, title: item.title, description: item.description, thumbnail: item.thumbnail, published: item.published, channelTitle: item.channelTitle)
                    
                    newVideos += [newVideo]
                }
                
                
                //確定有值
                if response.items != nil {
                    
                    //主佇列更新畫面
                    DispatchQueue.main.async {
                        // Call the "videosFetched" method of the delegate
                        self.delegate?.videosFetched(newVideos)
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




