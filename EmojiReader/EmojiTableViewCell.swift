//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by Дмитрий Мартьянов on 08.11.2020.
//

import UIKit
import CoreData
class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var discription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(object: EmojiData){
        self.emojiLabel.text = object.emoji
        self.name.text = object.name
        self.discription.text = object.emojidescription
    }

}
