//
//  LocationView.swift
//  Bench
//
//  Created by Leonie Schäper on 02/12/2022.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            Task {
                await setLocation(location: location)
            }
        }
        
    }
    
    @MainActor private func setLocation (location:  CLLocationCoordinate2D) {
        self.location = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print (error.localizedDescription)
    }
}


struct LocationView : View {
    @ObservedObject var locationManager : LocationManager
    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text ("Locatie is:")
                Text ("\(location.latitude)")
                Text ("\(location.longitude)")
            }
            else {
                Text ("Geen locatie beschikbaar")
            }
        }
    }
}
