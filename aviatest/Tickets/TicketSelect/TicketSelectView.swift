//
//  TicketSelectView.swift
//  aviatest
//
//  Created by Федор Шашков on 03.06.2024.
//

import SwiftUI

struct TicketSelectView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = TicketSelectViewModel()
    @Binding var startTextField: String
    @Binding var endTextField: String
    @Binding var ticketDate: Date
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 26) {
                HStack(spacing: 8) {
                    Button(action: { //Кнопка возврата на предыдущий экран
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back_icon")
                            .resizable(resizingMode: .stretch)
                            .foregroundColor(Color(red: 34/255, green: 97/255, blue: 188/255))
                            .frame(width: 14, height: 12)
                    }
                    .frame(width: 24, height: 24)
                    
                    VStack(spacing: 4) {
                        HStack {
                            Text("\(startTextField)-\(endTextField)")
                                .font(.custom("SF Pro Display", size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color.white)
                                .lineSpacing(19.2 - 16)
                            
                            Spacer()
                        }
                        HStack {
                            Text("\(viewModel.dateFormatter.string(from: ticketDate)), 1 пассажир")
                                .foregroundColor(Color(red: 159/255, green: 159/255, blue: 159/255))
                                .font(.custom("SF Pro Display", size: 14))
                                .fontWeight(.regular)
                                .lineSpacing(16.8 - 14)
                            
                            Spacer()
                        }
                        
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                .frame(width: geometry.size.width - 32, height: 56)
                .background(Color(red: 36/255, green: 37/255, blue: 41/255))
                
                
                ZStack {

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(viewModel.tickets) { ticket in
                                TicketCellView(ticket: ticket)
                            }
                        }
                        .offset(y: 8)
                    }
                    
                    VStack {
                        Spacer()
                        HStack(spacing: 16) {
                            Button(action: {
                                
                            }) {
                                HStack(spacing: 4) {
                                    VStack{
                                        Image("filters_icon")
                                            .resizable(resizingMode: .stretch)
                                            .foregroundColor(Color.white)
                                            .frame(width: 12, height: 11)
                                    }
                                    .frame(width: 16, height: 16)
                                    Text("Фильтр")
                                        .foregroundColor(Color.white)
                                        .font(.custom("SF Pro Display", size: 14))
                                        .fontWeight(.regular)
                                        .lineSpacing(16.8 - 14)
                                }
                                
                            }
                            Button(action: {
                                
                            }) {
                                HStack(spacing: 4) {
                                    VStack{
                                        Image("price_icon")
                                            .resizable(resizingMode: .stretch)
                                            .foregroundColor(Color.white)
                                            .frame(width: 14, height: 13)
                                    }
                                    .frame(width: 16, height: 16)
                                    Text("График цен")
                                        .foregroundColor(Color.white)
                                        .font(.custom("SF Pro Display", size: 14))
                                        .fontWeight(.regular)
                                        .lineSpacing(16.8 - 14)
                                }
                                
                            }
                        }
                        .padding(.horizontal, 10)
                        .frame(width: 205, height: 37)
                        .background(Color(red: 34/255, green: 97/255, blue: 188/255))
                        .cornerRadius(50)
                        .offset(y: -16)
                       
                    }
                    
                }
                
                .frame(width: geometry.size.width - 32)
                
                
                
                Divider()
                    .background(Color(red: 29/255, green: 30/255, blue: 32/255))
            }
            .padding(.top, 16)
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 12/255, green: 12/255, blue: 12/255))
            .onAppear {
                self.viewModel.loadTickets()
            }
        }
        
    }
}



struct TicketSelectView_Previews: PreviewProvider {
    @State static var startTextField = "Москва"
    @State static var endTextField = "Турция"
    @State static var ticketDate = Date()
    static var previews: some View {
        TicketSelectView(startTextField: $startTextField, endTextField: $endTextField, ticketDate: $ticketDate)
    }
}
