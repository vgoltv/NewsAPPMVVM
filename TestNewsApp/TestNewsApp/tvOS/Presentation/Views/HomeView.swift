//
//  HomeView.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    @State var isEmpty: Bool = false
    @State var navigationViewIsActive: Bool = false
    @State var selectedFeaturedArticle : Article? = nil
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .scaleEffect(0.8, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle())
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List{
                        let topNews = Array(articles.choose(3))
                        ArticlesPager(articles: topNews, onCardSelected: { articleItem, isSet in
                            isEmpty = false
                            navigationViewIsActive = isSet
                            selectedFeaturedArticle = articleItem
                        })
                            .ignoresSafeArea(edges: .top)
                            .frame(maxWidth:.infinity)
                            .frame(height: 450)
                            .listRowInsets(EdgeInsets())

                        VStack {
                            if let item = selectedFeaturedArticle {
                                NavigationLink(destination: ArticleDetailView(article: item), isActive: $navigationViewIsActive){
                                    EmptyView()
                                }
                            }
                        }.hidden()
                        
                        let cw:CGFloat = 240
                        let ch:CGFloat = 180
                        
                        let popular = Array(articles.choose(8))
                        CategoryRow(name: "POPULAR", items: popular, thumbWidth: cw, thumbHeight: ch)
                        
                        let newest = Array(articles.choose(8))
                        CategoryRow(name: "NEWEST", items: newest, thumbWidth: cw, thumbHeight: ch)
                        
                        let recent = Array(articles.choose(8))
                        CategoryRow(name: "RECENT", items: recent, thumbWidth: cw, thumbHeight: ch)
                        
                        /*
                        ForEach(articles, id: \.self) {article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                ArticleRowView(article: article)
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        */
                    }
                    .ignoresSafeArea()
                    .frame(minWidth: 200,
                           maxWidth: .infinity,
                           minHeight: 450,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    .frame(minWidth: 300)

                }
                
            }
        }
        .onAppear(perform: viewModel.getArticles)


    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
