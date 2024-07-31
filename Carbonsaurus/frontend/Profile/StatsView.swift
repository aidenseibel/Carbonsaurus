//
//  StatsView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.green.opacity(0.30)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading){
                        Text("this week")
                            .bold()
                            .font(.title2)
                        
                        Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10) {
                            GridRow {
                                HStack {
                                    Spacer()
                                    Text("carbon footprint")
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.trailing)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.40)
                                
                                HStack {
                                    Text(String(format: "%.2f", viewModel.localUser.getCarbonFootprintThisWeek()/1000) + " kg")
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
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.trailing)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.40)
                                HStack {
                                    Text(String(format: "%.0f", viewModel.localUser.getAverageDinoPointsThisWeek()))
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
                    }

                    VStack(alignment: .leading){
                        Text("overall stats")
                            .bold()
                            .font(.title2)
                        
                        // MARK: STATS
                        Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10) {
                            GridRow {
                                HStack {
                                    Spacer()
                                    Text("total diaries")
                                        .font(.system(size: 14))
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
                                    Text("total dino points")
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.trailing)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.40)
                                
                                HStack {
                                    Text(String(format: "%.0f", viewModel.localUser.getDinoPoints()))
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
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.trailing)
                                }
                                HStack {
                                    Text(String(format: "%.0f", viewModel.localUser.getAverageDinoPoints()))
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
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.90)
        }
    }
}

#Preview {
    StatsView()
}
