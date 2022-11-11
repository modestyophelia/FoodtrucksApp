//
//  FoodtruckCardView.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-11-03.
//

import SwiftUI

struct FoodtruckCardView: View {
    
    var foodtruck: Foodtruck
    
    var body: some View {
            
        AsyncImage(url: URL(string: foodtruck.image), content: {
                image in
            
                image.resizable().overlay(alignment: .bottomLeading, content: {
                    VStack {
                        Text(foodtruck.title).bold().font(.title).foregroundColor(.white)
                    }.padding()
                })
                        
                
            }, placeholder: {
                Text("Loading...").foregroundColor(.white)
                
            }).frame(width: 325, height: 210).background(.mint).cornerRadius(9).shadow(radius: 10)
        
    }
}

struct FoodtruckCardView_Previews: PreviewProvider {
    static var previews: some View {
        FoodtruckCardView(foodtruck: Foodtruck(id: "1", title: "STHLM Lunch", description: "Description coming soon", image: "https://media-cdn.tripadvisor.com/media/photo-s/15/90/07/58/wielkie-otwarcie-food.jpg", coordinates: Coordinates(latitude: 10.0, longitude: 10.0), openingHours: "10-18", reviews: [Review(id: "1", rating: 3, reviewTitle: "Bra", reviewText: "Trevlig personal, god mat")]))
    }
}
