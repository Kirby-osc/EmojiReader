//
//  AddTableViewController.swift
//  EmojiReader
//
//  Created by Дмитрий Мартьянов on 09.11.2020.
//

import UIKit

class AddTableViewController: UITableViewController {

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
