//
//  FeedTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct FeedTab: View {
    @State private var articles: [Article] = []
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.orange.opacity(0.3).edgesIgnoringSafeArea(.all)
                ScrollView {
                    ZStack (alignment: .center) {
                        Color.orange.opacity(0).edgesIgnoringSafeArea(.all)
                            VStack (spacing: 10) {
                                if(isLoading) {
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                } else {
                                    ForEach(articles, id: \.self) { article in
                                        Link(destination: URL(string: article.url!)!, label: {
                                            NewsComponent(date: formatDate(date: article.publishedDate), title: article.title, imageURL: article.multimedia[0].url)
                                        }).buttonStyle(.plain)

                                    }
                                }

                            }
                        
                    }.navigationTitle("feed")
                    .navigationBarTitleDisplayMode(.large)
                    .task {
                        FeedService.shared.fetchTopStories { fetched in
                            if let stories = fetched {
                                articles = stories
                            }
                        }
                    }
                }
            }
        }.refreshable {
            FeedService.shared.fetchTopStories { fetched in
                if let stories = fetched {
                    articles = stories
                }
            }
        }
    }
}


#Preview {
    FeedTab()
}
