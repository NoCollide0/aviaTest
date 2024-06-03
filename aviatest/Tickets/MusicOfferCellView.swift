//
//  MusicOfferCellView.swift
//  aviatest
//
//  Created by Федор Шашков on 31.05.2024.
//

import SwiftUI

struct MusicOfferCellView: View {
    let musicOffer: MusicOffer
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageName = getImageName(for: musicOffer.id) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 132, height: 132)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .clipped()
            } else {
                Spacer()
            }
            Text(musicOffer.title)
                .font(.custom("SF Pro Display", size: 16).weight(.semibold))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .lineSpacing(19.2 - 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(musicOffer.town)")
                .font(.custom("SF Pro Display", size: 14))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .lineSpacing(16.8 - 14)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Image("airplane_icon")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 17, height: 17)
                    .foregroundColor(Color(red: 159/255, green: 159/255, blue: 159/255))
                Text("от \(formatPrice(musicOffer.price.value)) ₽")
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(16.8 - 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.top, 0)
        .padding(.bottom, 5)
        .frame(width: 132, height: 213)
        .background(Color.clear)//Поменять на сlear позже
    }
    
    private func getImageName(for id: Int) -> String? {
        switch id {
        case 1:
            return "DieAntwoord"
        case 2:
            return "SocratLera"
        case 3:
            return "Lambapikt"
        default:
            return nil
        }
    }
    
    private func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
    
}

struct MusicOfferCellView_Previews: PreviewProvider {
    static var previews: some View {
        MusicOfferCellView(musicOffer: MusicOffer(id: 1, title: "Die Antwoord", town: "Будапешт", price: Price(value: 22264)))
    }
}

