//
//  CategoryOption.swift
//  MyInstagram
//
//  Created by Moataz on 4/19/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import UIKit

enum CategoryOption: Int, CustomStringConvertible,Codable,CaseIterable{
    
    case Sofas
    case Chairs
    case Loveseats
    case Beds
    case Cupboards
    
    var description: String {
        switch self{
        case .Sofas:
            return "Sofas"
        case . Chairs:
            return " Chairs"
        case .Loveseats:
            return "Loveseats"
        case .Beds:
            return "Beds"
        case .Cupboards:
            return "Cupboards"
        }
    }
    
    var image: UIImage{
        switch self{
        case .Sofas:
            return #imageLiteral(resourceName: "031-sofa-1")
        case . Chairs:
            return #imageLiteral(resourceName: "017-lamp-1")
        case .Loveseats:
            return #imageLiteral(resourceName: "007-armchair-1")
        case .Beds:
            return #imageLiteral(resourceName: "011-double-bed")
        case .Cupboards:
            return #imageLiteral(resourceName: "006-wardrobe")
        }
    }
}
