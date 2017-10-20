//
//  Book.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Vapor
import FluentProvider

// 书籍
final class Book: Model {
    let storage: Storage = Storage()
    var covers:String  // 以逗号分隔,
    var name: String
    var isbn: String // 图书编号
    var author: String // 作者
    var price: Double
    var priceUnitId: Identifier // 货币Id

    var detail: String // 产品详情
    var createTime:String // 创建时间
    var classifyId: Identifier // 分类 Id
    var createId: Identifier // 创建者的 Id

    var commentCount: Int // 评论数
    var collectCount: Int // 收藏数
    var state: Int // 书籍的发布状态  1:审核中 2:上架 3:下架
    var reportCount: Int // 举报次数

    enum State: Int  {
        case check = 1
        case putaway = 2
        case soldout = 3
        case none = 0

        static func generate(value: Int) -> State {
            switch value {
            case 1:
                return .check
            case 2:
                return .putaway
            case 3:
                return .soldout
            default:
                return .none
            }
        }
    }

    var priceUnit: Parent<Book, PriceUnit> {
        return parent(id: priceUnitId)
    }

    var creater: Parent<Book, User> {
        return parent(id: createId)
    }

    var bookClassify: Parent<Book, BookClassify> {
        return parent(id: classifyId)
    }

    
    // TODO: 分类
    struct Key {
        static let id = "id"
        static let covers = "covers"
        static let name = "name"
        static let isbn = "isbn"
        static let author = "author"
        static let price = "price"
        static let detail = "detail"
        static let createTime = "create_time"
        static let priceUintId = "price_unit_id"
        static let  classifyId = "book_classify_id"
        static let createId = "user_id"
        static let classfy = "classfy"
        static let priceUnit = "priceUnit"
        static let commentCount = "comment_count"
        static let collectCount = "collect_count"
        static let state = "state"
        static let reportCount = "report_count" // 举报次数
    }

    init(covers: String, name: String , isbn: String, author: String, price: Double, detail: String , createTime: String , priceUnitId: Identifier, classifyId:Identifier, createId:Identifier ) {
        self.covers = covers
        self.name = name
        self.isbn = isbn
        self.author = author
        self.price = price
        self.detail = detail
        self.createTime = createTime
        self.priceUnitId = priceUnitId
        self.classifyId = classifyId
        self.createId = createId
        self.commentCount = 0
        self.collectCount = 0
        self.state = 1 // 先设置为上架
        self.reportCount = 0
    }

    init(row: Row) throws {
        self.covers = try row.get(Key.covers)
        self.name = try row.get(Key.name)
        self.isbn = try row.get(Key.isbn)
        self.author = try row.get(Key.author)
        self.price = try row.get(Key.price)
        self.detail = try row.get(Key.detail)
        self.createTime = try row.get(Key.createTime)
        self.priceUnitId = try row.get(Key.priceUintId)
        self.classifyId = try row.get(Key.classifyId)
        self.createId = try row.get(Key.createId)
        self.commentCount = try row.get(Key.commentCount)
        self.collectCount = try row.get(Key.collectCount)
        self.state = try row.get(Key.state)
        self.reportCount = try row.get(Key.reportCount)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Key.covers, covers)
        try row.set(Key.author, author)
        try row.set(Key.name, name)
        try row.set(Key.isbn, isbn)
        try row.set(Key.price, price)
        try row.set(Key.detail, detail)
        try row.set(Key.createTime, createTime)
        try row.set(Key.priceUintId, priceUnitId)
        try row.set(Key.classifyId, classifyId)
        try row.set(Key.createId, createId)
        try row.set(Key.commentCount, commentCount)
        try row.set(Key.collectCount, collectCount)
        try row.set(Key.state, state)
        try row.set(Key.reportCount, reportCount)
        return row
    }
}

extension Book: JSONRepresentable {
    func makeJSON() throws -> JSON {
        let creater = try self.creater.first()
        var json = JSON()
        try json.set(Key.id, id)
        try json.set(Key.covers, covers.components(separatedBy: ","))
        try json.set(Key.author, author)
        try json.set(Key.name, name)
        try json.set(Key.isbn, isbn)
        try json.set(Key.price, price)
        try json.set(Key.detail, detail)
        try json.set(Key.createTime, createTime)
        try json.set(Key.classfy, bookClassify.first())
        try json.set("creater", creater)
        try json.set(Key.commentCount, commentCount)
        try json.set(Key.collectCount, collectCount)
        try json.set(Key.state, state)
        try json.set(Key.reportCount, reportCount)
        return json
    }

}

extension Book: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Key.author)
            builder.string(Key.name)
            builder.string(Key.isbn)
            builder.double(Key.price)
            builder.string(Key.detail, length: 512)
            builder.string(Key.covers)
            builder.string(Key.createTime)
            builder.parent(PriceUnit.self)
            builder.parent(BookClassify.self)
            builder.parent(User.self)
            builder.int(Key.collectCount)
            builder.int(Key.commentCount)
            builder.int(Key.state)
            builder.int(Key.reportCount)
        })

    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }

}





