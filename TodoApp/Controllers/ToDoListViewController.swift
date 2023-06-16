//
//  ViewController.swift
//  TodoApp
//
//  Created by MacBook on 13.06.2023.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var items = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
       
       
//
//        let newItem = Item()
//        newItem.title = "take a nap"
//
//        let newItem2 = Item()
//        newItem2.title = "take a second nap"
//
//        let newItem3 = Item()
//        newItem3.title = "take a third nap"
//
//        items.append(newItem)
//        items.append(newItem2)
//        items.append(newItem3)
//
        loadData()
//
        
//        if let array = defaults.array(forKey: "itemsArray") {
//            print(array)
//            itemsString = array as! [String]
//            for name in itemsString {
//                let newItem = Item()
//                newItem.title = name
//                items.append(newItem)
//            }
//        }
        
        // Do any additional setup after loading the view.
    }
    
    
//MARK: - DataSource methods
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
       // Configure the cell’s contents.
        cell.textLabel!.text = items[indexPath.row].title
        
        cell.accessoryType = items[indexPath.row].isSelected ? .checkmark : .none
        print("here?")
        print("the items are : \(items.first?.title)")
//        if items[indexPath.row].isSelected == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
       return cell
    }
    
    //MARK: - Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        
        items[indexPath.row].isSelected = !items[indexPath.row].isSelected
         
        
        saveData()
//        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
//            cell?.accessoryType = .checkmark      } else {
//                cell?.accessoryType = .none
//            }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        print("pressed")
        let alert = UIAlertController(title: "Add a new item", message: "smth", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { alert in

            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.isSelected = false
            self.items.append(newItem)
            self.saveData()
            //                self.defaults.set(self.itemsString, forKey: "itemsArray")
            
            
            
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    func saveData() {
        let encoder = PropertyListEncoder()
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
           items = try context.fetch(request)
            
        }
        catch {
            print("Error fetching from context: \(error)")
        }

    }
}



