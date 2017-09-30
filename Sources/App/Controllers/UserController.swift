//
//  UserController.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Vapor

final class UserController: ControllerRoutable {
    init(builder: RouteBuilder) {
        /// 用户修改 /user/update
        builder.put("update",Int.parameter, handler: update)
        /// 用户登出
        builder.get("logout", Int.parameter, handler: logout)
        builder.get("/", Int.parameter, handler: show)

        /// 朋友关系
        builder.post("friend", handler: friendAdd)
        builder.delete("friend", handler: friendRemove)
        builder.get("friend", Int.parameter, handler:haveFriend)
        builder.get("friends", handler: userFriends)
    }

    func userFriends(request: Request) throws -> ResponseRepresentable {
        guard let masterId = request.data[Friend.Key.masterId]?.int else {
            return try ApiRes.error(code: 1, msg: "miss masterId")
        }
        let friends = try Friend.makeQuery().filter(Friend.Key.masterId, masterId).all()

        var users = [User]()
        for friend in friends {
            if let user = try User.find(friend.friendId) {
                users.append(user)
            }
        }
        return try ApiRes.success(data:["friends": users])
    }

    func haveFriend(request: Request) throws -> ResponseRepresentable {
        let friendId = try request.parameters.next(Int.self)
        guard let userId = request.data[Friend.Key.masterId]?.int else {
            return try ApiRes.error(code: 1, msg: "misss master_id")
        }
        let friends = try Friend.makeQuery().and { (andGroup) in
            try andGroup.filter(Friend.Key.masterId, userId)
            try andGroup.filter(Friend.Key.friendId, friendId)
        }
        if let _ = try friends.first(){
            return try ApiRes.success(data:["isFriend": true])
        } else {
            return try ApiRes.success(data:["isFriend": false])
        }
    }

    func friendRemove(request: Request) throws -> ResponseRepresentable {
        guard let userId = request.data[Friend.Key.masterId]?.int else {
            return try ApiRes.error(code: 1, msg: "misss master_id")
        }
        guard let friendId = request.data[Friend.Key.friendId]?.int else {
            return try ApiRes.error(code: 2, msg: "miss friend_id")
        }

        let friends = try Friend.makeQuery().and { (andGroup) in
            try andGroup.filter(Friend.Key.masterId, userId)
            try andGroup.filter(Friend.Key.friendId, friendId)
        }
        guard let friend = try friends.first() else {
            return try ApiRes.error(code: 3, msg: "not found friend ship")
        }
        try friend.delete()
        return try ApiRes.success(data:["ret": true])
    }

    func friendAdd(request: Request) throws -> ResponseRepresentable {
        guard let userId = request.data[Friend.Key.masterId]?.int else {
            return try ApiRes.error(code: 1, msg: "misss master_id")
        }
        guard let friendId = request.data[Friend.Key.friendId]?.int else {
            return try ApiRes.error(code: 2, msg: "miss friend_id")
        }
        let friends = try Friend.makeQuery().and { (andGroup) in
            try andGroup.filter(Friend.Key.masterId, userId)
            try andGroup.filter(Friend.Key.friendId, friendId)
        }
        if let _ = try friends.first() {
            // 已收藏
        } else {
            let frindship = Friend(masterId: Identifier(userId), friendId: Identifier(friendId))
            try frindship.save()
        }
        return try ApiRes.success(data:["ret": true])
    }

    func show(request: Request) throws -> ResponseRepresentable {
        let userId = try request.parameters.next(Int.self)
        guard let user = try User.find(userId) else {
            return try ApiRes.error(code: 1, msg:"user not found")
        }
        return try ApiRes.success(data:["user": user])
    }

    func logout(request: Request) throws -> ResponseRepresentable {
        let userId = try request.parameters.next(Int.self)
        if let token = try UserToken.makeQuery().filter(UserToken.Key.userId, userId).first() {
            try token.delete()
        }
        return try ApiRes.success(data:"success")
    }

    func update(request: Request) throws -> ResponseRepresentable {
        let userId = try request.parameters.next(Int.self)
        guard let user = try User.find(userId) else {
            return try ApiRes.error(code: 1, msg: "user not found")
        }
        // 修改昵称
        if let name = request.data[User.Key.name]?.string {
            user.name = name
        }
        // 修改密码
        if let pwd = request.data[User.Key.password]?.string {
            user.password = pwd
        }
        // 修改昵称
        if let avator = request.data[User.Key.avator]?.string {
            user.avator = avator
        }
        // 修改用户简洁
        if let info = request.data[User.Key.info]?.string {
            user.info = info
        }
        try user.save()
        return try ApiRes.success(data:["user": user])
    }

    
}



