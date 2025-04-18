//
//  Book.swift
//  BookList-Final
//
//  Created by Tyler Mui on 4/6/25.
//
import Foundation
import UIKit

struct Book: Codable, Equatable{
    var id: String = UUID().uuidString
    var title: String
    var status: Bool
    var summary: String?
    var isFavorite: Bool

    
    init(title: String, status: Bool, summary: String?, isFavorite: Bool) {
        self.title = title
        self.status = status
        self.summary = summary
        self.isFavorite = isFavorite
    }

}


// UserDefaults
extension Book {
    
    // key for all books
    static var booksKey: String {
        return "books"
    }
    
    // The key used for storing favorite books
    static var favoriteBooksKey: String {
        return "favoriteBooks"
    }
    
    
    static func save(_ books: [Book], forKey key: String = "books") {
        
        let defaults = UserDefaults.standard
        
        let encodedData = try? JSONEncoder().encode(books)
        
        defaults.set(encodedData, forKey: key)
        
    }
    
    
    static func getBooks(forKey key: String = "books") -> [Book] {
        
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: key) {
            let decodedBooks = try! JSONDecoder().decode([Book].self, from: data)
            return decodedBooks
        } else {
            return []
        }
    }
    
    
    func save() {
        var currentBooks = Book.getBooks()
        
        // 2. Check if the current task already exists in the tasks array
        if let existingIndex = currentBooks.firstIndex(where: { $0.id == self.id }) {
            // 2.1. If task exists, remove the existing task from the array
            currentBooks.remove(at: existingIndex)
            // 2.2. Insert the updated task in place of the removed task
            currentBooks.insert(self, at: existingIndex)
        } else {
            // 3. If no matching task exists, add the new task to the end of the array
            currentBooks.insert(self, at: 0)
        }
        
        // 4. Save the updated tasks array to UserDefaults
        Book.save(currentBooks)
    }
    
    // Toggle favorite status and save
    mutating func toggleFavorite() {
        isFavorite = !isFavorite
        save()
    }
    
}
