//
//  BenchApp.swift
//  Bench
//
//  Created by Leonie Schäper on 11.11.22.
//

import SwiftUI

@main
struct BenchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(benches: Benches())
        }
    }
}
