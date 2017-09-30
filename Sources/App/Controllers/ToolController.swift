//
//  ToolController.swift
//  seesometop
//
//  Created by laijihua on 05/09/2017.
//
//

import Foundation
import Vapor

final class ToolController: ControllerRoutable {

    init(builder: RouteBuilder) {
        builder.get("qiniu/token", handler: qiuniuToken)
    }

    func qiuniuToken(request: Request) throws -> ResponseRepresentable {
        let token = try QiniuToken.genereryToken()
        return try ApiRes.success(data:["token": token])
    }
}
