//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by Дмитрий Мартьянов on 07.11.2020.
//

import UIKit
class EmojiTableViewController: UITableViewController {
    
    var emojiArr = [
        Emoji(emoji: "👹", name: "Pasha", description: "Meets the Pasha", isFavorite: false),
        Emoji(emoji: "🤠", name: "Arthur Morgan", description: "LENNYYY!", isFavorite: false),
        Emoji(emoji: "📈", name: "Stonks", description: "Buisness goes up", isFavorite: false),
        Emoji(emoji: "🎃", name: "Jack", description: "Happy Halloween!", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.title = "EmojiReader😎"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
   @IBAction func unwindSegueToMainScreen(unwindSegue: UIStoryboardSegue){
    guard unwindSegue.identifier == "unwindSegue" else {
        return
    }
    guard let svc = unwindSegue.source as? AddTableViewController else {
        return
    }
    let name = svc.emoji.name
    let emoji = svc.emoji.emoji
    let description = svc.emoji.description
    emojiArr.append(Emoji(emoji: emoji, name: name, description: description, isFavorite: false))
    tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojiArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        cell.set(object: emojiArr[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = moveToFavoriteAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [favAction])
    }
    
    func moveToFavoriteAction(indexPath:IndexPath)->UIContextualAction{
        
        let action = UIContextualAction(style: .destructive, title: "Favorite") { (action, view, completion) in
            self.emojiArr[indexPath.row].isFavorite = !self.emojiArr[indexPath.row].isFavorite
            let deletedRow = self.emojiArr.remove(at: indexPath.row)
            self.emojiArr.insert(deletedRow, at: deletedRow.isFavorite ? 0 : self.emojiArr.count)
            self.tableView.reloadData()
            
            completion(true)
            
        }
        action.backgroundColor = self.emojiArr[indexPath.row].isFavorite
            ? UIColor.systemGreen : UIColor.systemGray
        
        return action
    }
    
    
    //Реализация удаления записей
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojiArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //Реализация функции перемещения записей
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removedEmoji = emojiArr.remove(at: sourceIndexPath.row)
        emojiArr.insert(removedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
}
