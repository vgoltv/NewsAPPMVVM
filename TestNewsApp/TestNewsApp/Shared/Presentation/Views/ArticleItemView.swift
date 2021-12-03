//
//  ArticleItemView.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import SwiftUI
import CachedAsyncImage

struct ArticleItemView: View {
    
    let article: Article
    
    let thumbWidth:CGFloat
    let thumbHeight:CGFloat
    
    var body: some View {
        HStack {
            if let imageURL = article.media, let url = URL(string: imageURL) {
                CachedAsyncImage(
                    url: url, urlCache: .imageCache
                ) { phase in
                    HStack(alignment:.center) {
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaleEffect(0.8, anchor: .center)
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: thumbWidth, height: thumbHeight)
                        case .success(let image):
                            image
#if os(tvOS)
                                .resizable()
                                .scaledToFill()
#else
                                .resizable()
                                .scaledToFill()
                                .frame(width: thumbWidth, height: thumbHeight)
                                .addBorder( Color.separatorColor,
                                            width: 2,
                                            cornerRadius: 10)
#endif
                        case .failure:
                            PlaceholderImageView()
                        @unknown default:
                            EmptyView()
                        }
                    }
#if os(tvOS)
                    .frame(width: thumbWidth + 20)
#else
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .frame(width: thumbWidth + 20)
#endif
                    
                }
            } else {
                HStack(alignment:.center) {
                    PlaceholderImageView()
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
                .frame(width: thumbWidth + 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background( Color.secondarySystemBackground )
    }
    
    
}


