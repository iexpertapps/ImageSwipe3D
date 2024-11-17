//
//  Swipe3DView.swift
//  3D image swipe
//
//  Created by Syed Zia ur Rehman on 17/11/2024.
//

import SwiftUI

struct Swipe3DView: View {
    @State private var dragOffset: CGSize = .zero
    @State private var cardStack = Array(0..<5)
    private let swipeThreshold: CGFloat = 120

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(cardStack, id: \.self) { index in
                    CardView(index: index)
                        .frame(
                            width: geometry.size.width * 0.8,
                            height: geometry.size.height * 0.7
                        )
                        .offset(
                            x: cardStack.first == index ? dragOffset.width : 0,
                            y: CGFloat(cardStack.firstIndex(of: index) ?? 0) * 10
                        )
                        .scaleEffect(
                            max(1 - CGFloat(cardStack.firstIndex(of: index) ?? 0) * 0.05, 0.85)
                        )
                        .rotation3DEffect(
                            .degrees(Double(dragOffset.width / 10)),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .opacity(
                            max(1.0 - abs(dragOffset.width) / (geometry.size.width * 0.5), 0.5)
                        )
                        .animation(.spring(), value: dragOffset)
                        .zIndex(
                            Double(cardStack.count - (cardStack.firstIndex(of: index) ?? 0))
                        )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if cardStack.first != nil {
                            dragOffset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if let topCard = cardStack.first, abs(dragOffset.width) > swipeThreshold {
                            cardStack.removeFirst()
                            print("Swiped \(dragOffset.width > 0 ? "Right" : "Left") on Card \(topCard)")
                        }
                        dragOffset = .zero
                    }
            )
        }
    }
}
