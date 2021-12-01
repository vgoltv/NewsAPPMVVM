import SwiftUI
import CachedAsyncImage

struct FeatureCard: View, Identifiable {
    let id = UUID()
    
    var article: Article
    let onCardSelected: ((Article, Bool) -> Void)?
    
    public init(article: Article,
                onCardSelected: ((Article, Bool) -> Void)? = nil ) {
        self.article = article
        self.onCardSelected = onCardSelected
    }
    
    var body: some View {
        
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
                                .frame(width: PlaceholderImageView.size.width,
                                       height: PlaceholderImageView.size.height)
                        }
                    case .success(let image):
                        
                        Button(action: {
                            self.onCardSelected?(article, true)
                        }, label: {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth:.infinity)
                                .clipped()
                                .ignoresSafeArea(edges: .top)
                                .overlay(TextOverlay(article: article))
                        })
                            .buttonStyle(PlainButtonStyle())
                        
                        

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
        
        
        /*
        return article.featureImage?
            .resizable()
            .aspectRatio(3 / 2 , contentMode: .fit)
            .overlay(TextOverlay(article: article, delegate:self))
        */
    }
    
}

struct TextOverlay : View {
    var article: Article
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            Rectangle().fill(gradient)
                .allowsHitTesting(false)
            VStack(alignment: .leading) {
                /*
                Text(article.title ?? "")
                    .font(.caption)
                    .bold()
                    .padding(.bottom, 15)
                */
                Text(article.source ?? "")
                    .font(.footnote)
                    .padding(.bottom, 15)
                
            }
            .allowsHitTesting(false)
            .padding()
        }
        .foregroundColor(.white)
    }
}




