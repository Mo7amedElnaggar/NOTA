//
//  NotesList.swift
//  NoteAPP
//
//  Created by Mohamed El-Naggar on 3/13/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit
import CoreData // for FetchRequest

class NotesList: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var listNotes = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonA(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotes.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
            
            let result = try? context.fetch(fetchRequest)
            let resultData = result as! [Notes]
            
            for object in resultData {
                if object.title == listNotes[indexPath.row].title {
                    context.delete(object)
                }
            }
            
            do {
                try context.save()
                //print("saved!")
            } catch {
                alertME("ERROr", "Try again")
            }
            listNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteCell
        
        cell.initialize(listNotes[indexPath.row])
        
        return cell
    }
    
    
    func loadNotes(){
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        do {
            listNotes = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            alertME("Error" , "Error Occurrs while getting Data from Local phone , Please try Later")
        }
    }
    
    func alertME(_ title: String , _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        
        let aTime = DispatchTime.now() + 5
        
        DispatchQueue.main.asyncAfter(deadline: aTime){
            alert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
}
