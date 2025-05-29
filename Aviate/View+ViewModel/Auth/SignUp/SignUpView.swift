//
//  SignUpView.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI

struct SignUpView: View {
    
    //MARK: - PROPERTEIS
    @EnvironmentObject var appManager: AppManager
    @StateObject private var vm = SignUpVM()
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                NavigationBarView(title: "Sign Up") {}
                    .padding(.horizontal, 16)
                
                GeometryReader { geo in
                    ScrollView {
                        VStack(spacing: 16) {
                            TextField("Enter your email", text: $vm.email)
                                .customTFStyle(with: vm.email)
                                .keyboardType(.emailAddress)
                            
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
                            
                            
                            CommonButtonView(title: "Register") {
                                Task {
                                    await signUp()
                                }
                            }
                            .padding(.top, 24)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                Text("Already have an account? ")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.black)
                                
                                Button(action: {
                                    appManager.navigate(to: .login)
                                }, label: {
                                    Text("Sign In")
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

extension SignUpView {
    
    private func signUp() async {
        vm.startLoading()
        do {
            try await vm.signUp()
            self.appManager.navigate(to: .airlines)
        } catch {
            vm.handleErrorAndShowAlert(error: error)
        }
        vm.stopLoading()
    }
    
}

#Preview {
    SignUpView()
}
