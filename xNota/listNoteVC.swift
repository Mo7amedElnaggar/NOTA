//
//  listNoteVC.swift
//  xNota
//
//  Created by Mohamed El-Naggar on 6/25/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit

class listNoteVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var emptyListLabel: UILabel!
    
    var notes = [Notes]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove top Margins Programmatically
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        
        loadNotes()
        if notes.count == 0 {
            emptyListLabel.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNotes() {
        
        coreData.loadNotes { (success, savedNotes) in
            if success {
                // DONE
                print("Done , Load Notes")
                notes = savedNotes!
                listTableView.reloadData()
            } else {
                // ERROR
                print("Error While loading Notes")
            }
        }
        
    }
    
    @IBAction func deleteNote(_ sender: UIButton) {
        if let cellView = sender.superview {
            let cell = cellView.superview?.superview as! noteCell

                let indexPath = listTableView.indexPath(for: cell)!
                let note = notes[indexPath.row]
                
                coreData.DeleteRecord(note: note, completion: { (success) in
                    if success {
                        // DONE
                        listTableView.beginUpdates()
                        
                            notes.remove(at: indexPath.row)
                            listTableView.deleteRows(at: [indexPath], with: .fade)
                        
                        listTableView.endUpdates()
                        
                        if notes.count == 0 {
                            emptyListLabel.isHidden = false
                        }
                        
                    } else {
                        // ERROR While deleting you note
                        print("Error")
                    }
                })
        }
    }
}

extension listNoteVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! noteCell
        
        cell.noteView.backgroundColor = UIColor.green
    }
    
}

extension listNoteVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! noteCell
        
        
        cell.setProperity(notes[indexPath.row])
        
        return cell
    }
}
