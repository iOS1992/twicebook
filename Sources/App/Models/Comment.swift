//
//  Comment.swift
//  App
//
//  Created by laijihua on 29/09/2017.
//

import Foundation
import Vapor
import FluentProvider

final class Comment: Model {
    let storage: Storage = Storage()
    let bookId: Identifier
    let userId: Identifier
    let content: String
    let createTime: String
    var reportCount: Int // 举报的次数
    var userName: String
    var userAvator: String

    struct Key {
        static let id = "id"
        static let bookId = "book_id"
        static let userId = "user_id"
        static let content = "content"
        static let createTime = "create_time"
        static let reportCount = "report_count"
        static let userAvator = "user_avator"
        static let userName = "user_name"
    }

    init(bookId: Identifier,
         userId: Identifier,
         content: String ,
         createTime: String,
         reportCount: Int = 0,
         userName: String,
         userAvator: String) {
        self.bookId = bookId
        self.userId = userId
        self.reportCount = reportCount
        self.content = content
        self.createTime = createTime
        self.userName = userName
        self.userAvator = userAvator
    }

    init(row: Row) throws {
        bookId = try row.get(Key.bookId)
        userId = try row.get(Key.userId)
        content = try row.get(Key.content)
        reportCount = try row.get(Key.reportCount)
        createTime = try row.get(Key.createTime)
        userName = try row.get(Key.userName)
        userAvator = try row.get(Key.userAvator)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.bookId, bookId)
        try row.set(Key.userId, userId)
        try row.set(Key.content, content)
        try row.set(Key.reportCount, reportCount)
        try row.set(Key.createTime, createTime)
        try row.set(Key.userName, userName)
        try row.set(Key.userAvator, userAvator)
        return row
    }
}

extension Comment: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Key.id, id)
        try json.set(Key.userId, userId)
        try json.set(Key.bookId, bookId)
        try json.set(Key.content, content)
        try json.set(Key.createTime, createTime)
        try json.set(Key.reportCount, reportCount)
        try json.set(Key.userName, userName)
        try json.set(Key.userAvator, userAvator)
        return json
    }
}

extension Comment: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.int(Key.bookId)
            builder.int(Key.userId)
            builder.string(Key.createTime)
            builder.string(Key.content)
            builder.string(Key.reportCount)
            builder.string(Key.userName)
            builder.string(Key.userAvator)
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
