//
//  CoreVideo+CoreDataProperties.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/27.
//
//

import Foundation
import CoreData


extension CoreVideo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreVideo> {
        return NSFetchRequest<CoreVideo>(entityName: "CoreVideo")
    }

    @NSManaged public var cChannelTitle: String?
    @NSManaged public var cDescription: String?
    @NSManaged public var cIsLike: NSNumber
    @NSManaged public var cPublished: Date?
    @NSManaged public var cThumbnail: String?
    @NSManaged public var cTitle: String?
    @NSManaged public var cVideoId: String?
    
    var isLike: Bool {
        get {
            return Bool(truncating: cIsLike)
        }
        set {
            cIsLike = NSNumber(value: newValue)
        }
    }
    


}

extension CoreVideo : Identifiable {
   
}
