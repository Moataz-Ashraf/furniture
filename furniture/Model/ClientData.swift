//
//  ClientData.swift
//  furniture
//
//  Created by Moataz on 7/21/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation

struct ClientData : Codable {
    
   var Phone: String = ""
   var ClientImage: String = ""
    var ClientName: String = ""
    var DescriptionAddress: String = ""
    var UserLocation: String = ""
   var KeyOfUser : String?
}
