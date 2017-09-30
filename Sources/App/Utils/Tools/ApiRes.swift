//
//  ApiRes.swift
//  store
//
//  Created by laijihua on 27/05/2017.
//
//

import Foundation
import Vapor

enum Code: Int {
    case tokenNull = 404  // token 为空
    case tokenError = 403 // token 错误

    var string: String {
        var msg = ""
        switch self {
        case .tokenNull:
            msg = "token 为空"
        case .tokenError:
            msg = "token 错误"
        }
        return msg
    }
}

class ApiRes {

    private static func json(code: Int, msg: String, data: Any?) throws -> JSON {
        var json = JSON()
        try json.set("code", code)
        try json.set("result", data)
        try json.set("message", msg)
        return json
    }

    static func success(data: Any?) throws -> JSON {
        return try json(code: 0, msg: "请求成功", data: data)
    }

    static func success(data: [String: Any],count: Int, pageSize: Int , pageNo: Int) throws -> JSON {
        var new = data
        new["count"] = count
        new["pageSize"] = pageSize
        new["pageNo"] = pageNo
        return try json(code: 0, msg: "请求成功", data: new)
    }

    static func error(code: Int, msg:String, data: Any? = nil ) throws -> JSON {
        return try json(code: code, msg: msg, data: nil)
    }

    static func error(code: Code) throws -> JSON {
        return try error(code: code, msg: code.string)
    }

    static func error(code: Code, msg: String, data: Any? = nil) throws -> JSON {
        return try error(code: code.rawValue, msg: msg, data: data)
    }
}
