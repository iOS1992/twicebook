//
//  AccountController.swift
//  seesometop
//
//  Created by laijihua on 29/08/2017.
//
//

import Foundation
import Crypto
import Vapor
import SMTP

// Account
final class AccountController: ControllerRoutable {

    weak var droplet: Droplet?

    convenience init(builder: RouteBuilder, droplet: Droplet) {
        self.init(builder: builder)
        self.droplet = droplet
    }

    init(builder: RouteBuilder) {
        builder.post("registe", handler: register) // create
        builder.post("login", handler: login) // update
        builder.get("activate", String.parameter, handler: activate)
    }

    func activate(req: Request) throws -> ResponseRepresentable {
        let code = try req.parameters.next(String.self)
        guard let actiCode = try UserActicode.makeQuery().filter(UserActicode.Key.actiCode, code).first() else {
            return try ApiRes.error(code: 1, msg: "NO HAVE THIS CODE")
        }
        actiCode.state = true
        try actiCode.save()
        return try ApiRes.success(data:"success to valide account")
    }

    func register(req: Request) throws -> ResponseRepresentable {
        guard let name = req.data[User.Key.name]?.string else {
            return try ApiRes.error(code: 1, msg: "miss name")
        }

        guard let email = req.data[User.Key.email]?.string else {
            return try ApiRes.error(code: 2, msg: "miss email")
        }

        guard let password = req.data[User.Key.password]?.string else {
            return try ApiRes.error(code: 3, msg: "miss password")
        }

        if try User.makeQuery().filter(User.Key.email, email).count() > 0 {
            return try ApiRes.error(code: 4, msg: "email has registed")
        }
        let code = try generyActiCode(email: email, password: password) // 验证码
        let pwd = try generyPwd(password: password) // 密码加密

        let user = User(email: email, password: pwd, name: name)
        try user.save()
        guard let userId = user.id else {
            return try ApiRes.error(code: 5, msg: "userId create error")
        }
        let actiCode = UserActicode(userId: userId, actiCode: code)
        try actiCode.save()
        guard let _ = actiCode.id else {
            return try ApiRes.error(code: 6, msg: "acticode generate error")
        }
        // 发送邮件
        try sendEmail(email, code: actiCode, hostUrl: "\(req.uri.scheme)://\(req.uri.hostname)")

        return try ApiRes.success(data:["user": user])
    }

    func login(req: Request) throws -> ResponseRepresentable {
        guard let email = req.data[User.Key.email]?.string else {
            return try ApiRes.error(code: 1, msg: "email miss")
        }
        guard let password = req.data[User.Key.password]?.string else {
            return try ApiRes.error(code: 2, msg: "password miss")
        }
        let enPwd = try generyPwd(password: password)
        guard let user = try User.makeQuery().and({ (andGroup) in
            try andGroup.filter(User.Key.email, email)
            try andGroup.filter(User.Key.password, enPwd)
        }).first() else {
            return try ApiRes.error(code: 3, msg: "user not found")
        }
        
        let token = try generyActiCode(email: email, password: password)
        if let tokenModel = try UserToken.makeQuery().filter(UserToken.Key.userId, user.id).first() {
            tokenModel.token = token
            try tokenModel.save()
        } else {
            let userToken = UserToken(token: token, userId: user.id!)
            try userToken.save()
        }
        return try ApiRes.success(data:["user": user, "token": token])
    }

    private func generyPwd(password: String) throws -> String {
        return try Hash.make(.md5, password.makeBytes()).hexString
    }

    private func generyActiCode(email: String, password: String) throws -> String {
        let md5Key = email + password + arc4random().description
        let generStr = try Hash.make(.md5, md5Key.makeBytes()).hexString.lowercased()
        return generStr
    }

    // sendgrid oheroj@gmail.com qq小k
    private func sendEmail(_ toMail: String , code: UserActicode, hostUrl: String) throws {
        let fromEmail = "twicebook@gmail.com"
        let body = "认证链接：" + hostUrl + "/account/activate" + "/\(code.actiCode)"
        let email = Email(from: fromEmail, to: toMail, subject: "验证确认", body: body)
        background { [weak self] in
            try? self?.droplet?.mail.send(email)
        }
    }
}

