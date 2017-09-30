//
//  FavoriteController.swift
//  seesometop
//
//  Created by laijihua on 09/09/2017.
//
//

import Foundation
import Vapor

final class FavoriteController: ControllerRoutable {

    init(builder: RouteBuilder) {
        builder.get("/",Int.parameter, handler: list)
        builder.post("/", handler: add)
        builder.delete("/", handler: delete)
        builder.get("search", handler: searchFavoriteState)
    }

    func searchFavoriteState(request: Request) throws -> ResponseRepresentable {
        guard let bookId = request.data[Collect.Key.bookId]?.int else {
            return try ApiRes.error(code: 1, msg: "bookid nil")
        }
        guard let userId = request.data[Collect.Key.userId]?.int else {
            return try ApiRes.error(code: 2, msg: "userId nil")
        }
        let collect = try Collect.makeQuery().and { (andGrop) in
            try andGrop.filter(Collect.Key.bookId, bookId)
            try andGrop.filter(Collect.Key.userId, userId)
        }.first()

        if let _ = collect {
            return try ApiRes.success(data:["isAttend": true])
        } else {
            return try ApiRes.success(data:["isAttend": false])
        }
    }

    func add(request: Request) throws -> ResponseRepresentable {
        guard let bookId = request.data[Collect.Key.bookId]?.int else {
            return try ApiRes.error(code: 1, msg: "bookId nil")
        }
        guard let userId = request.data[Collect.Key.userId]?.int else {
            return try ApiRes.error(code: 2, msg: "userId nil")
        }
        // 如果之前存在
        guard let book = try Book.find(bookId) else {
            return try ApiRes.error(code: 3, msg: "miss book ")
        }

        let collect = Collect(userId: userId, bookId: bookId)
        try collect.save()
        book.collectCount += 1
        try book.save()
        return try ApiRes.success(data:["success": true])
    }

    func delete(request: Request) throws -> ResponseRepresentable {
        guard let bookId = request.data[Collect.Key.bookId]?.int else {
            return try ApiRes.error(code: 1, msg: "bookId nil")
        }
        guard let userId = request.data[Collect.Key.userId]?.int else {
            return try ApiRes.error(code: 2, msg: "userId nil")
        }
        guard let book = try Book.find(bookId) else {
            return try ApiRes.error(code: 3, msg: "miss book")
        }

        let collect = try Collect.makeQuery().and { (andGroup) in
            try andGroup.filter(Collect.Key.bookId, bookId)
            try andGroup.filter(Collect.Key.userId, userId)
        }.first()

        guard let colle = collect else {
            return try ApiRes.error(code: 3, msg: "not found this ")
        }

        try colle.delete()
        book.collectCount -= 1
        try book.save()
        return try ApiRes.success(data:["success": true])
    }

    func list(request: Request) throws -> ResponseRepresentable {
        let userId = try request.parameters.next(Int.self)
        guard let user = try User.find(userId) else {
            return try ApiRes.error(code: 2, msg: "user not found")
        }
        let books = try user.collectBooks.all()
        return try ApiRes.success(data:["books": books.makeJSON()])
    }
}
