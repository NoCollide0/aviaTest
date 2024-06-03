//
//  DirectTicketCellView.swift
//  aviatest
//
//  Created by Федор Шашков on 03.06.2024.
//

import SwiftUI

struct DirectTicketCellView: View {
    let directTicket: DirectTicket
    let index: Int
    
    var body: some View {
        Button(action: {
            
        }) {
            VStack {
                HStack(spacing: 8) {
                    VStack {
                        Circle()
                            .fill(colorForIndex(index))
                            .frame(width: 24, height: 24)
                        Spacer()
                    }
                    .padding(.top, 8)
                    
                    VStack(spacing: 4) {
                        HStack {
                            Text(directTicket.title)
                                .font(.custom("SF Pro Display", size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .lineSpacing(16.8 - 14)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text("\(formatPrice(directTicket.price.value)) ₽")
                                .font(.custom("SF Pro Display", size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color(red: 34/255, green: 97/255, blue: 188/255))
                                .lineSpacing(16.8 - 14)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing, -10)
                            VStack {
                                Image("arrow_icon")
                                    .resizable(resizingMode: .stretch)
                                    .frame(width: 6, height: 11)
                                    .foregroundColor(Color(red: 34/255, green: 97/255, blue: 188/255))
                            }
                            .frame(width: 16, height: 16)
                        }
                        HStack {
                            Text(directTicket.time_range.joined(separator: " "))
                                .font(.custom("SF Pro Display", size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .lineSpacing(16.8 - 14)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 10)
                    Spacer()
                }
                
                Divider()
                    .background(Color(red: 29/255, green: 30/255, blue: 32/255))
            }
            
            
        }
        .frame( height: 56)
        .background(Color.clear)//Поменять на clear
    }
    
    func colorForIndex(_ index: Int) -> Color {
        switch index {
        case 0:
            return Color(red: 255/255, green: 94/255, blue: 94/255)
        case 1:
            return Color(red: 34/255, green: 97/255, blue: 188/255)
        case 2:
            return Color.white
        default:
            return Color.black
        }
    }

    func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
    
}



struct DirectTicketCellView_Previews: PreviewProvider {
    static var previews: some View {
        DirectTicketCellView(directTicket: DirectTicket(id: 1, title: "Уральские авиалинии", time_range: ["07:00", "09:10", "10:00", "11:30", "14:15", "19:10", "21:00", "23:30"], price: DirectTicketPrice(value: 3999)), index: 0)
    }
}
