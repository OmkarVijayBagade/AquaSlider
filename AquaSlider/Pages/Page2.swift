//
//  GuagePage2.swift
//  AquaGuage
//
//  Created by Omkar Vijay Bagade on 20/11/25.
//

import SwiftUI

struct Page2: View {
    //    @State private var progress = 0.2
    @State private var progressValue: [Double] = Array(repeating: 0.1, count: 3)
    let barCount = 3
    let barwidth: CGFloat = 10
    let barHeight: CGFloat = 350
    let spacing: CGFloat = 10

    var body: some View {
        VStack {
            Text("Guage Page 2")
                .font(.largeTitle)
                .fontDesign(.monospaced)
                .bold()
                .padding(.top, 50)

            HStack(spacing: spacing) {
                ForEach(0..<barCount, id: \.self) { index in
                    ZStack(alignment: .bottom) {
                        //background bar
                        Rectangle()
                            .frame(width: barwidth, height: barHeight)
                            .opacity(0.2)
                            .clipShape(Capsule())

                        //Foreground bar
                        Rectangle()
                            .frame(
                                width: barwidth + 4,
                                height: barHeight
                                    * CGFloat(progressValue[index])
                            )
                            .foregroundStyle(Color.pink)
                            .clipShape(Capsule())
                            .animation(.bouncy(), value: progressValue)
                    }
                }
            }
            .padding(.bottom, 50)

            //sliders for each bar
            ForEach(0..<barCount, id: \.self) { index in
                HStack {
                    Text("Bar \(index+1)")
                        .font(Font.title2)
                        .fontDesign(.monospaced)
                        .kerning(2)

                    Slider(value: $progressValue[index], in: 0...1)
                        .tint(.pink)
                }
            }.padding(.horizontal, 20)

            
        }
    }
}

#Preview {
    Page2()
}
