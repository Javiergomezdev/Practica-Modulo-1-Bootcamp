//
//  UserService.swift
//  SnowTrails
//
//  Created by Javier Gomez on 6/2/25.
//

class UserService {
    
    private var users: [User] = []
    init() {
        LoadDefaultUsers( )
    }
    
    private func LoadDefaultUsers() {
        let admin = User(id: "Adminuserkeepcodinf1",
                         email: "adminuser@keepcoding.es",
                         password: "admin",
                         role: UserRole.admin)
        
        let user1 = User(id: "Regularuserkeepcoding1",
                         email: "regularuser@keepcoding.es",
                         password: "regular",
                         role: UserRole.user)
        
        users.append(admin)
        users.append(user1)
    }
    
    // funcion para buscar al usuario
    func findUserByEmail(_ email: String) -> User? {
        return users.first { $0.email == email }
    }
    
    //funcion añadir usuario
    func addUser(_ user: User) {
        let newUser = User(name: String, role: UserRole, email: String, password: String)
        users.append(newUser)
    } return newUser
    
    //funcion para eliminar usuarios (eliminara a todos con el mismo nombre)
    func removeUser(withName name: String) {
        users.removeAll { $0.name == name }
    }
    // funcion para devolver los usuariosd
    func getAllUsers() -> [User] {
        return users
    }
}
