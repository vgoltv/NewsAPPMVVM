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
        
#if canImport(UIKit)
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.appPagerDotsActiveColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.appPagerDotsColor)
#endif
        
        return WindowGroup {
            HomeView()
#if os(macOS)
                .frame(minWidth: 800,
                       maxWidth: .infinity,
                       minHeight: 600,
                       maxHeight: .infinity,
                       alignment: .center)
#endif
        }
    }
}
