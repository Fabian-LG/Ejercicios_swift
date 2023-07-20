//
//  ItemView.swift
//  Food App
//
//  Created by Fabián Alejandro López García on 19/09/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    var item: Itm
    var body: some View {
        
        VStack{
            //Downloading Image From Web...
            
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:UIScreen.main.bounds.width - 30, height: 250)
            
            
            HStack(spacing: 8){
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                //Ratings View...
                
                ForEach(1...5, id: \.self){index in
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_rating) ?? 0 ?
                            .pink : .gray)
                }
                
            }
            
            HStack{
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}
