//
//  Benches.swift
//  Bench
//
//  Created by Leonie Schäper on 11.11.22.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit


struct Bench : Identifiable, Codable, Hashable {
    var id : Int
    var lat : Double
    var lng : Double
    //var image_url : String
    var description : String
}

class Benches : ObservableObject {
    @Published var publicBenchesInActiveRegion : [Bench] = []
    @Published var myBenches : [Bench] = []

    init () {
        Task {
            await load()
        }
    }
    
    func load () async {
        guard let url = URL (string: "http://127.0.0.1:3000/benches.json") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "GET"

        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let benchesData = try JSONDecoder().decode([Bench].self, from: data)

            
            await setBenches(benchesData: benchesData)

        }
        catch let error {
            print (error.localizedDescription)
        }
    }

    @MainActor
    func setBenches (benchesData: [Bench]) {
        publicBenchesInActiveRegion = benchesData
    }
    
    
    
    func setRegion (region : CLRegion) {
        
    }
    
    func addBench(bench : Bench) async {
        
       // publicBenchesInActiveRegion.append(bench)
        let encoded = try! JSONEncoder().encode(bench)
//        let url = URL(string: "http://127.0.0.1:3000/benches.json")!
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 3000
        components.path = "/benches"
        components.queryItems = [
            URLQueryItem(name: "bench", value: String(data: encoded, encoding: .utf8)!)
        ]
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            //let benchesData = try JSONDecoder().decode([Bench].self, from: data)
            await load()

            //await setBenches(benchesData: benchesData)

        }
        catch let error {
            print (error.localizedDescription)
        }
        
       

    }

    func removeBench (bench : Bench) {
        
    }
    
    
    /*func createFakeData () {
        let leeuwarden = CLLocationCoordinate2D(
                     latitude: 53.2012334,
                     longitude: 5.7999133
                )
        
        publicBenchesInActiveRegion.append(

            Bench(location: leeuwarden, photo: Image("benchImage"))
        )
        

    }*/
}

