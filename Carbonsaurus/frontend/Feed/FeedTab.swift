//
//  FeedTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct FeedTab: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.openURL) var openURL
    @State private var articles: [Article] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? = nil
    
    func fetchArticles() {
        FeedService.shared.fetchTopStories { fetched in
            if let stories = fetched {
                articles = stories
            } else {
                errorMessage = "something went wrong when fetching the articles, try again later."
            }
            isLoading = false
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.orange.opacity(0.3).ignoresSafeArea()

                ScrollView {
                    if !viewModel.hasAnsweredDailyQuestion{
                        NavigationLink {
                            QuizView(quiz: exampleQuizzes.randomElement() ?? exampleQuizzes[0])
                        } label: {
                            QuizSubView()
                        }
                        .buttonStyle(.plain)
                    } else {
                        Image("volcano_trees")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.80)
                    }
                    VStack(alignment: .center, spacing: 25) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("recent climate news")
                                .bold()
                                .font(.system(size: 22))
                            if isLoading {
                                SkeletonNewsComponent()
                                SkeletonNewsComponent()
                                SkeletonNewsComponent()
                                SkeletonNewsComponent()
                                SkeletonNewsComponent()
                            } else if(errorMessage != nil) {
                                Text(errorMessage!)
                                    .padding(.top, 15)
                            } else {
                                    ForEach(articles, id: \.self) { article in
                                        Link(destination: URL(string: article.url)!, label: {
                                            NewsComponent(date: formatDate(date: article.publishedAt), title: article.title, imageURL: article.urlToImage)
                                        }).buttonStyle(.plain)
                                    }
                            }
                        }

                    }
                    .padding()
                    .padding(.bottom, 100)
                    .navigationTitle("feed")
                    .navigationBarTitleDisplayMode(.large)
                    .task {
                        fetchArticles()
                    }
                }
            }
        }.refreshable {
            isLoading = true
            fetchArticles()
        }
    }
}

#Preview {
    FeedTab()
}
