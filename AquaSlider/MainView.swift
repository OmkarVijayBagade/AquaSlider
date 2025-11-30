//
//  ContentView.swift
//  AquaGuage
//
//  Created by Omkar Vijay Bagade on 20/11/25.
//

import SwiftUI

struct MainView: View {
    @State private var progress: CGFloat = 0.2
    var body: some View {
        TabView {
            Page1()
            Page2()
            Page3()
            Page4()
            Page5()
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    MainView()
}
