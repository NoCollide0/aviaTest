//
//  TicketCellView.swift
//  aviatest
//
//  Created by Федор Шашков on 03.06.2024.
//

import SwiftUI

struct TicketCellView: View {
    let ticket: Ticket
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("\(formatPrice(ticket.price.value)) ₽")
                    .font(.custom("SF Pro Display", size: 22))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .lineSpacing(26.4 - 22)
                Spacer()
            }
            HStack(spacing: 16) {
                HStack {
                    Circle()
                       .fill(Color(red: 255/255, green: 94/255, blue: 94/255))
                       .frame(width: 24, height: 24)
                    VStack {
                        HStack {
                            Text("\(formatTime(ticket.departure.date))-\(formatTime(ticket.arrival.date))")//Время вылета и время прилета
                                .font(.custom("SF Pro Display", size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .lineSpacing(16.8 - 14)
                            
                        }
                        HStack {
                            Text("\(ticket.departure.airport)    \(ticket.arrival.airport)")//Аэропорт вылета и аэропорт прилета
                                .font(.custom("SF Pro Display", size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color(red: 159/255, green: 159/255, blue: 159/255))
                                .lineSpacing(16.8 - 14)
                        }
                    }
                }
                
                VStack {
                    
                    Text("\(calculateFlightDuration(ticket.departure.date, ticket.arrival.date)) в пути" + (ticket.has_transfer ? "" : " / Без пересадок"))
                        .font(.custom("SF Pro Display", size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .lineSpacing(16.8 - 14)
                    
                    Spacer()
                }
                
            }
            
        }
        .padding(.top, 16)
        .padding(.leading, 16)
        .padding(.bottom, 23)
        .frame( height: 117)
        .background(Color(red: 29/255, green: 30/255, blue: 32/255))
        .cornerRadius(8)
        .overlay(alignment:.topLeading) {
             if let badge = ticket.badge {
                 Text(badge)
                    .font(.custom("SF Pro Display", size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .lineSpacing(16.8 - 14)
                    .frame(width: 126, height: 21)
                    .background(Color(red: 34/255, green: 97/255, blue: 188/255))
                    .cornerRadius(50)
                    .offset(x: 0, y: -8)
             }
         }
        
    }
    
    func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
    
    func formatTime(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func calculateFlightDuration(_ departureDate: String, _ arrivalDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let departure = dateFormatter.date(from: departureDate),
              let arrival = dateFormatter.date(from: arrivalDate) else {
            return ""
        }
        let duration = arrival.timeIntervalSince(departure)
        let hours = duration / 3600
        let minutes = (duration.truncatingRemainder(dividingBy: 3600)) / 60
        return String(format: "%.1fч", hours + minutes / 60)
    }
}



struct TicketCellView_Previews: PreviewProvider {
    static var previews: some View {
        TicketCellView(ticket: Ticket(id: 100, badge: "Самый удобный", price: TicketPrice(value: 1999), provider_name: "На сайте Купибилет", company: "Якутия", departure: Departure(town: "Москва", date: "2024-02-23T03:15:00", airport: "VKO"), arrival: Arrival(town: "Сочи", date: "2024-02-23T07:10:00", airport: "AER"), has_transfer: false, has_visa_transfer: false, luggage: Luggage(has_luggage: false, price: TicketPrice(value: 1082)), hand_luggage: HandLuggage(has_hand_luggage: true, size: "55x20x40"), is_returnable: false, is_exchangable: true))
    }
}
