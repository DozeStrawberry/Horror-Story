//
//  PlayListModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import Foundation

struct PlayListVideo: Decodable {
    
    //自己設定名稱
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    var channelTitle = ""
    
    
    //設定跟json匹配檔案
    enum CodingKeys: String, CodingKey {
        
        //字典全部值
        case snippet
        case thumbnails
        case high
        case resourceId
        
        //單一值
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
        case channelTitle
    }
    
    
    //解碼jsonb內容，模擬資料庫位置
    init (from decoder: Decoder) throws {
        
        //解碼匹配內容
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //對照字典內容取值
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse the publish data，日期型別
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        self.channelTitle = try snippetContainer.decode(String.self, forKey: .channelTitle)
        
        // Parse thumbanails，縮圖
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        // Parse url
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse Video ID
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
    }
    
}
