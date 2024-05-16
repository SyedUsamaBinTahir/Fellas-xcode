//
//  CarousalView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI
import ACarousel

struct CarousalView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let items: [Item] = roles.map { Item(image: Image($0)) }
        
        var body: some View {
            ACarousel(items,
                      spacing: 10,
                      headspace: 10,
                      sidesScaling: 0.9,
                      isWrap: true,
                      autoScroll: .active(8)) { item in
                item.image
                    .resizable()
                    .scaledToFill()
                    .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0.3)
                    }
            }
            .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
        }
}

#Preview {
    CarousalView()
}

struct Item: Identifiable {
    let id = UUID()
    let image: Image
}

let roles = ["series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image"]
