//
//  Constants.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import Foundation

struct Constants {
    
    static let API_KEY = "AIzaSyB-NwzDwChm0dq3TrfwWIS04fSYwnGofwc"
    
    static let XSURVEY_PLAYLIST_ID = "UULFOyshL6rKK1GqwoEfy_ehBg"
    static let XSURVEY_NEXTPAGE_TOKEN = "EAAaBlBUOkNBVQ"
    static let XSURVEY_API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.XSURVEY_PLAYLIST_ID)=\(Constants.API_KEY)&maxResults=50&pageToken=\(Constants.XSURVEY_NEXTPAGE_TOKEN)"
    
}


//struct Constants {
//
//    static var API_KEY = "AIzaSyB-NwzDwChm0dq3TrfwWIS04fSYwnGofwc"
//    static var PLAYLIST_ID = "UULF2D6eRvCeMtcF5OGHf1-trw"
//    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
//
//    // TableViewCell命名
//    static var VIDEOCELL_ID = "VideoCell"
//    static var YT_EMBED_URL = "https://www.youtube.com/embed/"
//}
