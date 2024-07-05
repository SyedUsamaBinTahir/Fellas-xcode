//
//  SubscribeView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI
import ExytePopupView
import StoreKit

struct SubscribeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectToTabbarView = false
    @State private var products: [Product] = []
    let productIds = ["yearly_subscriptions", "monthly_subcriptions"]
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    AuthHeaderView(step: .constant("STEP 5 OF 5"))
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        SubscribeLablesView()
                        
                        SubscribeTermsAndConditionsView()
                        
                        VStack(spacing: 20) {
                            ForEach(self.products) { product in
                                SubscribeFieldAndButtonView(monthlyPrice: "\(product.displayPrice) / \(product.displayName)") {
                                    Task {
                                        do {
                                            try await self.purchase(product)
                                        } catch {
                                            print(error)
                                        }
                                    }
                                }
                            }
                            
                            SubscribeDiscountLableView()
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    
                    Spacer()
                }
//                .onAppear {
//                    viewModel.showLoader = true
//                    viewModel.getStripePaymentPrices()
//                }
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
                
                NavigationLink(isActive: $redirectToTabbarView) {
                    Tabbar().navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }

            }
            .task {
                do {
                    try await self.loadProducts()
                } catch {
                    print(error)
                }
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
    
    private func loadProducts() async throws {
        self.products = try await Product.products(for: productIds)
    }
    
    private func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        switch result {
        case let .success(.verified(transaction)):
            // Successful purhcase
            await transaction.finish()
            
            FLUserJourney.shared.subscribedUserLoggedin()
            redirectToTabbarView = true
        case let .success(.unverified(_, error)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            break
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            break
        case .userCancelled:
            // ^^^
            break
        @unknown default:
            break
        }
    }
}

//public enum PurchaseResult {
//    case success(VerificationResult<Transaction>)
//    case userCancelled
//    case pending
//}
//
//public enum VerificationResult<SignedType> {
//    case unverified(SignedType, VerificationResult<SignedType>.VerificationError)
//    case verified(SignedType)
//}

#Preview {
    SubscribeView()
}
