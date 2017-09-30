//
//  AuthMiddleware.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Vapor

/// 
/// 
//// code = 404 token not fond  | code = 405 token is error

final class AuthMiddleware: Middleware {

    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        let tokenKey = UserToken.Key.token
        guard let token = request.data[tokenKey]?.string else {
            let json = try ApiRes.error(code: .tokenNull)
            return Response(status: .ok, body: json)
        }

        guard try UserToken.makeQuery().filter(tokenKey, token).count() > 0 else {
            let json = try ApiRes.error(code: .tokenError)
            return Response(status: .ok, body: json)
        }
        
        return try next.respond(to: request)
    }
}
