//
//  EmojiData+CoreDataProperties.swift
//  EmojiReader
//
//  Created by Дмитрий Мартьянов on 23.11.2020.
//
//

import Foundation
import CoreData


extension EmojiData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmojiData> {
        return NSFetchRequest<EmojiData>(entityName: "EmojiData")
    }

    @NSManaged public var emoji: String?
    @NSManaged public var emojidescription: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?

}

extension EmojiData : Identifiable {

}
