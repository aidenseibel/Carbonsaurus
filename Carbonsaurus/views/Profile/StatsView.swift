//
//  StatsView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct StatsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: ViewModel
    @State private var timer: Timer?
    @State var toggleDino: Bool = false

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.50)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    // MARK: WEEK STATS
                    HStack {
                        Spacer()
                        Image("tree")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                        Spacer()
                        Text("this week")
                            .bold()
                            .font(.title2)
                        Spacer()
                        Image("tree")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                        Spacer()
                    }
                    .padding(.top, 50)

                    Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10) {
                        GridRow {
                            HStack {
                                Spacer()
                                Text("carbon footprint this week")
                                    .multilineTextAlignment(.trailing)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)

                            HStack {
                                Text("\(viewModel.localUser.getCarbonFootprintThisWeek()/1000) kg")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }

                        GridRow {
                            HStack {
                                Spacer()
                                Text("avg. dino points this week")
                                    .multilineTextAlignment(.trailing)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                            HStack {
                                Text("\(viewModel.localUser.getAverageDinoPointsThisWeek())")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    .background(.white)
                    .cornerRadius(10)

                    HStack {
                        Spacer()
                        Image("tree")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                        Spacer()
                        Text("overall stats")
                            .bold()
                            .font(.title2)
                        Spacer()
                        Image("tree")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))
                        Spacer()
                    }

                    // MARK: STATS
                    Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10) {
                        GridRow {
                            HStack {
                                Spacer()
                                Text("total dino points")
                                    .multilineTextAlignment(.trailing)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)

                            HStack {
                                Text("\(viewModel.localUser.getDinoPoints())")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }

                        GridRow {
                            HStack {
                                Spacer()
                                Text("diaries")
                                    .multilineTextAlignment(.trailing)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                            HStack {
                                Text("\(viewModel.localUser.diaries.count)")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }

                        GridRow {
                            HStack {
                                Spacer()
                                Text("average dino points")
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("\(viewModel.localUser.getDinoPoints() / viewModel.localUser.diaries.count)")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    .background(.white)
                    .cornerRadius(10)

                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("dismiss")
                            .foregroundColor(.yellow.opacity(0.70))
                            .buttonStyle(.plain)
                            .padding(20)
                            .bold()
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 100)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.90)
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
}

#Preview {
    StatsView()
}