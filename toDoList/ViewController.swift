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
    
    var toDoArray = ["Buy Coffe", "Walk Dog", "Clean Yoga Mat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "EditItem"{
        
        let destination = segue.destination as! DetailViewController
        
        let index = tableView.indexPathForSelectedRow!.row
        destination.toDoItem = toDoArray[index]
    }
        
    }

    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue){
        let sourceViewController = segue.source as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            
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
        
        return cell
        
    }

    
}
