//
//  ArticlesPager.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 04.09.2021.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif





struct ArticlesPager: View {
#if os(iOS)
    private let indexBackgroundDisplayMode = PageIndexViewStyle.BackgroundDisplayMode.automatic
    @State private var orientation = UIDeviceOrientation.unknown
#endif
    private var articles:[Article]
    
    let onCardSelected: ((Article, Bool) -> Void)?

    
    init(articles:[Article], onCardSelected: ((Article, Bool) -> Void)? = nil ) {
        self.articles = articles
        self.onCardSelected = onCardSelected
    }
    
    
    var body: some View {
        let holder = TabView {
            
            ForEach(articles) { article in
                FeatureCard(article: article) { item, isSet in
                    self.onCardSelected?(item, isSet)
                }
                .ignoresSafeArea(edges: .top)
                .frame(maxWidth:.infinity)
            }
            
        }
#if canImport(UIKit)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
#endif
#if os(iOS)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: indexBackgroundDisplayMode))
            .onRotate { newOrientation in
                orientation = newOrientation
            }
#endif
        
        return holder
    }
}
