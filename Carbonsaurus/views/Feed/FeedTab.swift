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
    
    @State private var timer: Timer?
    @State var toggleDino: Bool = false
    
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
                                        VStack {
                                            Text("🐻‍❄️donate to the EDF!🐻‍❄️")
                                                .bold()
                                                .foregroundColor(.black)
                                                .padding(.top, 10)
                                                .padding(.bottom, 5)
                                            Text("help directly fight global warming")
                                                .padding(.bottom, 10)
                                                .bold()
                                        }                                      
                                        .shadow(radius: 10)
                                        .onTapGesture {
                                            openURL(URL(string: "https://www.edf.org/climate/why-fighting-climate-change-so-urgent?utm_source=google&utm_campaign=edf_none_upd_dmt&utm_medium=cpc&utm_id=1561743801&gad_source=1&gclid=Cj0KCQiA5-uuBhDzARIsAAa21T92YJeqrara4wK_vnoAL5wx5jHKi2tcsSL96DOenmoElv9pYV-9ycMaAn7rEALw_wcB&gclsrc=aw.ds")!)
                                        }
                                        Spacer()
                                    }.background(.white)
                                        .cornerRadius(10)
                                    HStack{
                                        Spacer()
                                        Image("fern")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                        Spacer()
                                        Image("volcano")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                        Spacer()
                                        Image("fern")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                        Spacer()

                                    }
                                    .padding(20)


                                    
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
                                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                        Spacer()
                                        Image("volcano")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                        Spacer()
                                        Image("fern")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                                        Spacer()

                                    }
                                    .padding(5)
                                    .padding(.bottom, 100)
                                    
                                    .onAppear{
                                        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                                            toggleDino.toggle()
                                        }
                                    }
                                    .onDisappear{
                                        timer?.invalidate()
                                    }

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
