//
//  TicketSelectViewModel.swift
//  aviatest
//
//  Created by Федор Шашков on 03.06.2024.
//

import Foundation
import Combine

class TicketSelectViewModel: ObservableObject {
    @Published var tickets: [Ticket] = []
    private var cancellable: AnyCancellable?
    
    func loadTickets() {
        guard let url = URL(string: "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf") else {
            print("Invalid URL")
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
           .map { $0.data }
           .decode(type: TicketResponse.self, decoder: JSONDecoder())
           .receive(on: DispatchQueue.main)
           .sink(receiveCompletion: { completion in
                switch completion {
                case.finished:
                    break
                case.failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.tickets = response.tickets
            })
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
    
}
