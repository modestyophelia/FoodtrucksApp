//
//  ContentView.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-10-28.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var body: some View {

        if dbConnection.userLoggedIn {
            NavigationStack {
                FoodtruckListView()
            }
            
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DatabaseConnection())
    }
}
