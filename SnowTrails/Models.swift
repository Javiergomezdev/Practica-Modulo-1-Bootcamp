//
//  main.swift
//  SnowTrails
//
//  Created by Javier Gomez on 6/2/25.
//

import Foundation

public struct GeoPoint {
    let name: String
    let latitude: Double
    let longitude: Double
    let elevation: Double
   
}
struct Route {
    let name: String
    var points: [GeoPoint] = []
}

enum UserRole: String {
    case admin             // usuario de prueba: Adminuserkeepcodinf1 Email: adminuser@keepcoding.es
    case regular              // usuario de prueba: Regularuserkeepcoding1 Email: regularuser@keepcoding.es
}
// sino es ninguno de estos casos o coincidiendo con los datos debe sacar error
public struct User {
    let name: String
    let role: UserRole
    let email: String
    let password: String
    
}
