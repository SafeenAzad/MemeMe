//
//  memed.swift
//  MemeMe
//
//  Created by Safeen Azad on 8/14/17.
//  Copyright © 2017 SafeenAzad. All rights reserved.
//

import Foundation
import UIKit

struct memed {
    var discription : String
    var imageName : String
    
    static var discriptionKey = "discriptionKey"
    static var imageNameKey = "imageNameKey"
    
    
    init(dictionary: [String : String]) {
        self.discription = dictionary[memed.discriptionKey]!
        self.imageName = dictionary[memed.imageNameKey]!
    }
}

extension memed {
    
    static var allMemed : [memed]{
        var memedArray = [memed]()
        
        for d in localmemedData() {
            memedArray.append(memed(dictionary: d))
        }
        
        return memedArray
    }
    
    
    static func localmemedData() -> [[String : String]]{
        return [
            [memed.discriptionKey : "Safeen", memed.imageNameKey : "Big"]
        ]
        
    }
}
