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
    @State private var selectedTab: SegmentsTab = .EPISODES
    @State private var allTabs: [SegmentsTab] = [.EPISODES, .RECOMMENDED]
    
    @Binding var episodeCount: Int
    
    var action: (SegmentsTab) -> Void
    
    init(episodeCount: Binding<Int>, action: @escaping (SegmentsTab) -> Void) {
        self._episodeCount = episodeCount
        self.action = action
    }
    var body: some View {
        HStack(spacing: 20){
            ForEach (allTabs, id: \.rawValue) { tab in
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
        .onChange(of: self.episodeCount, perform: { value in
            switch value {
            case 0, 1:
                self.allTabs.remove(at: 0)
                self.selectedTab = .RECOMMENDED
                
            default:
                self.allTabs = SegmentsTab.allCases
            }
        })
        .onChange(of: self.selectedTab, perform: { value in
            self.action(value)
        })
        .onAppear {
            switch episodeCount {
            case 0, 1:
                self.allTabs.removeFirst()
                self.selectedTab = .RECOMMENDED
                
            default:
                self.allTabs = SegmentsTab.allCases
                
            }
        }
    }
}

//#Preview {
//    Segments(selectedTab: .constant(.EPISODES))
//}
