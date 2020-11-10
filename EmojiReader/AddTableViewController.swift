//
//  AddTableViewController.swift
//  EmojiReader
//
//  Created by Дмитрий Мартьянов on 09.11.2020.
//

import UIKit

class AddTableViewController: UITableViewController {

    var emoji = Emoji(emoji: "", name: "", description: "", isFavorite: false)
    
    @IBOutlet weak var emojiTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    @IBAction func fieldsChanging(_ sender: UITextField) {
        checkForTFsNotEmpty()
    }
    
    
    @IBAction func AddAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "unwindSegue" else {
            return
        }
        
        emoji.emoji = emojiTF.text ?? ""
        emoji.name = nameTF.text ?? ""
        emoji.description = descriptionTF.text ?? ""
    }
    
    private func checkForTFsNotEmpty(){
        let emoji = emojiTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        
        addButton.isEnabled = !emoji.isEmpty && !name.isEmpty && !description.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForTFsNotEmpty()
    }


}
