//
//  BenchMapView.swift
//  Bench
//
//  Created by Leonie Schäper on 11/11/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @ObservedObject var benches = Benches()
    
    @State var region = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
            latitude: 53.2012334,
            longitude: 5.7999133
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.002,
          longitudeDelta: 0.002
       )
    )
    
    
    
    @State private var isShowingBenchView = false
    
    var body: some View {
        
       
            VStack{
                
                
                
//                List (benches.publicBenchesInActiveRegion){bench in
//                    Text(bench.description)
//                    Text("longitude: \(bench.lng)")
//                    Text("latitude: \(bench.lat)")
//                }
                
                NavigationStack {
                    Map(coordinateRegion: $region, annotationItems: benches.publicBenchesInActiveRegion) { bench in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: bench.lat, longitude: bench.lng)){
                            NavigationLink(value: bench) {
                                    Image("FreeMarkerLocation")          .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                }
                        }
                    }
                    .navigationDestination(for: Bench.self) { bench in BenchView(bench: bench)
                        
                        
                    }.ignoresSafeArea()
                    
                    LocationButton {
                        locationManager.requestLocation()
                    }.toolbar(content: {
                            NavigationLink("add bench", destination: AddBenchView())
                        } )
                    
                        
                    
                }
           
        }
       
    }
    
}

struct BenchMapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(benches: Benches())
    }
}
