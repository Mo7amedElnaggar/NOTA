//
//  NotesList.swift
//  NoteAPP
//
//  Created by Mohamed El-Naggar on 3/13/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit
import CoreData // for FetchRequest

class NotesList: UIViewController , UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var listNotes = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 0.3, green: 0.55, blue: 0.43, alpha: 0.5)
        loadAllNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonA(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func DeleteRecord(_ sender: Any) {
        let btn = sender as! UIButton
        let indexPath = NSIndexPath(item: btn.tag, section: 0) as IndexPath
        
        let note: Notes = listNotes[indexPath.row]
    
        coreData.DeleteRecord(note: note) { (success) in
            if success {
                listNotes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

            } else {
                alertME("Error", "Error While Deleting from CoreData")
            }
        }
        
        let cells = tableView.visibleCells as! [NoteCell]
        
        // update Cell Tags after Remove
        var i = 0
        for cell in cells {
            cell.buttonDelete.tag = i
            i += 1
        }
    }

    func loadAllNotes(){
        
        coreData.loadNotes { (success, notes) in
            if success {
                self.listNotes = notes!
            } else {
                alertME("Error", "Error While Load Your Notes form CoreData")
            }
        }
    }
    
    private func alertME(_ title: String , _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        
        let aTime = DispatchTime.now() + 5
        
        DispatchQueue.main.asyncAfter(deadline: aTime){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

extension NotesList: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteCell
        cell.initialize(listNotes[indexPath.row])
        cell.buttonDelete.tag = indexPath.row
        
        return cell
    }
}
