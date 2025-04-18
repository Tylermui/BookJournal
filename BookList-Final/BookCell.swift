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
    
    
    private func update(with book: Book) {
        TitleLabel.text = book.title
//        StatusLabel.text = book.status

    }

}
