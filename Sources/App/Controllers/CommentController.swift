//
//  CommentController.swift
//  App
//
//  Created by laijihua on 29/09/2017.
//
import Foundation
import Vapor

final class CommentController: ControllerRoutable {
    init(builder: RouteBuilder) {
        builder.get("book",Int.parameter, handler: bookComments)
        builder.get("user", Int.parameter, handler: userComments)
        builder.post("book", Int.parameter, handler: addComment)
        builder.post("report", Int.parameter, handler: reportComment)
    }

    func addComment(request: Request) throws -> ResponseRepresentable {
        let bookId = try request.parameters.next(Int.self)
        guard let userId = request.data[Comment.Key.userId]?.int else {
            return try ApiRes.error(code: 1, msg: "miss user_id")
        }
        guard let user = try User.find(userId) else {
            return try ApiRes.error(code: 3,msg: "miss user")
        }
        guard let content = request.data[Comment.Key.content]?.string else {
            return try ApiRes.error(code: 2, msg: "miss content")
        }
        guard let book = try Book.find(bookId) else {
            return try ApiRes.error(code: 4, msg: "miss book ")
        }

        let createTime = Date().toString
        let comment = Comment(bookId: Identifier(bookId), userId: Identifier(userId), content: content, createTime: createTime, userName: user.name, userAvator: user.avator)
        try comment.save()
        book.commentCount += 1
        try book.save()
        return try ApiRes.success(data:["success": true])
    }

    func reportComment(request: Request) throws -> ResponseRepresentable {
        let commentId = try request.parameters.next(Int.self)
        guard let comment = try Comment.find(commentId) else {
            return try ApiRes.error(code: 1, msg: "not find comment")
        }
        comment.reportCount += 1
        if comment.reportCount > 10 {
            if let book = try Book.find(comment.bookId) {
                book.commentCount -= 1
                try book.save()
            }
            try comment.delete()
        }
        try comment.save()
        return try ApiRes.success(data:["success": true])
    }

    func bookComments(request: Request) throws -> ResponseRepresentable {
        let bookId = try request.parameters.next(Int.self)
        let query = try Comment.makeQuery().filter(Comment.Key.bookId, bookId)
        return try Comment.page(request: request, query: query)
    }

    func userComments(request: Request) throws -> ResponseRepresentable {
        let userId = try request.parameters.next(Int.self)
        let query = try Comment.makeQuery().filter(Comment.Key.userId, userId)
        return try Comment.page(request: request, query: query)
    }

}


