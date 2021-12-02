//
//  CategoryRow.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 02.12.2021.
//

import Foundation
import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Article]
    
    let thumbWidth:CGFloat
    let thumbHeight:CGFloat
    
    @State var navigationViewIsActive: Bool = false
    @State var selectedArticle : Article? = nil
    
    init(name:String, items:[Article], thumbWidth:CGFloat, thumbHeight:CGFloat){
        self.categoryName = name
        self.items = items
        self.thumbWidth = thumbWidth
        self.thumbHeight = thumbHeight
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            
#if os(tvOS)
            Text(categoryName)
                .font(.caption)
#else
            Text(categoryName)
                .font(.footnote)
            Divider().background(Color.separatorColor).frame(height: 1.0)
#endif
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack{
                    
                    VStack {
                        if let mark = selectedArticle {
                            NavigationLink(destination: ArticleDetailView(article: mark),
                                           isActive: $navigationViewIsActive){ EmptyView() }
                        }
                    }.hidden()
                    
                    ForEach(items) { item in
                        Button(action: {
                            self.selectedArticle = item
                            self.navigationViewIsActive = true
                        }, label: {
                            ArticleItemView(article:item, thumbWidth: self.thumbWidth, thumbHeight: self.thumbHeight)
                        })
#if os(tvOS)
                            .buttonStyle(CardButtonStyle())
#endif
                    }
                }
#if os(tvOS)
                .frame(height: 220)
#endif
                
            }
#if os(tvOS)
            .frame(height: 240)
#else
            .frame(height: 130)
#endif
        }
    }
    
}
