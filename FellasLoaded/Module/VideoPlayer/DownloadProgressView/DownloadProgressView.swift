//
//  DownloadProgressView.swift
//  FellasLoaded
//
//  Created by Syed Usama on 18/07/2024.
//

import SwiftUI

struct DownloadProgressView: View {
    @EnvironmentObject var downloadModel: DownloadTaskModel
    @Binding var progress: CGFloat
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.5))
            
            ProgressShape(progress: progress)
                .fill(Color.gray.opacity(0.45))
                .rotationEffect(.init(degrees: -90))
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
    DownloadProgressView(progress: .constant(0.5))
}

struct ProgressShape: Shape {
    var progress: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            
            // half the height will be radius
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 20, startAngle: .zero, endAngle: .init(degrees: Double(progress * 360)), clockwise: false)
        }
    }
}
