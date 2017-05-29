//
//  NewNote.swift
//  NoteAPP
//
//  Created by Mohamed El-Naggar on 3/13/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit
import CoreData

class NewNote: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!

    
    /* Constrains */
    
    @IBOutlet weak var topTitleConstrain: NSLayoutConstraint!
    @IBOutlet weak var topTextConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var topTitleCC: NSLayoutConstraint!
    @IBOutlet weak var widthTitleCC: NSLayoutConstraint!
    
    @IBOutlet weak var topTextCC: NSLayoutConstraint!
    
    @IBOutlet weak var leftAddButtonCC: NSLayoutConstraint!

    /* End Constrains */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configerConstrains()
    }
    
    func configerConstrains() {
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        topTitleConstrain.constant = height / 8.0
        
        topTextConstrain.constant = height / 10.0
        
        topTitleCC.constant = height / 20.0
        widthTitleCC.constant = width / 2
        
        topTextCC.constant = topTitleCC.constant / 2

        leftAddButtonCC.constant = width / 10
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
        guard let title = noteTitle.text , title != "" else { return }
        guard let text = noteText.text , text != "" else { return }
        
        coreData.saveData(note: (title , text)) { (success) in
            if success {
                alertME("Done", "Your Note Save successfully")
                clearData()
            } else {
                alertME("Error", "Error While save in Core data , please try again")
            }
        }
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        configerConstrains()
        
    }
    

}
