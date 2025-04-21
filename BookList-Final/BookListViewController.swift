//
//  ViewController.swift
//  BookList-Final
//
//  Created by Tyler Mui on 4/6/25.
//

import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var EmptyStateLabel: UILabel!
    @IBOutlet weak var BookTableView: UITableView!
    
    @IBAction func tapNewBookButton(_ sender: Any) {
        performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    
    var books = [Book]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        BookTableView.tableHeaderView = UIView()
        BookTableView.dataSource = self
        BookTableView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        refreshBooks()
    }
    
    
    private func refreshBooks() {
        // 1.
        let books = Book.getBooks()
        
        // 3.
        self.books = books
        // 4.
        EmptyStateLabel.isHidden = !books.isEmpty
        // 5.
        BookTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1.
        if segue.identifier == "ComposeSegue" {
            // 2.
            // i.
            if let composeNavController = segue.destination as? UINavigationController,
                // ii.
               let composeViewController = composeNavController.topViewController as? BookComposeViewController {

                // 3.
                composeViewController.bookToEdit = sender as? Book

                composeViewController.onComposeBook = { [weak self] book in
                    book.save()
                    self?.refreshBooks()
                }
            }
        }
    }

}

// Table View Data Source Methods
extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        let book = books[indexPath.row]
        cell.configure(with: book)
        
        return cell
    }
    
    //delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1.
        if editingStyle == .delete {
            // 2.
            books.remove(at: indexPath.row)
            // 3.
            Book.save(books, forKey: "books")
            // 4.
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


// Table View Delegate Methods
extension BookListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedBook = books[indexPath.row]
        
        performSegue(withIdentifier: "ComposeSegue", sender: selectedBook)
    }
}
