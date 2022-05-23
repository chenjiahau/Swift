//
//  TodoItemCellTableViewCell.swift
//  TodoList
//
//  Created by chen Ivan on 2022/5/22.
//

import UIKit

class TodoItemCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var todoLabel: UILabel!
    
    var id: Int = 0 {
       didSet {
           self.cellView.backgroundColor = UIColor(named: "Blue Item")
           if id % 2 == 0 {
               self.cellView.backgroundColor = UIColor(named: "Blue Item")
           } else {
               self.cellView.backgroundColor = UIColor(named: "Purple Item")
           }
       }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
