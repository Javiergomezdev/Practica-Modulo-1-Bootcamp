//
//  UserService.swift
//  SnowTrails
//
//  Created by Javier Gomez on 6/2/25.
//
import Foundation

public class UserService {
    
    var users: [User] = []
    init() {
        loadDefaultUsers( )
    }
    private func loadDefaultUsers() {
        let admin = User(name: "Admin",
                         role: .admin,
                         email: "adminuser@keepcoding.es",
                         password: "admin")
        
        let user1 = User(name: "Regular User",
                         role: .regular,
                         email: "regularuser@keepcoding.es",
                         password: "regular")
        
        users.append(admin)
        
        users.append(user1)
    }
    
    // funcion para buscar al usuario
    func findUser(ByEmail email: String) -> User? {
        return users.first { $0.email == email }
    }
    
    //funcion añadir usuario
    func addUser(name: String, role: UserRole = .regular, email: String, password: String) -> User?{
        guard isValidEmail(email) else {
            MessagePrinter().printDeveloperMessage("Email no válido debe de tener formato correcto.", level: .error)
            MessagePrinter().printUserMessage("Email no válido debe de tener formato correcto.")
            return nil
        }
        let newUser = User(name: name, role: .regular, email: email, password: password)
        users.append(newUser)
        MessagePrinter().printUserMessage("Usuario añadido correctamente.")
        MessagePrinter().printDeveloperMessage( "Usuario añadido correctamente.", level: .info)
        return newUser
        }
        // funcion para comprobar que el email al menos tiene una @
        func isValidEmail(_ email: String) -> Bool {
            return email.contains("@")
        }
        //funcion para eliminar usuarios (eliminara a todos con el mismo nombre)
        func removeUser(withName name: String) -> Int {
            let initialCount = users.count
            users.removeAll { $0.name == name }
            return initialCount - users.count
        }
        // funcion para devolver los usuariosd
        func getAllUsers() -> [User] {
            return users
        }
    }

