//
//  UserActicode.swift
//  seesometop
//
//  Created by laijihua on 28/08/2017.
//
//


import Foundation
import Vapor
import FluentProvider

final class UserActicode: Model {
    let storage: Storage = Storage()
    var userId: Identifier
    var state: Bool
    var actiCode: String

    var user: Parent<UserActicode, User> {
        return parent(id: userId)
    }

    struct Key {
        static let id = "id"
        static let userId = "user_id"
        static let state = "state"
        static let actiCode = "acti_code"
    }

    init(userId: Identifier, actiCode:String , state: Bool = false) {
        self.userId = userId
        self.actiCode = actiCode
        self.state = state
    }

    init(row: Row) throws {
        userId = try row.get(Key.userId)
        state = try row.get(Key.state)
        actiCode = try row.get(Key.actiCode)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.userId, userId)
        try row.set(Key.state, state)
        try row.set(Key.actiCode, actiCode)
        return row
    }
}


extension UserActicode: Preparation {

    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.parent(User.self)
            builder.bool(Key.state, default: false)
            builder.string(Key.actiCode)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }

}
