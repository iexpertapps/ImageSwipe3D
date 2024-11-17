//
//  CardView.swift
//  3D image swipe
//
//  Created by Syed Zia ur Rehman on 17/11/2024.
//

import SwiftUI

struct CardView: View {
    let index: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 10)
            Text("Card \(index + 1)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

