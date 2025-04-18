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
    @IBOutlet weak var summaryField: UITextField!
    @IBOutlet weak var bookTitleField: UITextField!
    
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
        } else {
            book = Book(title: title,
//                        status: ReadingStatus,
                        summary: summaryField.text)
        }
        onComposeBook?(book)
        
        dismiss(animated: true)
    }
    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func tapFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
//        if sender.isSelected {
//            book.addToFavorites()
//        } else {
//            book.removeFromFavorites()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = bookToEdit {
            bookTitleField.text = book.title
            summaryField.text = book.summary
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    private func presentAlert(title: String, message: String) {
        // 1.
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        // 2.
        let okAction = UIAlertAction(title: "OK", style: .default)
        // 3.
        alertController.addAction(okAction)
        // 4.
        present(alertController, animated: true)
    }
}
