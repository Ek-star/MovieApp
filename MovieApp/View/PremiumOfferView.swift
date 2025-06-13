//
//  PremiumOfferView.swift
//  MovieApp
//
//  Created by EKALMA TOTO ALLOY SEMBIRING on 05/06/25.
//

import SwiftUI

struct PremiumOfferView: View {
    let title: String
    let subtitle: String
    let bulletPoints: [String]
    let tagColor: Color
    let titleColor: Color
    let iconcolor: Color
    let imageColor: Color
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Tag Offer
            HStack {
                Text("2 months offer")
                    .font(.custom("Poppins-SemiBold", size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(tagColor)
                    .cornerRadius(10)
                Spacer()
            }
            
            HStack(spacing: 6) {
                Image(systemName: "fireworks")
                    .foregroundColor(imageColor)
                Text("Premium")
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundColor(.white)
            }
            
            Text(title)
                .font(.custom("Poppins-Semibold", size: 20))
                .fontWeight(.bold)
                .foregroundColor(titleColor)
            VStack(alignment: .leading, spacing: 6) {
                ForEach(bulletPoints, id: \.self) { point in
                    HStack(alignment: .top) {
                        Text("•")
                        Text(point)
                    }
                    .foregroundColor(.white)
                    .font(.custom("Poppins-Medium", size: 12))
                }
            }
            
            Text("*You can’t upgrade to Premium in the app. We know, it’s not ideal.")
                .font(.custom("Poppins-Bold", size: 8))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .frame(minWidth: 330)
        .padding()
        .background(Color(red: 30/255, green: 30/255, blue: 30/255))
        .cornerRadius(20)
        .padding(.horizontal)
        
    }
}

#Preview {
    PremiumOfferView(
        title: "Duo",
        subtitle: "",
        bulletPoints: [
            "2 Premium accounts",
            "Cancel anytime",
            "Subscribe or one-time payment"
        ],
        tagColor: Color(red: 156/255, green: 18/255, blue: 77/255),
        titleColor: Color(red: 156/255, green: 18/255, blue: 77/255),
        iconcolor: Color(red: 156/255, green: 18/255, blue: 77/255),
        imageColor: Color(red: 156/255, green: 18/255, blue: 77/255)
        
    )
}
