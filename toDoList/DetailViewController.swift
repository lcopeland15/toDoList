 //
//  DetailViewController.swift
//  toDoList
//
//  Created by Lily Copeland on 2/19/20.
//  Copyright © 2020 Lily Copeland. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var toDoField: UITextField!
    var toDoItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDoItem = toDoItem{
            toDoField.text = toDoItem
            
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "unWindFromSave" {
            toDoItem = toDoField.text
            
        }
        
        
    }

    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode{
        dismiss(animated: true, completion: nil)
            
        }
        else{
            navigationController?.popViewController(animated: true)
        }
         
    }
    

}
