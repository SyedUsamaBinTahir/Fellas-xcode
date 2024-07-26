//
//  DropDownPicker.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/07/2024.
//

import SwiftUI

enum DropDownPickerState {
    case top
    case bottom
}

struct DropDownTest: View {
    @State var selection1: String? = nil
    
    var body: some View {
        DropDownPicker(
            selection: $selection1
//            ,
//            options: [
//                "Apple",
//                "Google",
//                "Amazon",
//                "Facebook",
//                "Instagram"
//            ]
            ,
            deleteAction: .constant {
                
            }, editAction: .constant {
                
            }, report: .constant{
                
            }, outSideTap: .constant(false)
        )
    }
}

#Preview {
    DropDownTest()
}

struct DropDownPicker: View {
    @Binding var selection: String?
    var state: DropDownPickerState = .bottom
//    var options: [String]
    var maxWidth: CGFloat = 80
    @State var showDropdown = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    @Binding var deleteAction: () -> Void
    @Binding var editAction: () -> Void
    @Binding var report: () -> Void
    @Binding var outSideTap: Bool
    
    var body: some View {
        GeometryReader { reader in
            let size = reader.size
            VStack(alignment: .leading, spacing: 0) {
                if state == .top && showDropdown {
                    OptionsView()
                }
                HStack {
//                    Text(selection == nil ? "Select" : selection!)
//                        .foregroundColor(selection != nil ? .black : .gray)
//                    Spacer(minLength: 0)
                    Spacer()
                    Image("threedots-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                }
//                .padding(.horizontal, 15)
                .frame(width: 85, height: 20)
                //        .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showDropdown.toggle()
                    }
                }
                .zIndex(10)
                if state == .bottom && showDropdown {
                    OptionsView()
                }
            }
            .clipped()
//            .background(showDropdown ? Color.black : Color.clear)
//            .overlay {
//                if showDropdown{
//                    withAnimation(.snappy) {
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(.gray)
//                    }
//                }
//            }
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
        }
        .frame(width: maxWidth, height: 50)
        .zIndex(zindex)
        .onChange(of: outSideTap, perform: {newValue in
                showDropdown = false
        })
    }
    
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ScrollView {
//                ForEach(options, id: \.self) { option in
                    VStack {
                        
                        Button(action: {
                            withAnimation(.snappy) {
                                showDropdown.toggle()
                            }
                            deleteAction()
                        }) {
                            Text("Delete")
                                .font(.custom(Font.Medium, size: 12))
                                .foregroundColor(.white)
                                .animation(.none, value: selection)
                                .frame(height: 15)
                                .contentShape(.rect)
                                .padding(.horizontal, 15)
//                                .onTapGesture {
//                                    withAnimation(.snappy) {
//                                        selection = option
//                                        
//                                    }
//                                }
                        }
                        
                        Divider()
                            .background(.white)
                        
                        Button(action: {
                            withAnimation(.snappy) {
                                showDropdown.toggle()
                            }
                            editAction()
                        }) {
                            Text("Edit")
                                .font(.custom(Font.Medium, size: 12))
                                .foregroundColor(.white)
                                .animation(.none, value: selection)
                                .frame(height: 15)
                                .contentShape(.rect)
                                .padding(.horizontal, 15)
//                                .onTapGesture {
//                                    withAnimation(.snappy) {
//                                        selection = option
//                                        
//                                    }
//                                }
                        }
                        
                        Divider()
                            .background(.white)
                        
                        Button(action: {
                            withAnimation(.snappy) {
                                showDropdown.toggle()
                            }
                            report()
                        }) {
                            Text("Report")
                                .font(.custom(Font.Medium, size: 12))
                                .foregroundColor(.white)
                                .animation(.none, value: selection)
                                .frame(height: 15)
                                .contentShape(.rect)
                                .padding(.horizontal, 15)
//                                .onTapGesture {
//                                    withAnimation(.snappy) {
//                                        selection = option
//                                        
//                                    }
//                                }
                        }
                        
                        Divider()
                            .background(.white)
                        
//                        HStack {
//                            Text(option)
//                                .font(.custom(Font.Medium, size: 12))
////                            Spacer()
////                            Image(systemName: "checkmark")
////                                .opacity(selection == option ? 1 : 0)
//                        }
////                        .foregroundStyle(selection == option ? Color.primary : Color.gray)
//                        .foregroundColor(.white)
//                        .animation(.none, value: selection)
//                        .frame(height: 15)
//                        .contentShape(.rect)
//                        .padding(.horizontal, 15)
//                        .onTapGesture {
//                            withAnimation(.snappy) {
//                                selection = option
//                                showDropdown.toggle()
//                            }
//                        }
                    }
//                    Divider()
//                        .background(.black)
//                }
            }
            .frame(height: 80)
            .transition(.move(edge: state == .top ? .bottom : .top))
            .zIndex(1)
        }
    }
}
