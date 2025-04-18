//
//  BookComposeViewController.swift
//  BookList-Final
//
//  Created by Tyler Mui on 4/15/25.
//

import UIKit

class BookComposeViewController: UIViewController {

    var bookToEdit: Book?
    var book: Book!
    var onComposeBook: ((Book) -> Void)? = nil 
    var status: Bool = false
    var isFavorite: Bool = false
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func tapStatusSwitch(_ sender: UISwitch) {
        status = sender.isOn
        updateStatusLabel()
    }
    
    @IBOutlet weak var bookTitleField: UITextField!
    @IBOutlet weak var summaryField: UITextView!
    
    @IBAction func tapDoneButton(_ sender: Any) {
        guard let title = bookTitleField.text,
              !title.isEmpty
        else {
            presentAlert(title: "Oops...", message: "Make sure to add a title!")
            return
        }
        
        var book: Book
        
        if let editBook = bookToEdit {
            book = editBook
            book.title = title
            book.summary = summaryField.text
            book.status = status
            book.isFavorite = isFavorite            
            updateStatusLabel()
        } else {
            book = Book(title: title,
                        status: status,
                        summary: summaryField.text,
                        isFavorite: isFavorite)
        }
        onComposeBook?(book)
        
        dismiss(animated: true)
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func tapFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        isFavorite = !isFavorite
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.summaryField.layer.borderWidth = 1.0;
        self.summaryField.layer.cornerRadius = 8;
        self.summaryField.layer.borderColor = UIColor.gray.cgColor;
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        
        if let book = bookToEdit {
            bookTitleField.text = book.title
            summaryField.text = book.summary
            status = book.status
            statusSwitch.isOn = status
            isFavorite = book.isFavorite
            favoriteButton.isSelected = isFavorite
            
            updateStatusLabel()
            self.title = "Edit Book"
        }
    }

    
    private func updateStatusLabel() {
        statusLabel.text = status ? "Read" : "Unread"
    }
    
    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
