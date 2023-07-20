//
//  OnboardingView.swift
//  Fruits
//
//  Created by Fabián Alejandro López García on 26/09/22.
//

import SwiftUI
//MARK: PROPERTIES


//MARK: BODY
struct OnboardingView: View {
    
    var fruits: [Fruit] = fruitsData
    var body: some View {
        TabView{
            ForEach(fruits[0...5]){item in
                FruitCardView(fruit: item)
            }//: LOOP
        }//: TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}


//MARK: PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(fruits: fruitsData)
    }
}
