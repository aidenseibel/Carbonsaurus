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
                VStack(alignment: .leading, spacing: 30) {
                    Text("\(formatDate(date: diary.date))")
                        .font(.title2)
                        .bold()

                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            Text(String(format: "%.0f", diary.calculateCarbonFootprint(averages: viewModel.localUser.getDailyAverages())))
                                .font(.system(size: 36))
                                .bold()
                            Text("g of carbon")
                                .padding(.bottom, 4)
                            Spacer()
                        }
                        
                        HStack(alignment: .bottom) {
                            Text(String(format: "%0.f", diary.dinoPoints()))
                                .font(.system(size: 36))
                                .bold()
                            Text("dino points")
                                .padding(.bottom, 4)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)

                    Text("estimates")
                        .font(.title2)
                        .bold()

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
                                Text("\(String(format: "%.0f", viewModel.localUser.averageDriving*diary.driving/3)) (\(String(format: "%.0f", diary.getDrivingCarbon(average: viewModel.localUser.averageDriving))) g)")
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
                                Text("\(String(format: "%.0f", viewModel.localUser.averageEnergy*diary.energy/3)) (\(String(format: "%.0f", diary.getEnergyCarbon(average: viewModel.localUser.averageEnergy))) g)")
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
                                Text("\(String(format: "%.0f", viewModel.localUser.averageEating*diary.eat/3)) (\(String(format: "%.0f", diary.getEatCarbon(average: viewModel.localUser.averageEating))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }

                        GridRow {
                            HStack {
                                Spacer()
                                Text("water used")
                                    .multilineTextAlignment(.trailing)
                                    .font(.system(size: 14))
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            HStack {
                                Text("\(String(format: "%.0f", viewModel.localUser.averageWater*diary.water/3)) (\(String(format: "%.0f", diary.getWaterCarbon(average: viewModel.localUser.averageWater))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding()
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    DiaryView(diary: Diary(date: Date.now, driving: 3, energy: 3, eat: 3, water : 3))
}
