//
//  DisplayNameAndImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct DisplayNameAndImageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var redirectToSubscribeView = false
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                AuthHeaderView(step: .constant("STEP 4 OF 5"))
                
                VStack(alignment: .center, spacing: 30) {
                    
                    DisplayNameAndImageLablesView()
                    
                    DisplayNameAndImageImageView(image: $selectedImage) {
                        showImagePicker.toggle()
                    }
                    
                    DisplayNameAndImageFieldAndButtonsView(name: $name, redirectToSubscribeView: $redirectToSubscribeView) {
                        if let selectedImage = selectedImage {
                            DisplayNameAndImageAPIService.shared.uploadImageToServer(image: selectedImage, name: name)
                        }
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                Spacer()
            }
            .sheet(isPresented: $showImagePicker, onDismiss: {
                if selectedImage == nil {
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }, content: {
                ImagePicker(selectedImage: $selectedImage)
            })
            .navigationDestination(isPresented: $redirectToSubscribeView) {
                SubscribeView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DisplayNameAndImageView()
}
