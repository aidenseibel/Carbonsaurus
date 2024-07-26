//
//  DiaryView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct DiaryView: View {
    @EnvironmentObject var viewModel: ViewModel

    var diary: Diary

    var body: some View {
        ZStack {
            Color.blue.opacity(0.30)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("\(formatDate(date: diary.date))")
                                .font(.system(size: 16))

                            HStack(alignment: .bottom) {
                                Text(String(format: "%.0f", diary.calculateCarbonFootprint(averages: viewModel.localUser.getDailyAverages())))
                                    .font(.system(size: 42))
                                    .bold()
                                Text("g of carbon")
                                    .padding(.bottom, 4)
                            }
                            
                            HStack(alignment: .bottom) {
                                Text(String(format: "%0.f", diary.dinoPoints()))
                                    .font(.system(size: 42))
                                    .bold()
                                Text("dino points")
                                    .padding(.bottom, 4)
                            }
                        }
                        Spacer()
                    }

                    Text("estimates")
                        .font(.title2)
                        .bold()
                        .padding(.top, 20)

                    Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10) {
                        GridRow {
                            HStack {
                                Spacer()
                                Text("hours driven")
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.trailing)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)

                            HStack {
                                Text("\(viewModel.localUser.averageDriving*diary.driving/3) (\(String(format: "%.0f", diary.getDrivingCarbon(average: viewModel.localUser.averageDriving))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }

                        GridRow {
                            HStack {
                                Spacer()
                                Text("electricity used")
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 14))
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)

                            HStack {
                                Text("\(viewModel.localUser.averageEnergy*diary.energy/3) (\(String(format: "%.0f", diary.getAppliancesCarbon(average: viewModel.localUser.averageEnergy))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }

                        GridRow {
                            HStack {
                                Spacer()
                                Text("calories eaten")
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 14))
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            HStack {
                                Text("\(viewModel.localUser.averageEating*diary.eat/3) (\(String(format: "%.0f", diary.getEatCarbon(average: viewModel.localUser.averageEating))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }

                        GridRow {
                            HStack {
                                Spacer()
                                Text("minutes showered")
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 14))
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            HStack {
                                Text("\(viewModel.localUser.averageShower*diary.shower/3) (\(String(format: "%.0f", diary.getShowerCarbon(average: viewModel.localUser.averageShower))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    .background(.white)
                    .cornerRadius(10)

                    Image(viewModel.localUser.getAvatarImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.70, height: UIScreen.main.bounds.width * 0.70)
                        .cornerRadius(20)
                    Text("on this day, your dino was ")
                        .font(.system(size: 14))
                }
                .padding()
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    DiaryView(diary: Diary(date: Date.now, driving: 3, energy: 3, eat: 3, shower: 3))
}
