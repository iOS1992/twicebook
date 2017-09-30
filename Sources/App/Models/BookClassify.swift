//
//  BookClassify.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Vapor
import FluentProvider

/// 图书分类
final class BookClassify: Model {
    let storage: Storage = Storage()
    var name: String
    var parentId: Int // 父类的 id ，默认为0, 第一级分类为parentId 为 0
    var path: String // 路径

    struct Key {
        static let id = "id"
        static let name = "name"
        static let parentId = "parent_id"
        static let path = "path"
    }

    init(row: Row) throws {
        self.name = try row.get(Key.name)
        self.parentId = try row.get(Key.parentId)
        self.path = try row.get(Key.path)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.name, name)
        try row.set(Key.parentId, parentId)
        try row.set(Key.path, path)
        return row
    }
}

extension BookClassify: JSONRepresentable {

    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Key.id, id)
        try json.set(Key.name, name)
        try json.set(Key.parentId, parentId)
        try json.set(Key.path, path)
        return json
    }
}

extension BookClassify: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Key.name)
            builder.int(Key.parentId)
            builder.string(Key.path)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
