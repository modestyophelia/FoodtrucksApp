//
//  FoodtruckListView.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-11-04.
//

import SwiftUI

struct FoodtruckListView: View {
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var viewOnMap = false
    
    var body: some View {
        
        ZStack {
            ScrollView {
                Text("Foodtrucks").bold().font(.title).foregroundColor(.mint)
                
                Spacer()
                
                ForEach(dbConnection.foodtruckList) { foodtruck in
                    NavigationLink(destination: FoodtruckView(foodtruck: foodtruck), label: {
                        FoodtruckCardView(foodtruck: foodtruck)
                    })
                }
            }.overlay(alignment: .bottom, content: {
                
                HStack{
                    Button(action: {
                        viewOnMap.toggle()
                    }, label: {
                        Text("Se karta").padding().bold()
                            .frame(width: 110, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottomTrailing))
                            ).foregroundColor(.white)
                    })
                    Button(action: {
                        dbConnection.LogOffUser()
                    }, label: {
                        Text("Logga ut").padding().bold()
                            .frame(width: 110, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottomTrailing))
                            ).foregroundColor(.white)
                    })
                    
                }})
            
            if viewOnMap {
                FoodtruckMapView(viewOnMap: $viewOnMap)
            }
        }
    }
}

struct FoodtruckListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodtruckListView().environmentObject(DatabaseConnection())
    }
}
