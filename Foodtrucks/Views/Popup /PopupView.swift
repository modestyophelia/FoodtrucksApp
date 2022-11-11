//
//  PopupView.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-11-03.
//

import SwiftUI

struct PopupView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var reviewTitle = ""
    @State var reviewText = ""
    @State var rating: Int = 0
    
    @State var selected: Int = -1
    
    var foodtruckId: String
    
    @Binding var showPopup: Bool
    
    func submitReview() {
        if reviewTitle == "" || reviewText == "" {
            print("No empty fields allowed!")
            return
        }
        
        let newReview = Review(id: UUID().uuidString, rating: rating, reviewTitle: reviewTitle, reviewText: reviewText)
        
        dbConnection.addReviewToFoodtruck(foodtruckId: foodtruckId, review: newReview)
        
        showPopup.toggle()
    }
    
    
    var body: some View {
        
        ZStack() {
            
            Color(.systemGray6)
            
            
            VStack {
                Spacer()
                Text("Skriv en recension").bold().font(.title).foregroundColor(.mint)
                
                VStack(alignment: .leading) {
                    Text("Titel").bold().foregroundColor(.mint)
                    TextField("", text: $reviewTitle)
                    
                    Text("Text").bold().foregroundColor(.mint)
                    TextField("", text: $reviewText)
                }.padding().textFieldStyle(.roundedBorder)
                
                HStack {
                    ForEach(1..<6) { rating in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(self.selected >= rating ? .yellow : .gray)
                            .onTapGesture {
                                self.selected = rating
                                print(rating)
                            }
                    }
                }
                
                Button(action: submitReview, label: {
                    Text("Lägg till").padding().bold()
                        .frame(width: 110, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottomTrailing))
                        ).foregroundColor(.white)
                }).frame(height: 55)
                
                Button(action: {
                    showPopup.toggle()
                }, label: {
                    Text("Avbryt").bold().foregroundColor(.gray).padding(.vertical)
                })
                
                
                
                
            }
            
            
        }.frame(width: 300, height: 400).cornerRadius(9)
        
        
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(foodtruckId: "hej", showPopup: .constant(true))
    }
}
