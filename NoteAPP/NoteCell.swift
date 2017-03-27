//
//  NoteCell.swift
//  NoteAPP
//
//  Created by Mohamed El-Naggar on 3/13/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit
import CoreData

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noteText.isEditable = false // means u can not edit Text While Showing it
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteNote(_ sender: Any) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        
        let result = try? context.fetch(fetchRequest)
        
        let resultData = result as! [Notes]
        for object in resultData {
            if object.title == self.noteTitle.text && object.text == self.noteText.text {
                context.delete(object)
            }
        }
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func initialize(_ note: Notes){
        noteTitle.text = note.title
        noteText.text = note.text
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
