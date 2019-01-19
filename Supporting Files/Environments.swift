//
//  Environments.swift
//  mychannelApp
//
//  Created by Thongpak on 14/1/2562 BE.
//  Copyright © 2562 thongpak. All rights reserved.
//

import Foundation

protocol Environment: class {
    var apiEndPoint: String { get set }
}

class Develop: Environment {
    var apiEndPoint: String = "http://www.thai-cartoon.com/wp"
}

class Production: Environment {
    var apiEndPoint: String = "http://www.thai-cartoon.com/wp"
}
