//
//  DiaryEntryLarge.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct DiaryEntryLarge: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var diary: Diary
    
    var body: some View {
        ZStack{
            Color.yellow.opacity(0.50)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false){
                VStack{
                    HStack{
                        VStack(alignment: .leading, spacing: 20){
                            Text("\(formatDate(date: diary.date))")
                                .bold()
                                .font(.system(size: 28))

                            HStack(alignment: .bottom){
                                Text("\(diary.calculateCarbonFootprint(averages: viewModel.localUser.getDailyAverages()))")
                                    .font(.system(size: 42))
                                    .bold()
                                Text("g of carbon")
                                    .bold()
                                    .padding(.bottom, 4)
                            }
                            
                            
                            HStack(alignment: .bottom){
                                Text("\(diary.dinoPoints())")
                                    .font(.system(size: 42))
                                    .bold()
                                Text("dino points")
                                    .bold()
                                    .padding(.bottom, 4)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.90)
                    
                    Image(viewModel.localUser.avatar.getImageString())
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.70, height: UIScreen.main.bounds.width * 0.70)
                        .cornerRadius(20)
                    
                    Text("estimates")
                        .font(.title2)
                        .bold()
                        .padding(.top, 20)
                    
                    Grid(alignment: .trailing, horizontalSpacing: 20, verticalSpacing: 10){
                        GridRow{
                            HStack{
                                Spacer()
                                Text("hours driven")
                                    .multilineTextAlignment(.trailing)
                                    .bold()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            
                            HStack{
                                Text("\(viewModel.localUser.average_driving*diary.driving/3) (\(String(format: "%.0f", diary.getDrivingCarbon(average: viewModel.localUser.average_driving))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                        
                        GridRow{
                            HStack{
                                Spacer()
                                Text("screen time minutes")
                                    .multilineTextAlignment(.trailing)
                                    .bold()
                                
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            HStack{
                                Text("\(viewModel.localUser.average_phone*diary.phone/3) (\(String(format: "%.0f", diary.getPhoneCarbon(average: viewModel.localUser.average_phone))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                        
                        GridRow{
                            HStack{
                                Spacer()
                                Text("large appliances used")
                                    .multilineTextAlignment(.trailing)
                                    .bold()
                                
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            HStack{
                                Text("\(viewModel.localUser.average_appliances*diary.appliances/3) (\(String(format: "%.0f", diary.getAppliancesCarbon(average: viewModel.localUser.average_appliances))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                        
                        GridRow{
                            HStack{
                                Spacer()
                                Text("calories eaten")
                                    .multilineTextAlignment(.trailing)
                                    .bold()
                                
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            HStack{
                                Text("\(viewModel.localUser.average_eating*diary.eat/3) (\(String(format: "%.0f", diary.getEatCarbon(average: viewModel.localUser.average_eating))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                        
                        GridRow{
                            HStack{
                                Spacer()
                                Text("minutes showered")
                                    .multilineTextAlignment(.trailing)
                                    .bold()
                                
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.35)
                            HStack{
                                Text("\(viewModel.localUser.average_shower*diary.shower/3) (\(String(format: "%.0f", diary.getShowerCarbon(average: viewModel.localUser.average_shower))) g)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.40)
                        }
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    .background(.white)
                    .cornerRadius(10)
                    
                }
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    DiaryEntryLarge(diary: Diary(date: Date.now, driving: 3, phone: 4, appliances: 3, eat: 3, shower: 3))
}
