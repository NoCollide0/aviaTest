//
//  TicketsView.swift
//  aviatest
//
//  Created by Федор Шашков on 31.05.2024.
//

import SwiftUI

struct TicketsView: View {
    @State private var showingModal = false
    @StateObject var viewModel = TicketsViewModel()
    @FocusState private var isFocused: Bool

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Text("""
                     Поиск дешевых
                     авиабилетов
                     """)
                    .font(.custom("SF Pro Display", size: 22))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .lineSpacing(26.4 - 22)
                    .multilineTextAlignment(.center)
                    .padding(.top, 58.0)
                    .padding(.bottom, 38.0)
                    
                    VStack { //Верхний элемент с выбором отправления прибытия
                        HStack {
                            Image("search_icon")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 16, height: 16)
                                .padding(.leading, 12.0)
                                .foregroundColor(Color(red: 219/255, green: 219/255, blue: 219/255, opacity: 0.62))
                            VStack(spacing: 8) {
                                TextField("Откуда - Москва", text: $viewModel.startTextField)
                                    .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                    .foregroundColor(Color.white)
                                    .colorScheme(.dark)
                                    .keyboardType(.default)
                                    .autocorrectionDisabled(true)
                                    .environment(\.locale, Locale(identifier: "ru"))
                                    .onChange(of: viewModel.startTextField) { text in
                                        viewModel.startTextField = viewModel.filterText(text)
                                        viewModel.saveStartTextField()
                                    }
                                Divider()
                                    .background(Color(red: 159/255, green: 159/255, blue: 159/255))
                                TextField("Куда - Турция", text: $viewModel.endTextField)
                                    .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                    .foregroundColor(Color.white)
                                    .focused($isFocused)
                                    .colorScheme(.dark)
                                    .keyboardType(.default)
                                    .autocorrectionDisabled(true)
                                    .environment(\.locale, Locale(identifier: "ru"))
                                    .onChange(of: viewModel.endTextField) { text in
                                        viewModel.endTextField = viewModel.filterText(text)
                                    }
                                    .onTapGesture {
                                        if viewModel.startTextField.trimmingCharacters(in: .whitespaces).isEmpty {
                                            viewModel.startTextField = "Москва"
                                        }
                                        showingModal = true
                                        isFocused = false
                                    }
                            }
                            .padding(16)
                        }
                        .frame(width: geometry.size.width - 64, height: 90)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(red: 62/255, green: 63/255, blue: 67/255))
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        )
                        
                    }
                    .frame(width: geometry.size.width - 32, height: 122)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(red: 47/255, green: 48/255, blue: 53/255))
                    )
                    
                    Text("Музыкально отлететь")
                        .font(.custom("SF Pro Display", size: 22).weight(.semibold))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 32.0)
                        .padding(.leading, 16)
                        .padding(.bottom, 26)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineSpacing(26.4 - 22)
                    
                    ScrollView(.horizontal, showsIndicators: false) { //Предложения с муз артистами
                        HStack(spacing: 20) {
                            ForEach(viewModel.musicOffers) { musicOffer in
                                MusicOfferCellView(musicOffer: musicOffer)
                                    .padding(.leading, musicOffer.id == viewModel.musicOffers.first?.id ? 16 : 0)
                                    .padding(.trailing, musicOffer.id == viewModel.musicOffers.last?.id ? 16 : 0)
                            }
                        }
                    }
                    .frame(height: 213)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.clear)
                    .onAppear {
                        self.viewModel.loadMusicOffers()
                    }
                    
                    Spacer()
                    NavigationLink(destination: PreSelectionOfTicketsView(startTextField: $viewModel.startTextField, endTextField: $viewModel.endTextField), isActive: $viewModel.destinationChoused) {
                     
                    }
                    Divider()
                        .background(Color(red: 29/255, green: 30/255, blue: 32/255))
                    
                }
                .sheet(isPresented: $showingModal) { //Модальное окно с выбором места прибытия
                    DestinationSelectionView(selectedDestination: $viewModel.endTextField, startTextField: $viewModel.startTextField, destinationСhoused: $viewModel.destinationChoused)
                }

                .onChange(of: showingModal) { newValue in
                    if !newValue {
                        isFocused = false
                    }
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 12/255, green: 12/255, blue: 12/255))
            }
        }
    }
}





struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView(viewModel: TicketsViewModel())
    }
}
