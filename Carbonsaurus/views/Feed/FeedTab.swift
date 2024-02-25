//
//  FeedTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct FeedTab: View {
    @State private var articles: [Article] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.orange.opacity(0.3).edgesIgnoringSafeArea(.all)

                ScrollView {
                    ZStack (alignment: .center) {
                        Color.orange.opacity(0).edgesIgnoringSafeArea(.all)
                            VStack (spacing: 10) {
                                ForEach(articles, id: \.self) { article in
                                    NewsComponent(date: formatDate(date: article.publishedDate), title: article.title, imageURL: article.multimedia[0].url)
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
            

        }
    }
}


#Preview {
    FeedTab()
}
