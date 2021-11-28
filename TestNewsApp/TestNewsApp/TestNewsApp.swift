//
//  TestNewsApp.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 31/05/2021.
//

import SwiftUI



@main
struct TestNewsApp: App {
    var body: some Scene {
        WindowGroup {
#if os(macOS)
            HomeView().frame(minWidth: 800, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity, alignment: .center)
#else
            HomeView()
#endif
        }
    }
}
