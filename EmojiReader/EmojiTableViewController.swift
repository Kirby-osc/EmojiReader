//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by Дмитрий Мартьянов on 07.11.2020.
//

import UIKit
import CoreData
class EmojiTableViewController: UITableViewController {
    
    var context = CoreDataStack().persistentContainer.viewContext
    
    var emojis = [EmojiData]()
    
    fileprivate func fetchEmoji() {
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let fetchRequest: NSFetchRequest<EmojiData> = EmojiData.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "isFavorite")
        let sort = NSSortDescriptor(key: "isFavorite", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do {
            emojis = try context.fetch(fetchRequest)
            
            tableView.reloadData()
        } catch {
           // print("Error: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.title = "EmojiReader😎"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        fetchEmoji()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "EditEmojiSegue" else {
//            return
//        }
//
//        let destinationNC = segue.destination as! UINavigationController
//        let destinationTVC = destinationNC.topViewController as! AddTableViewController
//        destinationTVC.title = "Edit"
//        destinationTVC.emoji = emojis[tableView.indexPathForSelectedRow!.row]
//    }
    @IBAction func unwindSegueToMainScreen(unwindSegue: UIStoryboardSegue){
        guard unwindSegue.identifier == "unwindSegue" else {
            return
        }
        
        
        guard let svc = unwindSegue.source as? AddTableViewController else {
            return
        }
        let newIndexPath = IndexPath(row: emojis.count, section: 0)
        let emoji = svc.emoji
        
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            emojis[selectedIndexPath.row].emoji = emoji.emoji
            emojis[selectedIndexPath.row].name  = emoji.name
            emojis[selectedIndexPath.row].emojidescription = emoji.description
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newEmoji = EmojiData(context: context)
            newEmoji.emoji = emoji.emoji
            newEmoji.name = emoji.name
            newEmoji.emojidescription = emoji.description
            newEmoji.isFavorite = false
           
            emojis.append(newEmoji)
        }
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
        
        fetchEmoji()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojis.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        cell.set(object: emojis[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = moveToFavoriteAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [favAction])
    }

    func moveToFavoriteAction(indexPath:IndexPath)->UIContextualAction{

        let action = UIContextualAction(style: .destructive, title: "Favorite") { (action, view, completion) in
            let isFav = self.emojis[indexPath.row].isFavorite
            self.emojis[indexPath.row].isFavorite = !isFav
            
            do{
                try self.context.save()
            }catch{
                print(error.localizedDescription)
            }


            self.fetchEmoji()

            completion(true)

        }
        
        action.backgroundColor = self.emojis[indexPath.row].isFavorite
            ? UIColor.systemGreen : UIColor.systemGray

        return action
    }
    
    
    //Реализация удаления записей
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedEmoji = emojis.remove(at: indexPath.row)
            context.delete(removedEmoji)
            do {
                try context.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch  {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
//        //Реализация функции перемещения записей
//        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//            return true
//        }
//
//        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//            let removedEmoji = emojis.remove(at: sourceIndexPath.row)
//            emojis.insert(removedEmoji, at: destinationIndexPath.row)
//
//            do {
//                try context.save()
//            } catch  {
//                print(error.localizedDescription)
//            }
//
//        }
}
