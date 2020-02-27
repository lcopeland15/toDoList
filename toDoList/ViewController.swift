//
//  ViewController.swift
//  toDoList
//
//  Created by Lily Copeland on 2/19/20.
//  Copyright © 2020 Lily Copeland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var defaultData = UserDefaults.standard
    var toDoArray = [String]()
    var toDoNotesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        toDoArray = defaultData.stringArray(forKey: "toDoArray") ?? [String]()
        toDoNotesArray = defaultData.stringArray(forKey: "toDoNotesArray") ?? [String]()
        
    
    }
    
    func saveDefaultsData() {
        defaultData.set(toDoArray, forKey: "toDoArray")
        defaultData.set(toDoNotesArray, forKey: "toDoNotesArray")
        
        
        
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "EditItem"{
    
        
        let destination = segue.destination as! DetailViewController
        
        let index = tableView.indexPathForSelectedRow!.row
        destination.toDoItem = toDoArray[index]
        destination.toDoNote = toDoNotesArray[index]
    } else {
        
        if let selectedPath = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: selectedPath, animated: false)
            
        }
    }
        
    }

    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue){
        let sourceViewController = segue.source as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            toDoNotesArray[indexPath.row] = sourceViewController.toDoNote!
            tableView.reloadRows(at: [indexPath], with: .automatic)

         
            
            
        } else {
            let newIndexPath = IndexPath(item: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            toDoNotesArray.append(sourceViewController.toDoNote!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
       
        
        
    }
    
    
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            editBarButton.title = "Done"
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        }
        else{
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
          
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
        
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        cell.detailTextLabel?.text = toDoNotesArray[indexPath.row]
       
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDoArray.remove(at: indexPath.row)
            toDoNotesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoArray[sourceIndexPath.row]
        let noteToMove = toDoNotesArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoNotesArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
        toDoNotesArray.insert(noteToMove, at: destinationIndexPath.row)
        saveDefaultsData()
        
    }
    
}
  
