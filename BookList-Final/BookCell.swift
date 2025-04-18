//
//  BookCell.swift
//  BookList-Final
//
//  Created by Tyler Mui on 4/6/25.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    var book: Book!
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func configure(with book: Book!) {
        self.book = book
        
        update(with: book)
    }
    
    private func update(with book: Book) {
        TitleLabel.text = book.title
        if book.status {
            StatusLabel.text = "Read"
            StatusLabel.textColor = UIColor.systemGreen
        } else {
            StatusLabel.text = "Unread"
            StatusLabel.textColor = UIColor.systemRed
        }

    }

}
