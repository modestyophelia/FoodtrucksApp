//
//  RatingsComponent.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-11-11.
//

import SwiftUI

struct RatingsComponent: View {
    
    var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...rating, id: \.self) { number in
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
        }
    }
}

struct RatingsComponent_Previews: PreviewProvider {
    static var previews: some View {
        RatingsComponent(rating: 3)
    }
}
