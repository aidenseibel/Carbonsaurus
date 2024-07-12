//
//  CarbonFootprintBreakdown.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import SwiftUI

struct CarbonFootprintBreakdownSubView: View {
    @EnvironmentObject var viewModel: ViewModel

    @State private var timer: Timer?
    @State var toggleDino: Bool = false

    var body: some View {
        HStack(spacing: 1) {
            VStack(alignment: .leading, spacing: 5) {
                Text("view your carbon footprint breakdown")
                    .multilineTextAlignment(.leading)
                    .bold()
                    .font(.title3)
                Text("want to see how you compare?")
                    .bold()
                    .font(.system(size: 14))
            }
            Spacer()
            Image("meteor_1")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .rotationEffect(toggleDino ? Angle(degrees: 10.0) : Angle(degrees: -10.0))

        }
        .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 5))
        .frame(width: UIScreen.main.bounds.width * 0.90)
        .background(.white)
        .cornerRadius(10)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                toggleDino.toggle()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    CarbonFootprintBreakdownSubView()
}
