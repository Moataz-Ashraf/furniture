//
//  Shop.swift
//  MyInstagram
//
//  Created by Moataz on 4/24/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation
struct Shop : Codable  {
    var NameShops : String = ""
    var ImageShop : String = ""
    init(NameShops: String, ImageShops: String) {
        self.NameShops = NameShops
        self.ImageShop = ImageShops
        
}
}
