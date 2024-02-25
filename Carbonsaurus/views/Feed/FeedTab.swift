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
                        VStack (alignment: .leading, spacing: 10) {
                                if(isLoading) {
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                    SkeletonNewsComponent()
                                } else {
                                    NavigationLink {
                                        QuizView(quiz: exampleQuizzes.randomElement() ?? exampleQuizzes[0])
                                    } label: {
                                        QuizSubView()
                                    }
                                    .buttonStyle(.plain)

                                    HStack{
                                        Spacer()
                                        Image("fern")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                        Spacer()
                                        Image("volcano")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                        Spacer()
                                        Image("fern")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                        Spacer()

                                    }
                                    .padding(5)
                                    
                                    Text("climate news")
                                        .bold()
                                        .font(.system(size: 32))

                                    ForEach(articles, id: \.self) { article in
                                        Link(destination: URL(string: article.url)!, label: {
                                            NewsComponent(date: formatDate(date: article.publishedAt), title: article.title, imageURL: article.urlToImage)
                                        }).buttonStyle(.plain)

                                    }
                                    
                                    HStack{
                                        Spacer()
                                        Image("fern")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                        Spacer()
                                        Image("volcano")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                        Spacer()
                                        Image("fern")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                        Spacer()

                                    }
                                    .padding(5)

                                }

                            }
                        .frame(width: UIScreen.main.bounds.width * 0.90)

                    }.navigationTitle("feed")
                    .navigationBarTitleDisplayMode(.large)
                    .task {
                        FeedService.shared.fetchTopStories { fetched in
                            if let stories = fetched {
                                articles = stories
                                isLoading = false
                            }
                        }
                    }
                }
            }
        }.refreshable {
            isLoading = true
            FeedService.shared.fetchTopStories { fetched in
                if let stories = fetched {
                    articles = stories
                    isLoading = false
                }
            }
        }
    }
}


#Preview {
    FeedTab()
}
