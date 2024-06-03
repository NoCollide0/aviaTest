//
//  TicketSelectModel.swift
//  aviatest
//
//  Created by Федор Шашков on 03.06.2024.
//

import Foundation

struct TicketResponse: Decodable {
    let tickets: [Ticket]
}

struct Ticket: Decodable, Identifiable {
    let id: Int
    let badge: String?
    let price: TicketPrice
    let provider_name: String
    let company: String
    let departure: Departure
    let arrival: Arrival
    let has_transfer: Bool
    let has_visa_transfer: Bool
    let luggage: Luggage
    let hand_luggage: HandLuggage
    let is_returnable: Bool
    let is_exchangable: Bool
}

struct TicketPrice: Decodable {
    let value: Int
}

struct Departure: Decodable {
    let town: String
    let date: String
    let airport: String
}

struct Arrival: Decodable {
    let town: String
    let date: String
    let airport: String
}

struct Luggage: Decodable {
    let has_luggage: Bool
    let price: TicketPrice?
}

struct HandLuggage: Decodable {
    let has_hand_luggage: Bool
    let size: String?
}
