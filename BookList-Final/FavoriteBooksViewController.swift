//
//  FavoriteBooksViewController.swift
//  BookList-Final
//

import UIKit

class FavoriteBooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    // Array to store favorite books
    var favoriteBooks = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide top cell separator
        tableView.tableHeaderView = UIView()
        
        // Set table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Refresh favorites each time view appears
        refreshFavoriteBooks()
    }
    
    private func refreshFavoriteBooks() {
        // Get all books and filter for favorites
        let allBooks = Book.getBooks()
        favoriteBooks = allBooks.filter { $0.isFavorite }
        
        // Update UI
        emptyStateLabel.isHidden = !favoriteBooks.isEmpty
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
                    self?.refreshFavoriteBooks()
                }
            }
        }
    }
}

// MARK: - Table View Data Source Methods
extension FavoriteBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        
        let book = favoriteBooks[indexPath.row]
        cell.configure(with: book)

        return cell
    }
    
    // Enable swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // For favorites, we don't delete the book, just remove it from favorites
            var book = favoriteBooks[indexPath.row]
            book.isFavorite = false
            book.save()
            
            favoriteBooks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Table View Delegate Methods
extension FavoriteBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedBook = favoriteBooks[indexPath.row]
        
        performSegue(withIdentifier: "ComposeSegue", sender: selectedBook)
    }
}
