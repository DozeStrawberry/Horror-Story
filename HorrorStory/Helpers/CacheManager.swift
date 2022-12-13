//
//  CacheManager.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import Foundation

//緩存設定
class CacheManager {
    
    static var cache = [String: Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        
        // 存儲圖片數據，使用url作為key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        
        // 嘗試獲取指定url的數據
        return cache[url]
    }
}
