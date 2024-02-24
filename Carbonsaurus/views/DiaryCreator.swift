//
//  DiaryCreator.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryCreator: View {
    var body: some View {
        NavigationView{
            ZStack {
                Color.purple.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading, spacing: 20){
                        Text("new diary entry")
                            .bold()
                            .font(.system(size: 42))
                        
                        Group{
                            VStack(alignment: .leading, spacing: 30){
                                Text("How much did you drive today compared to a normal day?")
                                Text("How much did you use your phone today compared to an average day?")
                                Text("How much did you use large appliances (washer, dryer, oven, etc) compared to a normal day?")
                                Text("How much did you eat today compared to a normal day?")
                                Text("How much did you drive today compared to a normal day?")
                                Text("How much more did you shower today compared to a normal day?")
                            }
                        }
                        
                        Button(action: {
                            
                        }, label: {
                            HStack{
                                Spacer()
                                Text("Submit")
                                Spacer()
                            }
                                .padding(20)
                                .background(.white)
                                .cornerRadius(10)
                                
                        })
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
        }
    }
}

#Preview {
    DiaryCreator()
}
