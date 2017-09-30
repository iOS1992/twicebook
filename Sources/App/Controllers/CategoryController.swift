//
//  CategoryController.swift
//  seesometop
//
//  Created by laijihua on 08/09/2017.
//
//

import Foundation
import Vapor

final class CategoryController: ControllerRoutable {
    init(builder: RouteBuilder) {
        builder.get("/",Int.parameter, handler: category)
    }

    func category(request: Request) throws -> ResponseRepresentable {
        let paramentId = try request.parameters.next(Int.self)
        let categorys = try BookClassify.makeQuery().filter(BookClassify.Key.parentId, paramentId).all()
        return try ApiRes.success(data:["categorys": categorys])
    }
}
