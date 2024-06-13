//
//  CastButtonRepresentable.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/06/2024.
//

import SwiftUI
import GoogleCast

struct CastButtonRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> GCKUICastButton {
        let castButton = GCKUICastButton(frame: .zero)
        castButton.tintColor = UIColor.white
        return castButton
    }

    func updateUIView(_ uiView: GCKUICastButton, context: Context) {
        // Update the view if needed
    }
}
