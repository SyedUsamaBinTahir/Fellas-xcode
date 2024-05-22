//
//  Segments.swift
//  FellasLoaded
//
//  Created by Phebsoft on 21/05/2024.
//

import SwiftUI

enum SegmentsTab: String, CaseIterable {
    case EPISODES
    case RECOMMENDED
}

struct Segments: View {
    @Binding var selectedTab: SegmentsTab
    private var selectedSegment: String {
        selectedTab.rawValue
    }
    var body: some View {
        HStack(spacing: 20){
            ForEach (SegmentsTab.allCases, id: \.rawValue) { tab in
                VStack(spacing: 3) {
                    Text(tab.rawValue)
                        .font(.custom(Font.semiBold, size: 18))
                        .foregroundColor(.white)
                    if selectedTab == tab {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .frame(width: 80, height: 3)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.clear)
                            .frame(width: 16, height: 3)
                    }
                }
                .onTapGesture {
                        selectedTab = tab
                }
            }
        }
    }
}

#Preview {
    Segments(selectedTab: .constant(.EPISODES))
}
