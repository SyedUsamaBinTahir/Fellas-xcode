//
//  EditProfile.swift
//  FellasLoaded
//
//  Created by Phebsoft on 11/07/2024.
//

import SwiftUI
import ExytePopupView

struct EditProfile: View {
    @State var name: String = ""
    @State var showImagePicker: Bool = false
    @State var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    @StateObject var editProfileViewModel = EditProfileApiService()
    
    var body: some View {
        ZStack {
            VStack {
                
                SettingsHeaderView(title: .constant("Edit Profile"))
                
                VStack(spacing: 30) {
                    Button(action: { showImagePicker = true }, label: {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .cornerRadius(50)
                                .overlay {
                                    Circle()
                                        .stroke(Color.white)
                                }
                        } else {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .foregroundColor(.gray)
                                .cornerRadius(50)
                                .overlay {
                                    Circle()
                                        .stroke(Color.white)
                                }
                        }
                    })
                    
                    AuthTestFieldView(field: $name,
                                      title: "Display name",
                                      placeHolder: "")
                    
                    AuthButtonView(action: {
                        if let selectedImage = selectedImage {
                            editProfileViewModel.uploadImageToServer(image: selectedImage,
                                                                     name: name)
                        }
                    },
                                   title: "SAVE",
                                   background: Color.white,
                                   foreground: .black)
                }
                .padding()
                
                .sheet(isPresented: $showImagePicker,
                       onDismiss: {
                    if selectedImage == nil {
                        dismiss()
                    }
                }) {
                    ImagePicker(selectedImage: self.$selectedImage)
                }
                
                Spacer()
            }
            .popup(isPresented: $editProfileViewModel.showAlert) {
                FLToastAlert(image: .constant(""),
                             message: $editProfileViewModel.alertMessage)
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
            
            .onChange(of: editProfileViewModel.isSucces) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        dismiss()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

#Preview {
    EditProfile()
}
