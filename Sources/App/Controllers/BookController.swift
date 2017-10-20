//
//  BookController.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Vapor

final class BookController: ControllerRoutable {

    init(builder: RouteBuilder) {
        builder.post("create", handler: create)
        builder.put("update", handler: update)
        builder.get("/",handler: show)
        builder.post("report", handler: report)
    }

    func report(request: Request) throws -> ResponseRepresentable {
        guard let bookId = request.data[Book.Key.id]?.int else {
            return try ApiRes.error(code:1, msg:"miss id")
        }
        guard let _ = request.data["userId"]?.int else {
            return try ApiRes.error(code:2, msg:"miss userId")
        }

        guard let book = try Book.find(bookId) else {
            return try ApiRes.error(code: 3, msg: "not found this book")
        }
        book.reportCount += 1
        try book.save()
        return try ApiRes.success(data:["success": true])
    }

    func show(request: Request)throws -> ResponseRepresentable {
        let query = try Book.makeQuery().filter(Book.Key.state, .notEquals, 1)
        return try Book.page(request: request, query: query)
    }

    func update(request: Request)throws -> ResponseRepresentable {
        guard let state = request.data[Book.Key.state]?.int else {
            return try ApiRes.error(code: 1, msg: "miss state")
        }
        /// 暂时不对权限限定
        guard let _ = request.data["user_id"]?.int else {
            return try ApiRes.error(code: 2, msg: "miss userId")
        }

        guard let bookId = request.data[Book.Key.id]?.int else {
            return try ApiRes.error(code: 3, msg: "miss book id")
        }

        guard let book = try Book.find(bookId) else {
            return try ApiRes.error(code: 4, msg: "not fond book")
        }

        book.state = state
        try book.save()
        return try ApiRes.success(data:["book": book])
    }

    func create(request: Request)throws -> ResponseRepresentable {
        guard let userId = request.data["userId"]?.int else {
            return try ApiRes.error(code: 7, msg: "userId nil")
        }
        guard let covers = request.data[Book.Key.covers]?.string else {
            return try ApiRes.error(code: 1, msg: "covers error")
        }
        guard let name = request.data[Book.Key.name]?.string else {
            return try ApiRes.error(code: 2, msg: "name error")
        }
        guard let isbn = request.data[Book.Key.isbn]?.string else {
            return try ApiRes.error(code: 3, msg: "isbn error")
        }
        guard let author = request.data[Book.Key.author]?.string else {
            return try ApiRes.error(code: 4, msg: "author error")
        }
        guard let price = request.data["price"]?.double else {
            return try ApiRes.error(code: 5, msg: "price error")
        }
        guard let categoryId = request.data[Book.Key.classifyId]?.int else {
            return try ApiRes.error(code: 6, msg: "categoryI 的 err")
        }
        guard let detail = request.data[Book.Key.detail]?.string else {
            return try ApiRes.error(code: 7, msg: "info error")
        }

        let time = Date().toString
        let priceUnitId = Identifier(1) // 人民币
        let book = Book(covers: covers,
                        name: name,
                        isbn: isbn,
                        author: author,
                        price: price,
                        detail: detail,
                        createTime: time,
                        priceUnitId: priceUnitId,
                        classifyId: Identifier(categoryId),
                        createId: Identifier(userId)
                        )
        try book.save()

        return try ApiRes.success(data:["res": "ok"])

    }

}
