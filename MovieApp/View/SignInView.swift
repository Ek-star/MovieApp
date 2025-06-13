//
//  SignInView.swift
//  MovieApp
//
//  Created by EKALMA TOTO ALLOY SEMBIRING on 05/06/25.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))

                VStack(alignment: .leading, spacing: 20) {
                    Spacer().frame(height: 60)

                    // Logo Title
                    HStack(spacing: 0) {
                        Text("Movie")
                            .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                        Text("s")
                            .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                            .foregroundColor(Color(red: 222/255, green: 103/255, blue: 103/255))
                            .shadow(radius: 2)
                    }

                    Text("Login to your Account")
                        .font(.custom("Poppins-Medium", size: 20))
                        .foregroundColor(.white)

                    Group {
                        TextField("Email", text: $email)
                            .font(.custom("Poppins-Medium", size: 18))
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .foregroundColor(.white)

                        SecureField("Password", text: $password)
                            .font(.custom("Poppins-Medium", size: 18))
                            .foregroundColor(.white)
                    }
                    .padding(12)
                    .background(Color(red: 222/255, green: 103/255, blue: 103/255))
                    .cornerRadius(15)
                    .foregroundColor(.black)

                    Spacer()

                    Button(action: handleSignIn) {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 45/255, green: 45/255, blue: 45/255))
                            .cornerRadius(15)
                    }
                    .padding(.bottom, 60)

                    NavigationLink(destination: MovieListView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    // MARK: - Firebase Sign In Logic
    func handleSignIn() {
        guard !email.isEmpty else {
            alertMessage = "Email is required."
            showAlert = true
            return
        }

        guard !password.isEmpty else {
            alertMessage = "Password is required."
            showAlert = true
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                return
            }

            DispatchQueue.main.async {
                self.navigateToHome = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
