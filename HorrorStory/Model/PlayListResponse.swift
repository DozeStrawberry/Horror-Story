//
//  PlayListResponse.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/6.
//

import Foundation

struct PlayListResponse: Decodable {
    
    var items: [PlayListVideo]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
    }
    
    init (from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([PlayListVideo].self, forKey: .items)
        
    }
}


