//
//  PriceUnit.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Vapor
import FluentProvider

// 单位
final class PriceUnit: Model {
    let storage: Storage = Storage()
    let info: String

    struct Key {
        static let id = "id"
        static let info = "info"
    }

    init(row: Row) throws {
        self.info = try row.get(Key.info)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.info, info)
        return row
    }
}

extension PriceUnit: JSONRepresentable {

    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Key.id, id)
        try json.set(Key.info, info)
        return json
    }
}

extension PriceUnit {
    var books: Children<PriceUnit, Book> {
        return children()
    }
}

extension PriceUnit: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Key.info)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}


