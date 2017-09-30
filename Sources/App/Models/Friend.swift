//
//  Friend.swift
//  App
//
//  Created by laijihua on 28/09/2017.
//

import Foundation
import Vapor
import FluentProvider

/// 关注表 
final class Friend: Model {
    let storage: Storage = Storage()
    let masterId: Identifier
    let friendId: Identifier

    struct Key {
        static let id = "id"
        static let masterId = "master_id"
        static let friendId = "friend_id"
    }

    init(masterId:Identifier, friendId: Identifier) {
        self.masterId = masterId
        self.friendId = friendId
    }

    init(row: Row) throws {
        masterId = try row.get(Key.masterId)
        friendId = try row.get(Key.friendId)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.masterId, masterId)
        try row.set(Key.friendId, friendId)
        return row
    }
}

extension Friend: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Key.id, id)
        try json.set(Key.masterId, masterId)
        try json.set(Key.friendId, friendId)
        return json
    }
}

extension Friend: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.int(Key.masterId)
            builder.int(Key.friendId)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
