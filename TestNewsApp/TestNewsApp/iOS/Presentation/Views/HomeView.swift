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
        
        return Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .scaleEffect(0.8, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle())
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List {
                        ArticlesPager(articles: [articles[0], articles[1], articles[2]], onCardSelected: { articleItem, isSet in
                            isEmpty = false
                            navigationViewIsActive = isSet
                            selectedFeaturedArticle = articleItem
                        })
                            .aspectRatio(3 / 2, contentMode: .fit)
                            .listRowInsets(EdgeInsets())
                        VStack {
                            if let item = selectedFeaturedArticle {
                                NavigationLink(destination: ArticleDetailView(article: item), isActive: $navigationViewIsActive){
                                    EmptyView()
                                }
                            }
                        }.hidden()
                        
                        ForEach(articles, id: \.self) {article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                ArticleRowView(article: article)
                            }
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    
                    .padding(.leading,6)
                    .padding(.trailing,6)
                    .frame(minWidth: 200,
                           maxWidth: .infinity,
                           minHeight: 200,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    
                    
                    .navigationTitle(Text("News"))
                    .navigationBarTitleDisplayMode(.inline)
                    
                    .frame(minWidth: 300)
                    .refreshable{
                        URLCache.imageCache.removeAllCachedResponses()
                        viewModel.getArticles()
                    }
                    
                    // Second view for wide layouts
                    Text("Select an article")
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
