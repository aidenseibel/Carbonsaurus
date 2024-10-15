//
//  Tutorial.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 10/15/24.
//

import SwiftUI

struct Tutorial: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @EnvironmentObject var viewModel: ViewModel
    
    let screenWidth: Double = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            Color.red.opacity(0.30)
                .ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Welcome to Carbonsaurus!")
                            .font(.system(size: 36))
                            .bold()
                        Text("Congratulations! You now have a virtual pet dinosaur.")
                        Text("Every day, you can fill out a carbon diary to earn ") +
                        Text("dino points").bold().underline() +
                        Text(".")
                        Text("You can spend your dino points to customize your dinosaur, including colors, accessories, and backgrounds.")
                        Text("Make sure you fill out your diary, or your dinosaur might become sad!")
                        
                        Button(action: {
                            
                        }, label: {
                            HStack {
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
                    .padding(.top, UIScreen.main.bounds.width * 0.40)
                }
            }
        }
    }
}

#Preview {
    Tutorial()
}
