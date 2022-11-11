//
//  FoodtruckView.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-11-03.
//

import SwiftUI

struct FoodtruckView: View {
    @EnvironmentObject var dbConnection: DatabaseConnection
    var foodtruck: Foodtruck

    @State var showPopup = false
    @State var rating = 0
    
    var body: some View {
        
        ZStack() {
            
            Color(.white).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: foodtruck.image), content: {
                        image in
                        
                        image.resizable().overlay(alignment: .bottomLeading, content: {
                            HStack {
                                Text(foodtruck.title).bold().font(.title).foregroundColor(.white)
                                
                                
                            }.padding()
                        })
                        
                    }, placeholder: {
                        Text("Loading...").foregroundColor(.white)
                        
                    }).frame(height: 280)
                    
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        
                        Text(foodtruck.openingHours).font(.system(.subheadline, design: .monospaced, weight: .thin))
                        
                        Text(foodtruck.title).bold().font(.title).foregroundColor(.mint)
                        
                        Text(foodtruck.description)
                        
                        HStack {
                            Text("Recensioner").bold().font(.title).foregroundColor(.mint)
                            Spacer()
                            Button(action: {
                                showPopup.toggle()
                            }, label: {
                                Text("Lägg till recension").bold()
                                    .frame(width: 157, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .fill(LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottomTrailing))
                                    ).foregroundColor(.white)
                                    .padding()
                            })
                        }
                        
                        ForEach(foodtruck.reviews) { review in
                            
                            VStack(alignment: .leading, spacing: 5) {

                                    Text(review.reviewTitle).bold().foregroundColor(.mint)
                                HStack {
                                    Text("Rating: ").foregroundColor(.mint).font(.system(.subheadline, design: .monospaced, weight: .thin))
                                    
                                    RatingsComponent(rating: review.rating)}
                                
                                Text(review.reviewText).font(.caption).fontDesign(.monospaced)
                                

                                
                                }.padding(.vertical)
                            }
                            
                            
                            
                        }.padding()
                        
                    }
                }.ignoresSafeArea().blur(radius: showPopup ? 2 : 0)
            }
            
            
            if showPopup {
                PopupView(foodtruckId: foodtruck.id, showPopup: $showPopup)
            }
            
            
        }

    }


struct FoodtruckView_Previews: PreviewProvider {
    static var previews: some View {
        
        FoodtruckView(foodtruck: Foodtruck(id: "1", title: "Asian Mix 08", description: "Japansk/Peruansk Foodtruck: allt från klassisk mat till den moderna: sushi, yakiniku, bibim bap, poke bowls m.m", image: "https://files.builder.misssite.com/51/28/51282ae9-2f3d-4ee9-9836-3c9556a57268.jpg", coordinates: Coordinates(latitude: 15.0, longitude: 9.0), openingHours: "Öppet alla dagar mellan kl. 9-16",  reviews: [Review]()))
    }
}


