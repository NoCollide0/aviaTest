//
//  PreSelectionOfTicketsModel.swift
//  aviatest
//
//  Created by Федор Шашков on 03.06.2024.
//

import Foundation

struct DirectTicketsResponse: Decodable {
    let tickets_offers: [DirectTicket]
}

struct DirectTicket: Identifiable, Decodable {
    let id: Int
    let title: String
    let time_range: [String]
    let price: DirectTicketPrice
}

struct DirectTicketPrice: Decodable {
    let value: Int
}
