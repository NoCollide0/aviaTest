//
//  TicketsViewModel.swift
//  aviatest
//
//  Created by Федор Шашков on 31.05.2024.
//

import Foundation
import Combine

class TicketsViewModel: ObservableObject {
    @Published var startTextField: String = ""
    @Published var endTextField: String = ""
    @Published var destinationChoused: Bool = false
    
    @Published var musicOffers: [MusicOffer] = []
    private var cancellable: AnyCancellable?
    
    private let userDefaults = UserDefaults.standard

    init() {
        loadStartTextField()
    }

    func saveStartTextField() {
        userDefaults.set(startTextField, forKey: "startTextField")
    }

    func loadStartTextField() {
        if let savedStartTextField = userDefaults.string(forKey: "startTextField") {
            startTextField = savedStartTextField
        }
    }
    
    func filterText(_ text: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ ")
        return String(text.unicodeScalars.filter { allowedCharacters.contains($0) })
    }
    
    func loadMusicOffers() {
        guard let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd") else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MusicOffersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.musicOffers = response.offers
            })
    }
    
}
