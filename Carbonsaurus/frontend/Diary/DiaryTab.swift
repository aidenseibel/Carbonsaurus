//
//  DiaryTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryTab: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 20) {
                        if !viewModel.hasLoggedToday {
                            NavigationLink {
                                DiaryCreatorView()
                            } label: {
                                DiaryReminderSubView()
                            }
                            .buttonStyle(.plain)
                        }
                        
                        Image("flowers")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.80)

                        VStack(alignment: .leading) {
                            Text("this week")
                                .bold()
                                .font(.system(size: 28))

                            Text(String(format: "%.0f", viewModel.localUser.getDinoPointsThisWeek()) + " dino points")
                                .font(.system(size: 14))
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
                                .font(.system(size: 22))

                            Text(String(format: "%.0f", viewModel.localUser.getDinoPoints()) + " dino points")
                                .font(.system(size: 14))
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
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("diary")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    DiaryTab()
}