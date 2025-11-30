//
//  GuagePage1.swift
//  AquaGuage
//
//  Created by Omkar Vijay Bagade on 20/11/25.
//

import SwiftUI

struct Page1: View {
    @State private var progress: CGFloat = 0.2

    var body: some View {
        VStack {
            Text("Circular Guage")
                .padding(.bottom,100)
                .font(Font.largeTitle.bold())
                .fontDesign(.rounded)
            
            ZStack {
                //background circle
                Circle()
                    .stroke(.gray.opacity(0.2), lineWidth: 10)

                //foreground circle
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                .red, .orange, .yellow, .green, .blue, .purple,
                            ]),
                            center: .center
                        ),
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .shadow(color: .red.opacity(0.4), radius: 10)
                    //                    .animation(.easeInOut(duration: 0.3), value: progress)
                    .animation(
                        .spring(response: 0.4, dampingFraction: 0.7),
                        value: progress
                    )

                Circle()
                    .fill(Color.red)
                    .frame(width: 14, height: 14)
                    .offset(y: -100)
                    .rotationEffect(
                        .degrees(Double(progress) * 360 - 180),
                        anchor: .center
                    )

            }
            .frame(width: 300, height: 300)

            //slider
            Slider(value: $progress, in: 0...1)
                .tint(Color.orange)
                .padding(.horizontal, 30)
                .padding(.top, 20)
        }

    }
}

#Preview {
    Page1()
}
