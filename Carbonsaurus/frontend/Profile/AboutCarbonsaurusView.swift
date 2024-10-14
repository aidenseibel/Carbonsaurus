//
//  AboutCarbonsaurusView.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 10/14/24.
//

import SwiftUI

struct AboutCarbonsaurusView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: ViewModel
    
    let text: String = "CarbonSaurus was a project created by computer science students Yash Shah (UT Dallas) and Aiden Seibel (Trinity University) in March 2024. \n\nThe initial version of the app, built in 24 hours, won Best Overall Design and Third Place Overall at RowdyHacks, a hackathon hosted by the University of Texas at San Antonio. \n\nSince the hackathon, we decided to improve the app and release it to the App Store in October 2024 with the goal of persuading users to be climate-aware on a day to day basis. \n\nWe undoubtedly have plans to continue working on the app and improving the overall experience; if you’d like to help out, give us feedback at the link on the settings page."

    var body: some View {
        ZStack {
            Color.green.opacity(0.30)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    Text(text)
                }
                .padding()
            }
            .navigationTitle("about this app")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    AboutCarbonsaurusView()
}
