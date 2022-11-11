//
//  FoodtruckMapView.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-11-04.
//

import SwiftUI
import MapKit

struct FoodtruckMapView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @Binding var viewOnMap: Bool
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.325300386430435, longitude: 18.06622395719864), span: MKCoordinateSpan(latitudeDelta: 0.30, longitudeDelta: 0.25))
    
    @State var selectedFoodtruck: Foodtruck?
    
    
    
    var body: some View {
        
        Map(coordinateRegion: $region, annotationItems: dbConnection.foodtruckList) {
            foodtruck in
            
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: foodtruck.coordinates.latitude, longitude: foodtruck.coordinates.longitude), content: {
                Button(action: {
                    selectedFoodtruck = foodtruck
                }, label: {
                    VStack {
                        
                        ZStack {
                            Image("foodtruckLogo").resizable()
                                .frame(width: 32.0, height: 32.0)
                        }
                        
                        Text(foodtruck.title).bold().foregroundColor(.black)
                    }
                })
                
            })
            
        }.ignoresSafeArea().onTapGesture {
            selectedFoodtruck = nil
        }.overlay(alignment: .bottom, content: {
            
            VStack  {
                if let selectedFoodtruck = selectedFoodtruck {
                    
                    NavigationLink(destination: FoodtruckView(foodtruck: selectedFoodtruck), label: {
                        FoodtruckCardView(foodtruck: selectedFoodtruck).padding()
                    })
                    
                }
                HStack{
                    Button(action: {
                        viewOnMap.toggle()
                    }, label: {
                        Text("Se lista").padding().bold()
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
                }}
            
        }
                  
        )}
}


struct FoodtruckMapView_Previews: PreviewProvider {
    static var previews: some View {
        FoodtruckMapView(viewOnMap: .constant(true)).environmentObject(DatabaseConnection())
    }
}
