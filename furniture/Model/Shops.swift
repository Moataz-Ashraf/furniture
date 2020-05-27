//
//  NameShops.swift
//  MyInstagram
//
//  Created by Moataz on 2/10/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation
struct Shops : Codable  {
    
    var Shop : Shop
    var Products : Products
    
    init(Shop :Shop ,Products :Products) {
        
         self.Shop = Shop
         self.Products = Products
        
    }
    
}
