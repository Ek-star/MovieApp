//
//  SubscribeView.swift
//  MovieApp
//
//  Created by EKALMA TOTO ALLOY SEMBIRING on 05/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))
                
                VStack(spacing: 32) {
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    // MARK: - Title Section
                    VStack(spacing: 12) {
                        HStack(spacing: 0) {
                            Text("Movie")
                                .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                            Text("s")
                                .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                                .foregroundColor(.primaryRed)
                                .shadow(radius: 2)
                        }
                        
                        Text("Discover the stories behind your favorite movies. Browse, read, and explore — all in one place.")
                            .font(.custom("Poppins-Medium", size: 12))
                            .foregroundColor(.grayLight)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    
                    // MARK: - Subtext
                    VStack(spacing: 4) {
                        Text("Find ")
                            .foregroundColor(.white)
                        + Text("DETAILS, EXPLORE")
                            .foregroundColor(.primaryRed)
                        + Text(" stories, and")
                            .foregroundColor(.white)
                        
                        Text("LEARN MORE")
                            .foregroundColor(.primaryRed)
                        + Text(" about the films you love")
                            .foregroundColor(.white)
                    }
                    .font(.custom("Poppins-Medium", size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    // MARK: - Buttons
                    VStack(spacing: 16) {
                        NavigationLink(destination: SubscribeView()) {
                            PrimaryButton(title: "Subscribe Now", backgroundColor: .primaryRed, foregroundColor: .white)
                        }
                        NavigationLink(destination: SignUpView()) {
                            PrimaryButton(title: "Sign Up", backgroundColor: .darkGray, foregroundColor: .white)
                        }
                        NavigationLink(destination: SignInView()) {
                            PrimaryButton(title: "Sign In", backgroundColor: .darkGray, foregroundColor: .primaryRed)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 60)
                }
            }
        }
    }
}

// MARK: - Reusable Components & Extensions

struct PrimaryButton: View {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Text(title)
            .font(.custom("Poppins-SemiBold", size: 16))
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(backgroundColor)
            .cornerRadius(16)
    }
}

extension Color {
    static let primaryRed = Color(red: 222/255, green: 103/255, blue: 103/255)
    static let darkGray = Color(red: 45/255, green: 45/255, blue: 45/255)
    static let grayLight = Color(red: 218/255, green: 218/255, blue: 218/255)
}

#Preview {
    ContentView()
}
