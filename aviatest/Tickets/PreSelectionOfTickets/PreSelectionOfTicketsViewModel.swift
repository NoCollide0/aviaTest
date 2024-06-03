//
//  PreSelectionOfTicketsViewModel.swift
//  aviatest
//
//  Created by Федор Шашков on 03.06.2024.
//

import Foundation
import Combine

class PreSelectionOfTicketsViewModel: ObservableObject {
    
    @Published var selectedReturnTicketDate: Date? = nil
    @Published var selectedDate = Date()
    @Published var directTicketsOffers: [DirectTicket] = []
    @Published var toTicketSelectView = false
    private var cancellable: AnyCancellable?
    
    
    func filterText(_ text: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ ")
        return String(text.unicodeScalars.filter { allowedCharacters.contains($0) })
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMM"
        return formatter
    }()

    let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    func loadDirectTicketsOffers() {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else {
            print("Invalid URL")
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: DirectTicketsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.directTicketsOffers = response.tickets_offers
            })
    }

    
    
}
