//
//  MKMapView+Extensions.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

import MapKit

extension MKMapView {
   func centerToLocation(
       _ location: CLLocation,
       regionRadius: CLLocationDistance = 1000
   ) {
       let coordinateRegion = MKCoordinateRegion(
           center: location.coordinate,
           latitudinalMeters: regionRadius,
           longitudinalMeters: regionRadius)
       setRegion(coordinateRegion, animated: true)
   }
}
