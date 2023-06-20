//
//  CategoryViewController.swift
//  TodoApp
//
//  Created by MacBook on 20.06.2023.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new item", message: "smth", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { alert in
            print("here1")
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            //                self.defaults.set(self.itemsString, forKey: "itemsArray")
        }
        alert.addTextField { alertTextField in
            print("here2")
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        print("here3")
        alert.addAction(action)
        print("here4")
        present(alert, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.identifier.categoryCell, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    //MARK: - Delegate:
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(categories[indexPath.row])
        performSegue(withIdentifier: K.identifier.segueToItems, sender: self)
        
        
        
        //        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
        //            cell?.accessoryType = .checkmark      } else {
        //                cell?.accessoryType = .none
        //            }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {

            do {
               categories = try context.fetch(request)
                
            }
            catch {
                print("Error fetching from context: \(error)")
            }
            tableView.reloadData()

        
    }
    func saveCategories() {
        do {
            try context.save() }
        catch {
            print(error)
            
        }
        tableView.reloadData()
    }

}
