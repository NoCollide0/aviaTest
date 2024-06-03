//
//  TicketsModel.swift
//  aviatest
//
//  Created by Федор Шашков on 31.05.2024.
//

import Foundation

struct MusicOffersResponse: Decodable {
    let offers: [MusicOffer]
}

struct MusicOffer: Identifiable, Decodable {
    let id: Int
    let title: String
    let town: String
    let price: Price
}

struct Price: Decodable {
    let value: Int
}
