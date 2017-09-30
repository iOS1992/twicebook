//
//  ControllerRoutable.swift
//  seesometop
//
//  Created by laijihua on 28/08/2017.
//
//

import Foundation
import Vapor

protocol ControllerRoutable {
    init(builder: RouteBuilder)
}
