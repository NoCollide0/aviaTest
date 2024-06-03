//
//  DestinationSelectionView.swift
//  aviatest
//
//  Created by Федор Шашков on 31.05.2024.
//

import SwiftUI

struct DestinationSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDestination: String
    @Binding var startTextField: String
    @Binding var destinationСhoused: Bool
    @FocusState private var isFocused: Bool
    @State private var showEmptyScreen = false
    
    @StateObject var viewModel = TicketsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 26) {
                    VStack(spacing: 14) { //Верхний элемент с выбором отправления прибытия
                        HStack(spacing: 8) {
                            Image("plane_icon")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color(red: 159/255, green: 159/255, blue: 159/255, opacity: 1.0))
                                .frame(width: 20, height: 14)
                            Text(startTextField)
                                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        Divider()
                            .background(Color(red: 62/255, green: 63/255, blue: 67/255))
                        HStack(spacing: 12) {
                            Image("search_icon")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color.white)
                                .frame(width: 16, height: 16)
                            TextField("Куда - Турция", text: $selectedDestination)
                                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                .foregroundColor(Color.white)
                                .focused($isFocused)
                                .colorScheme(.dark)
                                .keyboardType(.default)
                                .autocorrectionDisabled(true)
                                .environment(\.locale, Locale(identifier: "ru"))
                                .onChange(of: selectedDestination) { text in
                                     selectedDestination = viewModel.filterText(text)
                                 }
                                .onSubmit {
                                     self.presentationMode.wrappedValue.dismiss()
                                    if !selectedDestination.trimmingCharacters(in: .whitespaces).isEmpty {
                                        destinationСhoused = true
                                    }
                                 }
                            Spacer()
                            Button(action: {
                                self.selectedDestination = ""
                            }) {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Image("cancel_icon")
                                            .resizable(resizingMode:.stretch)
                                            .foregroundColor(Color(red: 159/255, green: 159/255, blue: 159/255, opacity: 1.0))
                                            .frame(width: 9, height: 9)
                                    )
                            }
                            .padding(.trailing, 6)
                            
                            
                        }
                    }
                    .padding(.horizontal, 16.0)
                    .frame(width: geometry.size.width - 32, height: 96)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(red: 42/255, green: 48/255, blue: 53/255))
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    )

                    HStack { //4 горизонтальных кнопки
                        DestinationButton(imageName: "destination1", text: "Сложный маршрут") {
                            showEmptyScreen = true
                        }
                        Spacer()
                        DestinationButton(imageName: "destination2", text: "Куда угодно") {
                            selectedDestination = "Куда угодно"
                            destinationСhoused = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                        DestinationButton(imageName: "destination3", text: "Выходные") {
                            showEmptyScreen = true
                        }
                        
                        Spacer()
                        DestinationButton(imageName: "destination4", text: "Горячие билеты") {
                            showEmptyScreen = true
                        }
                    }
                    .frame(width: geometry.size.width - 32, height: 90)
                    
                    VStack(spacing: 8) { //3 кнопки с городами ниже
                        CityDestinationButton(imageName: "stambul", city: "Стамбул") {
                            selectedDestination = "Стамбул"
                            destinationСhoused = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .frame(height: 56)
                        CityDestinationButton(imageName: "sochi", city: "Сочи") {
                            selectedDestination = "Сочи"
                            destinationСhoused = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .frame(height: 56)
                        CityDestinationButton(imageName: "phuket", city: "Пхукет") {
                            selectedDestination = "Пхукет"
                            destinationСhoused = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .frame(height: 56)
                    }
                    .padding(16.0)
                    .frame(width: geometry.size.width - 32, height: 216)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(red: 47/255, green: 48/255, blue: 53/255))
                    )
                    
                    NavigationLink(destination: DestinationEmptyScreen(), isActive: $showEmptyScreen) {
                    }
                    
                    Spacer()
                }
                .ignoresSafeArea()
                .navigationBarHidden(true) 
                .padding(.top, 25.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 36/255, green: 37/255, blue: 41/255).edgesIgnoringSafeArea(.all))
            }
        }
    }
}

struct DestinationButton: View {
    let imageName: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                Image(imageName)
                    .resizable(resizingMode: .stretch)
                    .frame(width: 48, height: 48)
                Text(text)
                    .fontWeight(.semibold)
                    .frame(width: 80, height: 35)
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(16.8 - 14)
            }
        }
    }
}

struct CityDestinationButton: View {
    let imageName: String
    let city: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                HStack(spacing: 8) {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(city)
                            .font(.custom("SF Pro Display", size: 16).weight(.semibold))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(19.2 - 16)
                        Text("Популярное направление")
                            .font(.custom("SF Pro Display", size: 14).weight(.semibold))
                            .foregroundColor(Color(red: 94/255, green: 95/255, blue: 97/255))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(16.8 - 14)
                        
                    }
                    Spacer()
                }
                Divider()
                    .background(Color(red: 62/255, green: 63/255, blue: 67/255))
            }
        }
    }
}

struct DestinationEmptyScreen: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Заглушка")
                .font(.custom("SF Pro Display", size: 22))
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                .lineSpacing(26.4 - 22)
            Spacer()
            Divider()
                .background(Color(red: 29/255, green: 30/255, blue: 32/255))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 12/255, green: 12/255, blue: 12/255))
        .ignoresSafeArea()
        
        
    }
}




struct DestinationSelectionView_Previews: PreviewProvider {
    @State static var selectedDestination = "Турция"
    @State static var startTextField = "Москва"
    @State static var destinationСhoused = false
    static var previews: some View {
        DestinationSelectionView(selectedDestination: $selectedDestination, startTextField: $startTextField, destinationСhoused: $destinationСhoused)
    }
}
