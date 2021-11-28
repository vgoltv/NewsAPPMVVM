//
//  ArticleDetailView.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 17.11.2021.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct ArticleDetailView: View {
    
    let article: Article
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView {
            if let imageURL = article.image, let url = URL(string: imageURL) {
                CachedAsyncImage(
                    url: url, urlCache: .imageCache
                ) { phase in
                    HStack(alignment:.center) {
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaleEffect(0.8, anchor: .center)
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: PlaceholderImageView.size.width, height: PlaceholderImageView.size.height)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                        case .failure:
                            PlaceholderImageView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity)
#if os(tvOS)
                    .focusable()
#endif
                }
            }
                
                Text(article.title ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.label)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.top, 15)
                
                Text(article.articleDescription ?? "")
                    .font(.body)
                    .foregroundColor(Color.label)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .padding()
            
#if os(tvOS)
            Text(article.source ?? "")
                .font(.subheadline)
                .focusable()
#else
            Button(action: {
                openArticle(url: article.url)
            },
                   label: {
                Text(article.source ?? "")
                    .font(.subheadline)
            })
#endif
            

                
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
#if os(iOS)
        .navigationTitle(article.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
#elseif os(tvOS)
        
#elseif os(macOS)
        .navigationTitle(article.title ?? "")
#endif
        
    }
    
    func openArticle(url: String?) {
            guard let link = url, let url = URL(string: link) else {
                return
            }
            openURL(url)
        }
}

/*
    .padding(.top, 5)
    .padding(.bottom, 5)
    .padding(.trailing, 5)
*/

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article.testArticle)
            .previewLayout(.sizeThatFits)
    }
}
