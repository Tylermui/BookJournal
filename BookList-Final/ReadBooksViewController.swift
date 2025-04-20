//
//  ReadBooksViewController.swift
//  BookList-Final
//
//  Created by Tyler Mui on 4/19/25.
//

import UIKit

class ReadBooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    var readBooks = [Book]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableHeaderView = UIView()
        
        // Set table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Refresh favorites each time view appears
        refreshReadBooks()
    }
    
    private func refreshReadBooks() {
        // Get all books and filter for favorites
        let allBooks = Book.getBooks()
        readBooks = allBooks.filter { $0.status }
        
        // Update UI
        emptyStateLabel.isHidden = !readBooks.isEmpty
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComposeSegue" {
            if let composeNavController = segue.destination as? UINavigationController,
                // ii.
               let composeViewController = composeNavController.topViewController as? BookComposeViewController {

                // 3.
                composeViewController.bookToEdit = sender as? Book

                composeViewController.onComposeBook = { [weak self] book in
                    book.save()
                    self?.refreshReadBooks()
                }
            }
        }
    }
    

}

// MARK: - Table View Data Source Methods
extension ReadBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        
        let book = readBooks[indexPath.row]
        cell.configure(with: book)

        return cell
    }
}

// MARK: - Table View Delegate Methods
extension ReadBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedBook = readBooks[indexPath.row]
        
        performSegue(withIdentifier: "ComposeSegue", sender: selectedBook)
    }
}
