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
//    var status: ReadingStatus
    var summary: String?
    
    init(title: String, /*status: ReadingStatus, */summary: String?) {
        self.title = title
//        self.status = status
        self.summary = summary
    }
   
}
enum ReadingStatus: String, Codable {
    case reading = "Reading"
    case finished = "Finished"
    case wantToRead = "Want to Read"
}


// UserDefaults
extension Book {
    
    static var favoriteBooksKey: String {
        return "favoriteBooks"
    }
    
    
    static func save(_ books: [Book], forKey key: String) {
        
        let defaults = UserDefaults.standard
        
        let encodedData = try? JSONEncoder().encode(books)
        
        defaults.set(encodedData, forKey: "book")
        
    }
    
    
    static func getBooks(forKey key: String) -> [Book] {
        
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: "book") {
            
            let decodedBooks = try! JSONDecoder().decode([Book].self, from: data)
            
            return decodedBooks
        } else {
            return []
        }
    }
    
    
    func save() {
        var currentBooks = Book.getBooks(forKey: "books")
        
        // 2. Check if the current task already exists in the tasks array
        if let existingIndex = currentBooks.firstIndex(where: { $0.id == self.id }) {
            // 2.1. If task exists, remove the existing task from the array
            currentBooks.remove(at: existingIndex)
            // 2.2. Insert the updated task in place of the removed task
            currentBooks.insert(self, at: existingIndex)
        } else {
            // 3. If no matching task exists, add the new task to the end of the array
            currentBooks.append(self)
        }
        
        // 4. Save the updated tasks array to UserDefaults
        Book.save(currentBooks, forKey:"books")
    }
    
//    func addToFavorites() {
//        var favoriteBooks = Book.getBooks(forKey: Book.favoriteBooksKey)
//        favoriteBooks.append(self)
//        Book.save(favoriteBooks, forKey: Book.favoriteBooksKey)
//    }
//
//
//    func removeFromFavorites() {
//        var favoriteBooks = Book.getBooks(forKey: Book.favoriteBooksKey)
//
//        if let index = favoriteBooks.firstIndex(of: self) {
//            favoriteBooks.remove(at: index)
//        }
//
//        Book.save(favoriteBooks, forKey: Book.favoriteBooksKey)
//    }
}
