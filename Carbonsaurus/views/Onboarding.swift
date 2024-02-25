//
//  Onboarding.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct Onboarding: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Namespace var questionsID

    @State var driving: String = ""
    @State var phone: String = ""
    @State var appliances: String = ""
    @State var eat: String = ""
    @State var shower: String = ""

    var body: some View {
        ZStack {
            Color.red.opacity(0.30)
                .ignoresSafeArea()
            
            ScrollViewReader{ proxy in
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading, spacing: 20){
                        Image("pink_dino_transparent")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.width * 0.25)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                        Text("A few things before we start")
                            .font(.system(size: 48))
                            .bold()
                        Text("We need to collect a few metrics from you so we can get your carbon footpeint accurate.")
                            .bold()
                        Text("You can change these at any time, so don't worry!")
                            .bold()
                            .padding(.bottom, 50)
                        
                        Button("to the questions!") {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                proxy.scrollTo(questionsID, anchor: .top)
                            }
                        }
                        .foregroundColor(.pink.opacity(0.55))
                            .buttonStyle(.plain)
                            .padding(20)
                            .bold()
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 100)
                        
                        
                        Group{
                            VStack(alignment: .leading, spacing: 50){
                                VStack(alignment: .leading){
                                    Text("How many miles do you drive on an average day?")
                                        .bold()
                                        .id(questionsID)
                                    TextField("enter miles", text: $driving)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("What is your daily average screen time?")
                                        .bold()
                                    TextField("enter hours", text: $phone)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("How often do you use large appliances (washer, dryer, oven, etc) on any given day?")
                                        .bold()
                                    TextField("enter number of times", text: $appliances)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("How many calories do you eat every day?")
                                        .bold()
                                    TextField("enter calories", text: $eat)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("How many minutes do you shower on an average day?")
                                        .bold()
                                    TextField("enter minutes", text: $shower)
                                        .padding(10)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.bottom, 70)
                        
                        
                        
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack{
                                Spacer()
                                Text("let's go!")
                                    .bold()
                                    .foregroundColor(.pink.opacity(0.55))
                                Spacer()
                            }
                            .padding(20)
                            .background(.white)
                            .cornerRadius(10)
                        })
                        .frame(width: UIScreen.main.bounds.width * 0.90)

                    }
                    .frame(width: UIScreen.main.bounds.width * 0.90)
                    .padding(.top, UIScreen.main.bounds.width * 0.50)
                    
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
