//
//  GuagePage3.swift
//  AquaGuage
//
//  Created by Omkar Vijay Bagade on 20/11/25.
//

import SwiftUI

struct Page3: View {
    @State private var fillLevel: Double = 0.3
    @State private var wavePhase: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Water Fill Gauge")
                .font(Font.largeTitle.bold())
                .fontDesign(.serif)
            ZStack {
                VStack {
                    //bottle cap
                    Rectangle()
                        .frame(width: 20, height: 15)
                        .padding(.bottom, -10)
                    
                    //bottle
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black.opacity(0.7), lineWidth: 4)
                        .frame(width: 150, height: 350)
                        .overlay(
                            
                            //water with waves animation
                            WaterWave(progress: fillLevel, phase: wavePhase)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue.opacity(0.1),
                                            Color.blue.opacity(0.95),
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width:150,height:350)
                                .overlay(
                                    //Percentage level
                                    Text("\(Int(fillLevel*100))%")
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .shadow(radius:3)
                                        .offset(y: 150 * (1 - fillLevel))
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        )
                    
                    //Slider for controlling water level
                    Slider(value: $fillLevel, in: 0...1)
                        .padding(.horizontal, 30)
                        .padding(.top,30)
                    
                }
            }
            .padding(.top,50)
            .onAppear{
                // Animate wave phase continuously
                withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                    wavePhase = .pi * 2
                    
                }
            }
        }
    }
    
    struct WaterWave: Shape {
        //progress : 0 = Empty and 1 = Full
        var progress: Double
        var phase: CGFloat
        
        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }
        
        func path(in rect: CGRect) -> Path {
            let width = rect.width
            let height = rect.height
            let waveHeight: CGFloat = 10
            
            var path = Path()
            let yOffset = height * CGFloat(1 - progress)
            
            path.move(to: CGPoint(x: 0, y: yOffset))
            
            for x in stride(from: 0, through: width, by: 1) {
                let relativeX = x / width
                let sine = sin(2 * .pi * relativeX + phase)
                let y = yOffset + waveHeight * sine
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
            
            return path
        }
    }
}
#Preview {
    Page3()
}
