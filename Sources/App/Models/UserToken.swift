//
//  UserToken.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Vapor
import FluentProvider

final class UserToken: Model {
    var token: String
    var userId: Identifier
    let storage: Storage = Storage()

    struct Key {
        static let token = "token"
        static let userId = "user_id"
    }

    var user: Parent<UserToken, User> {
        return parent(id: userId)
    }

    init(token: String, userId: Identifier) {
        self.token = token
        self.userId = userId
    }

    init(row: Row) throws {
        token = try row.get(Key.token)
        userId = try row.get(Key.userId)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.token, token)
        try row.set(Key.userId, userId)
        return row
    }
}

extension UserToken: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Key.token)
            builder.parent(User.self)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
