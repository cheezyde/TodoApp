//
//  ViewController.swift
//  TodoApp
//
//  Created by MacBook on 13.06.2023.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var items = ["make a toast", "study french", "take a nap"]
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let array = defaults.array(forKey: "itemsArray") {
            print(array)
            items = array as! [String]
        }
        
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
        cell.textLabel!.text = items[indexPath.row]
           
       return cell
    }
    
    //MARK: - Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = .checkmark      } else {
                cell?.accessoryType = .none
            }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        print("pressed")
        let alert = UIAlertController(title: "Add a new item", message: "smth", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { alert in
            if let text = textField.text{
                self.items.append(text)
                self.defaults.set(self.items, forKey: "itemsArray")
                self.tableView.reloadData()
                
            }
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

