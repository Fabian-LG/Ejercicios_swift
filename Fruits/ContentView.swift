//
//  ContentView.swift
//  Fruits
//
//  Created by Fabián Alejandro López García on 26/09/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: PROPERTIES
    
    @State private var isShowingSettings: Bool = false
    
    var fruits: [Fruit] = fruitsData
    
    //MARK: BODY
    var body: some View {
        NavigationView{
            List{
                //ForEach(fruits.shuffled()){item in
                ForEach(fruits){item in
                    NavigationLink(destination: FruitDeteailView(fruit: item)){
                        FruitRowView(fruit: item)
                            .padding(.vertical, 4)
                    }
                    
                }
            }
            .navigationTitle("Fruits")
            .navigationBarItems(
                trailing:
                    Button(action:{
                        isShowingSettings = true
                    }){
                        Image(systemName: "slider.horizontal.3")
                    }
                    .sheet(isPresented: $isShowingSettings){
                        SettingsView()
                    }
                )
        }//: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(fruits: fruitsData)
    }
}
