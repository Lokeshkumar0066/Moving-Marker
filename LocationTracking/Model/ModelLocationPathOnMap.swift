//
//  ModelLocationPathOnMap.swift
//  LocationTracking
//
//  Created by manish on 12/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit

class ModelLocationPathOnMap {
    var lat : Double?
     var lon : Double?
     var angle : Double?
    
     init() {}
     init(lat : Double?,lon : Double?,angle : Double?) {
         self.lat = lat
         self.lon = lon
         self.angle = angle
     }
}
