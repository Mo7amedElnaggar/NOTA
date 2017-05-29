//
//  coreData.swift
//  xNota
//
//  Created by Mohamed El Naggar on 5/29/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import Foundation
import CoreData

class coreData {
    
    class func loadNotes(completion: (_ success: Bool , _ notes: [Notes]?) -> Void) {
        
        var listNotes = [Notes]()
        
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        do {
            listNotes = try context.fetch(fetchRequest)
            
            completion(true , listNotes)
            
        } catch {
            completion(false , nil)
        }
    }
    
    
    class func DeleteRecord(note: Notes , completion: (_ success: Bool) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [Notes]
        
        for object in resultData {
            // We managing to add id to each Note
            if object.title == note.title && object.text == note.text {
                context.delete(object)
                break
            }
        }
        
        do {
            try context.save()
            //print("saved!")
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    class func saveData(note: (String , String) , completion: (_ success: Bool) -> Void) {
        let newNote = Notes(context: context)
        newNote.title = note.0
        newNote.text = note.1
        appDelegate.saveContext()
        // DOne
        completion(true)
    }
    
}
