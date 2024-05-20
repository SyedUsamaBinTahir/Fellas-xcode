//
//  DoubleTapSeek.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct DoubleTapSeek: View {
    var isForward: Bool = false
    var onTap: () -> ()
    /// Animation Properties
    @State private var isTapped: Bool = false
    /// Since we have three arrow
    @State private var showArrow: [Bool] = [false, false, false]
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .overlay {
                Circle()
                    .fill(.black.opacity(0.3))
                    .scaleEffect(2, anchor: isForward ? .leading : .trailing)
            }
            .clipped()
            .opacity(isTapped ? 1 : 0)
            /// Arrows
            .overlay {
                VStack(spacing: 10) {
                    HStack(spacing: 0) {
                        ForEach((0...2).reversed(), id: \.self) { index in
                            Image(systemName: "arrowtriangle.backward.fill")
                                .opacity(showArrow[index] ? 1 : 0.2)
                        }
                    }
                    .font(.title)
                    .rotationEffect(.init(degrees: isForward ? 180 : 0))
                    
                    Text("15 Seconds")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .opacity(isTapped ? 1 : 0)
            }
            .contentShape(Rectangle())
            .onTapGesture(count: 2) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isTapped = true
                    showArrow[0] = true
                }
                
                withAnimation(.easeInOut(duration: 0.2).delay(0.2)) {
                    showArrow[0] = true
                    showArrow[1] = true
                }
                
                withAnimation(.easeInOut(duration: 0.2).delay(0.35)) {
                    showArrow[1] = true
                    showArrow[2] = true
                }
                
                withAnimation(.easeInOut(duration: 0.2).delay(0.5)) {
                    showArrow[2] = false
                    isTapped = false
                }
                
                /// calling on tap function after animatin has been initiated
                onTap()
            }
    }
}
