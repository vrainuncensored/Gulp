//
//  mapsStructure.swift
//  gulp
//
//  Created by Vrain Ahuja on 6/13/20.
//  Copyright © 2020 Gulp. All rights reserved.
//

import Foundation
import MapKit

//This struct is here for all the information that will be shown on the map. All things can be added here

struct MapData {
var truckName : String
var truckCoordinates: CLLocationCoordinate2D

init(truckName: String = "",
     truckCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
     ) {
    
    self.truckName = truckName
    self.truckCoordinates = truckCoordinates
    
}
}
