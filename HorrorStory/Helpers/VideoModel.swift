//
//  videoModel.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/9.
//

import Foundation


class VideoModel {
    
    let videoId: String
    let title: String
    let description: String
    let thumbnail: String
    let published: Date
    let channelTitle: String
    var isLike: Bool = false
    var addNumber: Int = 0
    
    init(videoId: String, title: String, description: String, thumbnail: String, published: Date, channelTitle: String) {
        self.videoId = videoId
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.published = published
        self.channelTitle = channelTitle
    }
    
}
