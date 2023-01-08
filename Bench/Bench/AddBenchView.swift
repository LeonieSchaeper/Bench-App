//
//  SwiftUIView.swift
//  Bench
//
//  Created by Leonie Schäper on 16.12.22.
//

import SwiftUI

struct AddBenchView: View {
    @State var description : String = ""
    @StateObject var locationManager = LocationManager()
    @ObservedObject var benches = Benches()
    
    var body: some View {
        
        
        VStack {
            TextField("Description", text: $description) .textFieldStyle(.roundedBorder).padding()
            
            Button (action: {Task {
                await benches.addBench(bench: Bench(id: 100, lat: 11.11111, lng: 3.333333,  description: description))
                }}) {
                Text ("add")
            }
        }
        
        
    }
}

struct AddBenchView_Previews: PreviewProvider {
    static var previews: some View {
        AddBenchView()
    }
}
