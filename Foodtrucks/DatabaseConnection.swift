//
//  DatabaseConnection.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-10-30.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class DatabaseConnection: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var foodtruckList = [Foodtruck]()
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    
    var foodtruckListener: ListenerRegistration?
    
    var foodtruckCollection = "Foodtrucks"
    
    init() {
        
        Auth.auth().addStateDidChangeListener {
            auth, user in
            
            if let user = user {
                
                self.userLoggedIn = true
                self.currentUser = user
                self.startListeningToFoodtrucks()
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                self.stopListeningToFoodtrucks()
            }
        }
    }
    
    
    func stopListeningToFoodtrucks() {
        if let foodtruckListener = foodtruckListener {
            foodtruckListener.remove()
        }
        
        foodtruckListener = nil
    }
    
    
    func startListeningToFoodtrucks() {
        
        foodtruckListener = db.collection(foodtruckCollection).addSnapshotListener {
            snapshot, error in
            
            if let error = error {
                print("Error fetching foodtrucks, \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Error fetching foodtrucks. Unknown error!")
                return
            }
            
            self.foodtruckList = []
            
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: Foodtruck.self)
                }
                
                switch result {
                case .success(let foodtruck):
                    self.foodtruckList.append(foodtruck)
                    break
                case .failure(let error):
                    print("Error fetching foodtruck: \(error.localizedDescription)")
                    print("Error fetching foodtruck: ", error)
                    break
                }
                
            }
            
        }
        
    }
    
    func LogInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print("Error logging in: \(error)")
            }
            
        }
    }
    
    func LogOffUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out!")
        }
    }
    
    func RegisterUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addReviewToFoodtruck(foodtruckId: String, review: Review) {
        
        do {
            try db.collection(foodtruckCollection).document(foodtruckId).updateData(["reviews": FieldValue.arrayUnion([Firestore.Encoder().encode(review)])])
        } catch {
            print("Error adding review!")
        }
        
    }
    
    
}
