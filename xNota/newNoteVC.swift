//
//  newNoteVC.swift
//  xNota
//
//  Created by Mohamed El-Naggar on 6/25/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit

class newNoteVC: UIViewController {

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
    
    @IBAction func saveNote(_ sender: UIButton) {
        
        guard let title = noteTitle.text?.trimmed , title != "" else { return }
        guard let text = noteText.text?.trimmed , text != "" else { return }
        
        coreData.saveData(note: (title , text)) { (success) in
            if success {
                // DONE
                let firstVC = navigationController?.viewControllers[0] as! listNoteVC
                firstVC.loadNotes()
                if firstVC.notes.count != 0 {
                    firstVC.emptyListLabel.isHidden = true
                }
                navigationController?.popViewController(animated: true)
                
            } else {
                // ERROR 
                print("ERROR while Saving you note")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
