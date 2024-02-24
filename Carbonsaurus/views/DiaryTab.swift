//
//  DiaryTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct DiaryTab: View {
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue.opacity(0.30)
                    .ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading){
                        Text("diary")
                            .bold()
                            .font(.system(size: 42))
                        ForEach(1..<5, id: \.self){_ in
                            DiaryEntry()
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.90)
            }
        }
    }
}

#Preview {
    DiaryTab()
}
