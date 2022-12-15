//
//  LikeVideo+CoreDataProperties.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/15.
//
//

import Foundation
import CoreData


extension LikeVideo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikeVideo> {
        return NSFetchRequest<LikeVideo>(entityName: "LikeVideo")
    }

    @NSManaged public var cVideoId: String?
    @NSManaged public var cTitle: String?
    @NSManaged public var cDescription: String?
    @NSManaged public var cThumbnail: String?
    @NSManaged public var cPublished: Date?
    @NSManaged public var cChannelTitle: String?
    @NSManaged public var cIsLike: Bool

}

extension LikeVideo : Identifiable {

}
