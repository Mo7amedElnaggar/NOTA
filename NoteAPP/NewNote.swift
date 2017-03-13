//
//  NewNote.swift
//  NoteAPP
//
//  Created by Mohamed El-Naggar on 3/13/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit

class NewNote: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonA(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // handle Keyboard using 'touchesBegan'
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func addNewNote(_ sender: Any) {
        let newNote = Notes(context: context)
        newNote.title = noteTitle.text
        newNote.text = noteText.text
        appDelegate.saveContext()
        alertME("DONE", "Your note saved Successfully")
        clearData()
    }
    
    func alertME(_ title: String , _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        let aTime = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: aTime) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func clearData(){
        noteText.text = ""
        noteTitle.text = ""
    }

}
