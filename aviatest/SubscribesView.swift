//
//  SubscribesView.swift
//  aviatest
//
//  Created by Федор Шашков on 31.05.2024.
//

import SwiftUI

struct SubscribesView: View {
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
    }
}

struct SubscribesView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribesView()
    }
}
