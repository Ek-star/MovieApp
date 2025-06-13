//
//  SubscribeView.swift
//  MovieApp
//
//  Created by EKALMA TOTO ALLOY SEMBIRING on 05/06/25.
//

import SwiftUI

import SwiftUI

struct SubscribeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack(alignment: .top) {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(Color.black.opacity(0.5))

                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.65), Color.clear]),
                        startPoint: .top,
                        endPoint: .center
                    )
                    .frame(height: 300)
                    .ignoresSafeArea()
                }

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 4) {
                                Image(systemName: "fireworks")
                                    .foregroundColor(.primaryRed_)
                                Text("Premium")
                                    .font(.custom("Poppins-Bold", size: 16))
                                    .foregroundColor(.white)
                            }
                            Text("Get More out of your story")
                                .font(.custom("Poppins-SemiBold", size: 24))
                                .foregroundColor(.white)
                                .shadow(radius: 3)

                            Text("with Premium")
                                .font(.custom("Poppins-SemiBold", size: 24))
                                .foregroundColor(.primaryRed_)
                                .shadow(radius: 3)
                        }
                        .padding(.horizontal)
                        .padding(.top, 90)

                        // Premium Options
                        VStack(spacing: 24) {
                            PremiumOfferViewInSubscribe(
                                title: "Duo",
                                bulletPoints: [
                                    "2 Premium accounts",
                                    "Cancel anytime",
                                    "Subscribe or one-time payment"
                                ],
                                accentColor: .duoColor
                            )

                            PremiumOfferViewInSubscribe(
                                title: "Student",
                                bulletPoints: [
                                    "1 verified Premium account",
                                    "Discount for eligible students",
                                    "Cancel anytime",
                                    "Subscribe or one-time payment"
                                ],
                                accentColor: .studentColor
                            )

                            PremiumOfferViewInSubscribe(
                                title: "Family",
                                bulletPoints: [
                                    "Up to 4 Premium accounts",
                                    "Control content marked as explicit",
                                    "Ability to buy 1–2 additional Premium accounts with a recurring subscription",
                                    "Cancel anytime"
                                ],
                                accentColor: .familyColor
                            )
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }

            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        }
    }
}


// MARK: - Custom View
struct PremiumOfferViewInSubscribe: View {
    let title: String
    let bulletPoints: [String]
    let accentColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack() {
                Text("2 months offer")
                    .font(.custom("Poppins-SemiBold", size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(accentColor)
                    .cornerRadius(10)
                Spacer()
            }

            // Title
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Image(systemName: "fireworks")
                        .foregroundColor(accentColor)
                    Text("Premium")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(.white)
                }

                Text(title)
                    .font(.custom("Poppins-Bold", size: 20))
                    .foregroundColor(accentColor)
            }

            // Bullets
            VStack(alignment: .leading, spacing: 8) {
                ForEach(bulletPoints, id: \.self) { point in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(accentColor)
                        Text(point)
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundColor(.white)
                    }
                }
            }

            Text("You can’t upgrade to Premium in the app. We know, it’s not ideal.")
                .font(.custom("Poppins-Regular", size: 10.2))
                .foregroundColor(Color(red: 121/255, green: 121/255, blue: 121/255))
                .padding(.top, 8)
        }
        .padding()
        .background(Color.black.opacity(0.25))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(accentColor, lineWidth: 2)
        )
    }
}


// MARK: - Custom Colors
extension Color {
    static let primaryRed_ = Color(red: 222/255, green: 103/255, blue: 103/255)
    static let duoColor = Color(red: 156/255, green: 18/255, blue: 77/255)
    static let studentColor = Color(red: 164/255, green: 134/255, blue: 21/255)
    static let familyColor = Color(red: 101/255, green: 113/255, blue: 223/255)
}


#Preview {
    SubscribeView()
}
