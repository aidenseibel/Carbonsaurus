//
//  FeedTab.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/24/24.
//

import SwiftUI

struct FeedTab: View {
    var body: some View {
        NavigationStack {
            ZStack (alignment: .center) {
                Color.orange.opacity(0.3).edgesIgnoringSafeArea(.all)
                ScrollView (showsIndicators: false) {
                    VStack (spacing: 10) {
                        NewsComponent(date: "feb 24 - today", title: "United States rejoins the Paris Climate Agreement", imageTitle: "blue_dino_happy")
                        NewsComponent(date: "feb 24 - today", title: "Fortune 500 Company pledges Carbon Neutral by 2050", imageTitle: "blue_dino_happy")
                        NewsComponent(date: "feb 24 - today", title: "United States rejoins the Paris Climate Agreement", imageTitle: "blue_dino_happy")
                        NewsComponent(date: "feb 24 - today", title: "Fortune 500 Company pledges Carbon Neutral by 2050", imageTitle: "blue_dino_happy")
                    }

                }
            }.navigationTitle("feed")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    FeedTab()
}
