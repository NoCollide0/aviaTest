//
//  ContentView.swift
//  aviatest
//
//  Created by Федор Шашков on 29.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
        UITabBar.appearance().barTintColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1)
    }
    
    var body: some View {
        TabView() { //Нижнее меню и вьюхи к кнопкам на ней
            TicketsView(viewModel: TicketsViewModel())
                .tabItem {
                    Image("airplane_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 24, height: 24)
                    Text("Авиабилеты")
                        .font(.custom("SF Pro Display", size: 10))
                        .lineSpacing(11 - 10)   
                        .multilineTextAlignment(.center)
                }
            
            HotelsView()
                .tabItem {
                    Image("bed_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 24, height: 24)
                    Text("Отели")
                        .font(.custom("SF Pro Display", size: 10))
                        .lineSpacing(11 - 10)
                        .multilineTextAlignment(.center)
                }
            
            KorocheView()
                .tabItem {
                    Image("pointer_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 24, height: 24)
                    Text("Короче")
                        .font(.custom("SF Pro Display", size: 10))
                        .lineSpacing(11 - 10)
                        .multilineTextAlignment(.center)
                }
            
            SubscribesView()
                .tabItem {
                    Image("ring_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 24, height: 24)
                    Text("Подписки")
                        .font(.custom("SF Pro Display", size: 10))
                        .lineSpacing(11 - 10)
                        .multilineTextAlignment(.center)
                }
            
            CustomProfileView()
                .tabItem {
                    Image("profile_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 24, height: 24)
                    Text("Профиль")
                        .font(.custom("SF Pro Display", size: 10))
                        .lineSpacing(11 - 10)
                        .multilineTextAlignment(.center)
                }
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
