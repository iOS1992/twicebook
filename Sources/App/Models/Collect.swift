//
//  Collect.swift
//  seesometop
//
//  Created by laijihua on 30/08/2017.
//
//

import Foundation
import Vapor
import FluentProvider

/// book 收藏表
final class Collect: Model {
    let storage: Storage = Storage()
    var userId: Int
    var bookId: Int

    struct Key {
        static let userId = "user_id"
        static let bookId = "book_id"
    }

    init(userId:Int, bookId: Int) {
        self.userId = userId
        self.bookId = bookId
    }

    init(row: Row) throws {
        self.userId = try row.get(Key.userId)
        self.bookId = try row.get(Key.bookId)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.userId, userId)
        try row.set(Key.bookId, bookId)
        return row
    }
}

extension Collect: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.int(Key.userId)
            builder.int(Key.bookId)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// If the Commententity does not conform to PivotProtocol, the add, remove, and isAttached methods will not be available.
extension Collect: PivotProtocol {
    typealias Left = User
    typealias Right = Book

    static var leftIdKey: String { return Key.userId }
    static var rightIdKey: String { return Key.bookId }
}

