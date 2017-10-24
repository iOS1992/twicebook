//
//  User.swift
//  seesometop
//
//  Created by laijihua on 28/08/2017.
//
//

import Foundation
import Vapor
import FluentProvider

final class User: Model{
    let storage: Storage = Storage()
    var email: String
    var name: String
    var avator: String
    var info: String
    var password: String
    var reportCount: Int

    struct Key {
        static let email = "email"
        static let name = "name"
        static let avator = "avator"
        static let info = "info"
        static let password = "password"
        static let id = "id"
        static let reportCount = "report_count"

        static let active = "active"
    }

    init(email: String,
         password: String,
         name:String,
         avator: String = "",
         info:String = "" ) {
        self.email = email
        self.password = password
        self.name = name
        self.avator = avator
        self.info = info
        self.reportCount = 0
    }

    init(row: Row) throws {
        email = try row.get(Key.email)
        name = try row.get(Key.name)
        avator = try row.get(Key.avator)
        info = try row.get(Key.info)
        password = try row.get(Key.password)
        reportCount = try row.get(Key.reportCount)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.email, email)
        try row.set(Key.name, name)
        try row.set(Key.avator, avator)
        try row.set(Key.info, info)
        try row.set(Key.password, password)
        try row.set(Key.reportCount, reportCount)
        return row
    }
}

extension User: JSONRepresentable {
    func makeJSON() throws -> JSON {
        let isActive = try activeCode()?.state ?? false
        var json = JSON()
        try json.set(Key.id, id)
        try json.set(Key.email, email)
        try json.set(Key.avator, avator)
        try json.set(Key.info, info)
        try json.set(Key.name, name)
        try json.set(Key.active, isActive)
        try json.set(Key.reportCount, reportCount)
        return json
    }
}

extension User {
    // 激活码
    func activeCode() throws -> UserActicode? {
        return try children(type: UserActicode.self, foreignIdKey: UserActicode.Key.userId).first()
    }

    func userToken() throws -> UserToken? {
        return try children(type: UserToken.self, foreignIdKey: UserToken.Key.userId).first()
    }

    /// 收藏的书籍
    var collectBooks: Siblings<User, Book, Collect> {
        return siblings()
    }

    /// 创建的书籍
    func createBooks() throws -> [Book] {
        return try children(type: Book.self, foreignIdKey: Book.Key.createId).all()
    }
}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Key.email)
            builder.string(Key.name)
            builder.string(Key.avator)
            builder.string(Key.info, length: 1024)
            builder.string(Key.password)
            builder.int(Key.reportCount)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }

}


