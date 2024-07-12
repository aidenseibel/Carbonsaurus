//
//  DiaryTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryTab: View {
    @EnvironmentObject var viewModel: ViewModel

    @State private var timer: Timer?
    @State var toggleDino: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        if !viewModel.hasLoggedToday {
                            NavigationLink {
                                DiaryCreator()
                            } label: {
                                HStack(spacing: 15) {
                                    Image("sun")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    VStack(alignment: .leading) {
                                        Text("time to check in!")
                                            .font(.title2)
                                            .bold()
                                        Text("complete your daily report")
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.bottom, 10)
                            }
                            .buttonStyle(.plain)
                        }

                        VStack(alignment: .leading) {
                            Text("this week")
                                .bold()
                                .font(.system(size: 28))

                            Text("\(viewModel.localUser.getAverageDinoPointsThisWeek()*7)/\(12000) dino points")
                                .font(.system(size: 16))
                                .padding(.bottom, 4)

                            ForEach(viewModel.localUser.getDiariesThisWeek().sorted { $0.date > $1.date }, id: \.self) {diary in
                                NavigationLink {
                                    DiaryEntryLarge(diary: diary)
                                } label: {
                                    DiaryEntrySubView(diary: diary)
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("all entries")
                                .bold()
                                .font(.system(size: 28))

                            Text("\(viewModel.localUser.getDinoPoints()) dino points")
                                .font(.system(size: 16))
                                .padding(.bottom, 4)

                            ForEach(viewModel.localUser.diaries.sorted { $0.date > $1.date }, id: \.self) {diary in
                                NavigationLink {
                                    DiaryEntryLarge(diary: diary)
                                } label: {
                                    DiaryEntrySubView(diary: diary)
                                }
                                .buttonStyle(.plain)
                            }

                        }

                    }.padding(.bottom, 100)
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
            .navigationTitle("diary")
            .navigationBarTitleDisplayMode(.large)

        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                toggleDino.toggle()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    DiaryTab()
}
