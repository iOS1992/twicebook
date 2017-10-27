//
//  RootController.swift
//  App
//
//  Created by laijihua on 27/10/2017.
//

import Foundation
import Vapor


final class RootController: ControllerRoutable {

    init(builder: RouteBuilder) {
        let router = builder
        /// 获取全部书籍
        router.get("books", handler: { (req) -> ResponseRepresentable in
            return try Book.page(request: req)
        })

        /// 更新书籍状态
        router.put("book", handler: { (request) -> ResponseRepresentable in
            guard let bookId = request.data[Book.Key.id]?.int else {
                return try ApiRes.error(code: 1, msg: "misss id")
            }
            guard let book = try Book.find(bookId) else {
                return try ApiRes.error(code: 2, msg: "not found book")
            }
            guard let state = request.data[Book.Key.state]?.int else {
                return try ApiRes.error(code: 3, msg: "miss state")
            }
            book.state = state
            try book.save()
            return try ApiRes.success(data: ["success": true])
        })
    }

}
