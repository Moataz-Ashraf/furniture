//
//  Product.swift
//  MyInstagram
//
//  Created by Moataz on 4/23/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation

struct Product :Codable{
    
   var Phone: String = ""
   var ProductImage: String = ""
    var ProductName: String = ""
    var ProductPrice: Double = 0.0
    var ProductType: CategoryOption
}
