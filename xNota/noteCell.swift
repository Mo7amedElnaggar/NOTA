//
//  noteCell.swift
//  xNota
//
//  Created by Mohamed El-Naggar on 6/25/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import UIKit

class noteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var noteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.noteView.roundCorners(15)
        self.noteView.makeUIViewShadow()
    }
    
    func setProperity(_ cellData: Notes) {
        
        self.noteTitle.text = cellData.title
        self.noteText.text = cellData.text
        
    }
    
}
