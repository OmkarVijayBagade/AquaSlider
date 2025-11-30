//
//  Page4.swift
//  AquaGuage
//
//  Created by Omkar Vijay Bagade on 21/11/25.
//

import SwiftUI

struct Page4: View {
    @State private var morph: Double = 0.4  // 0-> square, 1-> circle, 2->triangle
    @State private var rotation: Double = 10.0
    var body: some View {
        VStack(spacing: 50) {
            Text("Morph & Spin 🎨🌀")
                .font(Font.largeTitle.bold())
                .fontDesign(.rounded)

            ZStack {
                MorphShape(morph: morph)
                    .fill(
                        LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 250, height: 250)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut, value: morph)
                    .animation(.easeInOut,value: rotation)
            }
            VStack(alignment: .leading){
                Text("Morph").padding(.horizontal, 30)
                //Slider for morphing
                Slider(value: $morph, in: 0...1, step: 0.01)
                    .tint(.red)
                    .padding(.horizontal, 30)
            }
            VStack(alignment: .leading){
                Text("Spin").padding(.horizontal, 30)
                //Slider for rotation
                Slider(value: $rotation, in:0...360,step: 1)
                    .tint(.orange)
                    .padding(.horizontal, 30)
            }
                
            Text("Use sliders to morph and spin ").foregroundStyle(.gray)
        }
    }
}

struct MorphShape: Shape {
    var morph: Double
    var animatableData: Double {
        get { morph }
        set { morph = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        var path = Path()

        if morph <= 1 {
            //sqaure --> Circle
            let radius = (morph) * (w / 2)
            path.addRoundedRect(
                in: rect,
                cornerSize: CGSize(width: radius, height: radius)
            )
        } else {
            //circle --> triangle
            let t = morph - 1  // 0 -> 1
            let circleRadius = w / 2 * (1 - t)
            let triangleHeight = h * t

            path.addEllipse(
                in: CGRect(
                    x: rect.midX - circleRadius,
                    y: rect.midY - circleRadius,
                    width: circleRadius * 2,
                    height: circleRadius * 2
                )
            )

            let top = CGPoint(x: rect.midX, y: rect.midY - triangleHeight / 2)
            let left = CGPoint(
                x: rect.midX - w / 2,
                y: rect.midY + triangleHeight / 2
            )
            let right = CGPoint(
                x: rect.midX + w / 2,
                y: rect.midY + triangleHeight / 2
            )

            path.move(to: top)
            path.addLine(to: left)
            path.addLine(to: right)
            path.addLine(to: top)
        }
        return path
    }
}

#Preview {
    Page4()
}
