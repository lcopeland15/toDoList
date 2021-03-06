 //
//  DetailViewController.swift
//  toDoList
//
//  Created by Lily Copeland on 2/19/20.
//  Copyright © 2020 Lily Copeland. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var toDoNoteView: UITextView!
    var toDoItem: String?
    var toDoNote: String?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDoItem = toDoItem{
            toDoField.text = toDoItem
            self.navigationItem.title = "Edit To Do Item"
            
        } else{
            self.navigationItem.title = "New To Do Item "
        }
        if let toDoNote = toDoNote {
            toDoNoteView.text = toDoNote
        }
        enableDisableSaveButton()
        toDoField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "unWindFromSave" {
            toDoItem = toDoField.text
            toDoNote = toDoNoteView.text
        }
        
        
    }
    func enableDisableSaveButton(){
    if let toDoFieldCount = toDoField.text?.count, toDoFieldCount > 0 {
               saveBarButton.isEnabled = true
           }
           else{
               saveBarButton.isEnabled = false
           }
    }
    

      
    
    @IBAction func toDoFieldChanged(_ sender: UITextField) {
        enableDisableSaveButton()
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
