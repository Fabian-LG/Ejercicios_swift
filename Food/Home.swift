//
//  Home.swift
//  Food App
//
//  Created by Fabián Alejandro López García on 17/09/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        ZStack{
        VStack{
            HStack(spacing: 15){
                
                Button(action: {
                    withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                }, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.pink)
                })
                Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                    .foregroundColor(.black)
                Text(HomeModel.userAddress)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
                
                Spacer(minLength: 0)
            }.padding([.horizontal,.top])
            
            Divider()
            
            HStack(spacing: 15){
                TextField("Search", text: $HomeModel.search)
                
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                /*if HomeModel.search != ""{
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                    })
                    .animation(Animation.easeIn)
                }
                 */
            }.padding(.horizontal)
                .padding(.top, 10)
            
            Divider()
            
            if HomeModel.items.isEmpty{
                Spacer()
                ProgressView()
                Spacer()
            } else{
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 25){
                        
                        ForEach(HomeModel.filteredItems){item in
                            //Item View...
                            
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                ItemView(item: item)
                                
                                HStack{
                                    
                                    Text("FREE DELIVERY")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(.pink)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {
                                        HomeModel.addToCart(item: item)
                                    }, label:{
                                        Image(systemName: item.isAdded ? "checkmark" : "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(item.isAdded ? Color.green : .pink)
                                            .clipShape(Circle())
                                    })
                                }.padding(.trailing, 10)
                                    .padding(.top, 10)
                            }).frame(width:UIScreen.main.bounds.width - 30)
                            
                            //Text(item.item_name)
                           
                            
                        }
                    }.padding(.top, 10)
                })
                
            }
                
            }
            
            //Side Menu
            
            HStack{
                Menu(homeData: HomeModel)
                    //Move Effect From Left
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }.background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
            //Closing when Taps on outside
                .onTapGesture(perform: {
                    withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                })
                         )
         
            //Non Closable Alert If Permission Denied...
            
            if HomeModel.noLocation{
                Text("Please Enable Location Access In Settings To Further Move On!!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }.onAppear(perform: {
            //calling location delegate...
            HomeModel.locationManager.delegate = HomeModel
            //HomeModel.locationManager.requestWhenInUseAuthorization()
        })
        .onChange(of: HomeModel.search, perform: {
            value in
            //to avoid Continues Search requests...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if value == HomeModel.search && HomeModel.search != ""{
                    //Search Data...
                    HomeModel.filterData()
                }
            }
            if HomeModel.search == ""{
                //reset all data...
                withAnimation(.linear){HomeModel.filteredItems = HomeModel.items}
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
