//
//  InfoView.swift
//  Bench
//
//  Created by Leonie Schäper on 18.11.22.
//

import SwiftUI
import MapKit
import CoreLocation


struct BenchView: View {
    var bench : Bench
    
   
   
    
    var body: some View {
        VStack {
            
                Text(bench.description)
            //AsyncImage(url: URL(string: bench.image_url))
                            
        }
    }
}


