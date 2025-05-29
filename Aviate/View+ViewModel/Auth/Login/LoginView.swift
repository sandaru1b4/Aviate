//
//  LoginView.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - PROPERTEIS
    @EnvironmentObject var appManager: AppManager
    @StateObject private var vm = LoginVM()
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                NavigationBarView(isShowBackButton: false, title: "Sign In") {}
                    .padding(.horizontal, 16)
                
                GeometryReader { geo in
                    ScrollView {
                        VStack(spacing: 16) {
                            
                            //email
                            TextField("Enter your email", text: $vm.email)
                                .customTFStyle(with: vm.email)
                            
                            
                            //password
                            HStack(spacing: 0) {
                                VStack {
                                    if vm.isShowPassword {
                                        TextField("Enter your password", text: $vm.password)
                                        
                                        
                                    } else {
                                        SecureField("Enter your password", text: $vm.password)
                                        
                                    }
                                }
                                
                                Button(action: {
                                    vm.isShowPassword.toggle()
                                }, label: {
                                    if !vm.isShowPassword {
                                        Image(.icVisibilityOff)
                                    } else {
                                        Image(.icVisibility)
                                    }
                                })
                                .foregroundStyle(Color.black)
                            }
                            .customTFStyle(with: vm.password)
                            
                            
                            CommonButtonView(title: "Sign In") {
                                Task {
                                    await signIn()
                                }
                            }
                            .padding(.top, 24)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                Text("Don’t have an account? ")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.black)
                                
                                Button(action: {
                                    appManager.navigate(to: .signup)
                                }, label: {
                                    Text("Sign Up")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(Color.custom(.primaryAppColor))
                                })
                            } //: HStack
                            .padding(.bottom, 15)
                        } //: VStack
                        .padding([.horizontal, .top], 16)
                        .frame(minHeight: geo.size.height)
                        
                    } //: ScrollView
                    .scrollIndicators(.hidden)
                    .frame(width: geo.size.width)
                }
            } //: VStack
            .alert(
                vm.alertTitle,
                isPresented: $vm.isShowAlert,
                actions: {
                    Button("Ok", role: .cancel) {
                    }
                },
                message: {
                    Text(vm.alertMessage)
                }
            )
            
            
        } //: ZStack
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

extension LoginView {
    private func signIn() async {
        vm.startLoading()
        do {
            try await vm.login()
            self.appManager.navigate(to: .airlines)
        } catch {
            vm.handleErrorAndShowAlert(error: error)
        }
        vm.stopLoading()
    }
    
}

#Preview {
    LoginView()
}
