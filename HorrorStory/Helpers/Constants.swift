//
//  Constants.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import Foundation

struct Constants {
    
    static let API_KEY = "AIzaSyB-NwzDwChm0dq3TrfwWIS04fSYwnGofwc"
    static let NEXTPAGE_TOKEN = "EAAaBlBUOkNBVQ"
    
    static var YT_EMBED_URL = "https://www.youtube.com/embed/"
    
    // X調查API設定
    static let S01_PLAYLIST_ID = "UULFOyshL6rKK1GqwoEfy_ehBg"
    static let S01_API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.S01_PLAYLIST_ID)&key=\(Constants.API_KEY)&maxResults=50&pageToken=\(Constants.NEXTPAGE_TOKEN)"
    
    // 三更研究所MiDnight
    static let S02_PLAYLIST_ID = "PLPoaV1ZADM9GUI249jkUrWWlSQnod3m-J"
    static let S02_API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.S02_PLAYLIST_ID)&key=\(Constants.API_KEY)&maxResults=50&pageToken=\(Constants.NEXTPAGE_TOKEN)"
    
    // 光暗杂学馆
    static let S03_PLAYLIST_ID = "UULF5Lr3SHjkMOl0umL7ynLO4Q"
    static let S03_API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.S03_PLAYLIST_ID)&key=\(Constants.API_KEY)&maxResults=50&pageToken=\(Constants.NEXTPAGE_TOKEN)"
    
    // 脑洞乌托邦
    static let S04_PLAYLIST_ID = "UULF2tQpW0dPiyWPebwBSksJ_g"
    static let S04_API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.S04_PLAYLIST_ID)&key=\(Constants.API_KEY)&maxResults=50&pageToken=\(Constants.NEXTPAGE_TOKEN)"
    
    // 怪談先生-故事是這樣的
    static let S05_PLAYLIST_ID = "PLBvaFbO0JEB2CUVcku6D8rbK2nIbFpKU1"
    static let S05_API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.S05_PLAYLIST_ID)&key=\(Constants.API_KEY)&maxResults=50&pageToken=\(Constants.NEXTPAGE_TOKEN)"
    
    // 陰陽眼見子
    static let S06_PLAYLIST_ID = "PL12UaAf_xzfovF_7X43-06cFJz0COEmPY"
    static let S06_API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.S06_PLAYLIST_ID)&key=\(Constants.API_KEY)&maxResults=50&pageToken=\(Constants.NEXTPAGE_TOKEN)"
    
    
}





