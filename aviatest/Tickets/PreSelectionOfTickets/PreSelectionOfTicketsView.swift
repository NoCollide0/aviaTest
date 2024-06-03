//
//  PreSelectionOfTicketsView.swift
//  aviatest
//
//  Created by Федор Шашков on 02.06.2024.
//

import SwiftUI

struct PreSelectionOfTicketsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var startTextField: String
    @Binding var endTextField: String
    @StateObject var viewModel = PreSelectionOfTicketsViewModel()
    @State var showReturnTicketDatePicker = false
    @State var showDatePicker = false
    
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 15) {
                    VStack(spacing: 14) { //Верхний элемент с выбором отправления прибытия
                        HStack(spacing: 8) {
                            Button(action: { //Кнопка возврата на предыдущий экран
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("back_icon")
                                    .resizable(resizingMode: .stretch)
                                    .foregroundColor(Color.white)
                                    .frame(width: 14, height: 12)
                            }
                            .frame(width: 24, height: 24)
                            VStack(spacing: 8) {
                                HStack {
                                    TextField("Откуда - Москва", text: $startTextField)
                                        .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                        .foregroundColor(Color.white)
                                        .colorScheme(.dark)
                                        .keyboardType(.default)
                                        .autocorrectionDisabled(true)
                                        .environment(\.locale, Locale(identifier: "ru"))
                                        .onChange(of: startTextField) { text in
                                            startTextField = viewModel.filterText(text)
                                        }
                                    Button(action: { //Кнопка замены отправления/прибытия
                                        var textFromFirstField: String
                                        textFromFirstField = startTextField
                                        startTextField = endTextField
                                        endTextField = textFromFirstField
                                    }) {
                                        Image("swap_icon")
                                            .resizable(resizingMode: .stretch)
                                            .foregroundColor(Color(red: 159/255, green: 159/255, blue: 159/255, opacity: 1.0))
                                            .frame(width: 12, height: 12)
                                    }
                                    .frame(width: 24, height: 24)
                                }
                                Divider()
                                    .background(Color(red: 62/255, green: 63/255, blue: 67/255))
                                HStack {
                                    TextField("Куда - Турция", text: $endTextField)
                                        .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                        .foregroundColor(Color.white)
                                        .colorScheme(.dark)
                                        .keyboardType(.default)
                                        .autocorrectionDisabled(true)
                                        .environment(\.locale, Locale(identifier: "ru"))
                                        .onChange(of: endTextField) { text in
                                            endTextField = viewModel.filterText(text)
                                        }
                                    Button(action: { //Кнопка стирающая прибытие
                                        self.endTextField = ""
                                    }) {
                                        Image("cancel_icon")
                                            .resizable(resizingMode: .stretch)
                                            .foregroundColor(Color(red: 159/255, green: 159/255, blue: 159/255, opacity: 1.0))
                                            .frame(width: 9, height: 9)
                                    }
                                    .frame(width: 24, height: 24)
                                }
                            }
                        }
                    }
                    .padding(.leading, 8.0)
                    .padding(.trailing, 16.0)
                    .frame(width: geometry.size.width - 32, height: 96) 
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(red: 42/255, green: 48/255, blue: 53/255))
                    )
                    
                    ScrollView(.horizontal, showsIndicators: false) { //Кнопки с датами билетов
                        HStack(spacing: 8) {
                            Button(action: { //Обратный билет
                                self.showReturnTicketDatePicker = true
                            }) {
                                HStack(spacing: 8) {
                                    VStack {
                                        Image("plus_icon")
                                            .resizable(resizingMode: .stretch)
                                            .foregroundColor(Color.white)
                                            .frame(width: 12, height: 12)
                                    }
                                    .frame(width: 16, height: 16)
                                    Text("обратно")
                                        .font(.custom("SF Pro Display", size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)
                                        .lineSpacing(16.8 - 14)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.horizontal, 10)
                                .frame(width: 105, height: 33)
                                .background(Color(red: 47/255, green: 48/255, blue: 53/255, opacity: 1.0))
                                .cornerRadius(50)
                            }
                            .padding(.leading, 16)
                            
                            Button(action: { //Дата билета
                                self.showDatePicker = true
                            }) {
                                HStack(spacing: 0) {
                                    Text(viewModel.dateFormatter.string(from: viewModel.selectedDate))
                                        .font(.custom("SF Pro Display", size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)
                                        .lineSpacing(16.8 - 14)
                                        .multilineTextAlignment(.leading)
                                    Text(", \(viewModel.dayOfWeekFormatter.string(from: viewModel.selectedDate))")
                                        .font(.custom("SF Pro Display", size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.gray)
                                        .lineSpacing(16.8 - 14)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.horizontal, 10)
                                .frame(height: 33)
                                .background(Color(red: 47/255, green: 48/255, blue: 53/255, opacity: 1.0))
                                .cornerRadius(50)
                            }
                            
                            Button(action: { //Класс билета и кол-во персон
                                
                            }) {
                                HStack(spacing: 8) {
                                    VStack {
                                        Image("human_icon")
                                            .resizable(resizingMode: .stretch)
                                            .foregroundColor(Color.white)
                                            .frame(width: 10, height: 10)
                                    }
                                    .frame(width: 16, height: 16)
                                    Text("1,эконом")
                                        .font(.custom("SF Pro Display", size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)
                                        .lineSpacing(16.8 - 14)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.horizontal, 10)
                                .frame(width: 104, height: 33)
                                .background(Color(red: 47/255, green: 48/255, blue: 53/255, opacity: 1.0))
                                .cornerRadius(50)
                            }
                            
                            Button(action: { //Фильтры
                                
                            }) {
                                HStack(spacing: 8) {
                                    VStack {
                                        Image("filters_icon")
                                            .resizable(resizingMode: .stretch)
                                            .foregroundColor(Color.white)
                                            .frame(width: 12, height: 11)
                                    }
                                    .frame(width: 16, height: 16)
                                    Text("Фильтры")
                                        .font(.custom("SF Pro Display", size: 14))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)
                                        .lineSpacing(16.8 - 14)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.horizontal, 14)
                                .frame(width: 115, height: 33)
                                .background(Color(red: 47/255, green: 48/255, blue: 53/255, opacity: 1.0))
                                .cornerRadius(50)
                            }
                            .padding(.trailing, 16)
                        }
                    }
                    .frame(height: 33)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.clear)

                    
                    VStack(spacing: 8) { //Прямые рельсы(рейсы)((позволил себе исправить))
                        HStack {
                            Text("Прямые рейсы")
                                .font(.custom("SF Pro Display", size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .lineSpacing(24 - 20)
                            Spacer()
                        }
                        ForEach(Array(viewModel.directTicketsOffers.prefix(3).enumerated()), id: \.element.id) { index, directTicket in
                            DirectTicketCellView(directTicket: directTicket, index: index)
                        }
                    }
                    .padding(16.0)
                    .frame(width: geometry.size.width - 32)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(red: 29/255, green: 30/255, blue: 32/255))
                    )
                    
                    Button(action: { //Кнопка для перехода в выбору билетов
                        self.viewModel.toTicketSelectView = true
                    }) {
                        VStack {
                            Text("Посмотреть все билеты")
                                .foregroundColor(Color.white)
                                .font(.custom("SF Pro Display", size: 16))
                                .fontWeight(.regular)
                                .lineSpacing(20.8 - 16)
                        }
                        .frame(width: geometry.size.width - 32, height: 42)
                        .background(Color(red: 34/255, green: 97/255, blue: 188/255, opacity: 1.0))
                        .cornerRadius(8)
                    }
                    NavigationLink(destination: TicketSelectView(startTextField: $startTextField, endTextField: $endTextField, ticketDate: $viewModel.selectedDate), isActive: $viewModel.toTicketSelectView) {
                     
                    }
                    Spacer()
                    Divider()
                        .background(Color(red: 29/255, green: 30/255, blue: 32/255))
                }
                .padding(.top, 47.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 12/255, green: 12/255, blue: 12/255))
                .navigationBarHidden(true)
                
                .sheet(isPresented: $showDatePicker) { //Модальное для кнопки обратно
                    DatePicker("", selection: Binding(
                        get: { self.viewModel.selectedDate },
                        set: { date in
                            self.viewModel.selectedDate = date
                            self.showDatePicker = false
                        }
                    ), displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .preferredColorScheme(.dark)
                }
                  
                .sheet(isPresented: $showReturnTicketDatePicker) { //Модальное для кнопки с датой билета
                    DatePicker("", selection: Binding(
                        get: { self.viewModel.selectedReturnTicketDate ?? Date() },
                        set: { date in
                            self.viewModel.selectedReturnTicketDate = date
                            self.showReturnTicketDatePicker = false
                        }
                    ), displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .preferredColorScheme(.dark)
                }
                
                .onAppear {
                    self.viewModel.loadDirectTicketsOffers()
                }
                

                
                
            }
            .navigationBarHidden(true)
        }
    }
}


                                         

                                         


struct PreSelectionOfTicketsView_Previews: PreviewProvider {
    @State static var startTextField = "Москва"
    @State static var endTextField = "Турция"
    static var previews: some View {
        PreSelectionOfTicketsView(startTextField: $startTextField, endTextField: $endTextField)
    }
}
