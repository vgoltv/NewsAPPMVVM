//
//  ArticleDetailView.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 17.11.2021.
//

import Foundation
import SwiftUI
import CachedAsyncImage
import os.log


struct ArticleDetailView: View {
    
    let article: Article
    
    var body: some View {
        GeometryReader { metrics in
            HStack{
                HStack(alignment:.center){
                    if let imageURL = article.image, let url = URL(string: imageURL) {
                        
                        CachedAsyncImage(
                            url: url, urlCache: .imageCache
                        ) { phase in
                            
                            switch phase {
                                
                            case .empty:
                                ZStack{
                                    Color.clear
                                        .ignoresSafeArea()
                                    ProgressView()
                                        .scaleEffect(0.8, anchor: .center)
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .frame(width: PlaceholderImageView.size.width, height: PlaceholderImageView.size.height)
                                }
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth:metrics.size.width * 0.5)
                                    .clipped()
                            case .failure:
                                ZStack{
                                    Color.clear
                                        .ignoresSafeArea()
                                    PlaceholderImageView()
                                }
                            @unknown default:
                                Color.clear
                                    .ignoresSafeArea()
                            }
                        }
                        
                    }else{
                        ZStack{
                            Color.clear
                                .ignoresSafeArea()
                            PlaceholderImageView()
                        }
                    }
                }
                .ignoresSafeArea()
                
                VStack{
                    Text(article.title ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .focusable()
                    
                    let items = [article.articleDescription ?? "", article.source ?? ""]
                    
                    List(items, id: \.self) { item in
                        Text(item)
                            .focusable()
                    }
                }
                

            }
            .ignoresSafeArea()
        }
        
        
    }
    
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article.testArticle)
            .previewLayout(.sizeThatFits)
    }
}
