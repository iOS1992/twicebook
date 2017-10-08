//
//  Feedback.swift
//  App
//
//  Created by laijihua on 08/10/2017.
//

import Foundation
import Vapor
import FluentProvider

final class Feedback: Model {
    var userId: Int
    var content: String
    let storage: Storage = Storage()

    struct Key {
        static let content = "content"
        static let userId = "user_id"
    }

    init(content: String, userId: Int) {
        self.content = content
        self.userId = userId
    }

    init(row: Row) throws {
        content = try row.get(Key.content)
        userId = try row.get(Key.userId)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.content, content)
        try row.set(Key.userId, userId)
        return row
    }
}

extension Feedback: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Key.content, length: 500)
            builder.int(Key.userId)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
