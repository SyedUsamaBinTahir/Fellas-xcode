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
    @StateObject var viewModel = DisplayNameAndImageAPIService()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    AuthHeaderView(step: .constant("STEP 4 OF 5"))
                    
                    VStack(alignment: .center, spacing: 30) {
                        
                        DisplayNameAndImageLablesView()
                        
                        DisplayNameAndImageImageView(image: $selectedImage) {
                            showImagePicker.toggle()
                        }
                        
                        DisplayNameAndImageFieldAndButtonsView(name: $name, redirectToSubscribeView: $redirectToSubscribeView, showButtonLoader: $viewModel.showLoader) {
                            if let selectedImage = selectedImage {
                                viewModel.showLoader = true
                                viewModel.uploadImageToServer(image: selectedImage, name: name)
                            }
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    
                    Spacer()
                }
                .popup(isPresented: $viewModel.showAlert) {
                    FLToastAlert(image: .constant(""), message: .constant(viewModel.alertMessage))
                } customize: {
                    $0
                        .type(.floater(useSafeAreaInset: true))
                        .position(.top)
                        .animation(.spring())
                        .closeOnTapOutside(true)
                        .backgroundColor(.black.opacity(0.5))
                        .autohideIn(3)
                        .appearFrom(.top)
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
                .navigationDestination(isPresented: $viewModel.redirectToSubscribeView) {
                    SubscribeView()
                        .navigationBarBackButtonHidden(true)
                }
                
                NavigationLink(isActive: $viewModel.redirectToSubscribeView) {
                    SubscribeView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }

                
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
