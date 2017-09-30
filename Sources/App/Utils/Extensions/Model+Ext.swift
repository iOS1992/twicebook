//
//  Model+Ext.swift
//  store
//
//  Created by laijihua on 25/08/2017.
//
//

import Foundation
import Vapor
import FluentProvider

private struct Idata {
    var pageSize: Int
    var pgeNo: Int
    var code: Int
    var msg: String
    var count: Int
}

extension Model where Self:JSONRepresentable {

    static func page(request: Request) throws ->  ResponseRepresentable {

        let idata = try _ivalide(request: request)
        if idata.code > 0 {
            return try ApiRes.error(code: idata.code, msg: idata.msg)
        }
        let pageSize = idata.pageSize
        let pageNo = idata.pgeNo
        let count = idata.count
        let list = try self.makeQuery().limit(pageSize, offset: pageNo).all().makeJSON()
        return try ApiRes.success(data: ["list": list], count: count, pageSize: pageSize, pageNo: pageNo)
    }

    static func page(request: Request, query: Query<Self>) throws -> ResponseRepresentable {
        let idata = try _ivalide(request: request)
        if idata.code > 0 {
            return try ApiRes.error(code: idata.code, msg: idata.msg)
        }
        let pageSize = idata.pageSize
        let pageNo = idata.pgeNo
        let count = idata.count
        let list = try query.limit(pageSize, offset: pageNo).all().makeJSON()
        return try ApiRes.success(data: ["list": list], count: count, pageSize: pageSize, pageNo: pageNo)
    }

    static func page(request: Request, filterField field: String, filterValue value:NodeRepresentable ) throws -> ResponseRepresentable {
        let idata = try _ivalide(request: request)
        if idata.code > 0 {
            return try ApiRes.error(code: idata.code, msg: idata.msg)
        }
        let pageSize = idata.pageSize
        let pageNo = idata.pgeNo
        let count = idata.count

        let list = try self.makeQuery().filter(field, value).limit(pageSize, offset: pageNo).all().makeJSON()
        return try ApiRes.success(data: ["list": list], count: count, pageSize: pageSize, pageNo: pageNo)
    }

    private static func _ivalide(request: Request) throws ->  Idata {
        guard let pageNo = request.data["pageNo"]?.int else {
            return Idata(pageSize: 0, pgeNo: 0, code: 1, msg: "pageNo miss", count: 0)
        }
        guard let pageSize = request.data["pageSize"]?.int else {
            return Idata(pageSize: 0, pgeNo: 0, code: 2, msg: "pageSize miss",count:0)
        }
        let count = try self.count()
        let maxPage = count / pageSize
        if pageNo > maxPage {
            return Idata(pageSize: 0, pgeNo: 0, code: 0, msg: "out page count",count: 0)
        }
        return Idata(pageSize: pageSize, pgeNo: pageNo * pageSize , code: 0, msg: "success",count: count)
    }

}
