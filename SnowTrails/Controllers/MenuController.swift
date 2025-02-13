//
//  MenuController.swift
//  SnowTrails
//
//  Created by Javier Gomez on 11/02/25.
//
import Foundation

class MenuController {
    let userService: UserService
    let routesService: RoutesService
    let loginController: LoginController
    let messagePrinter: MessagePrinter
    
    init(userService: UserService, routesService: RoutesService, loginController: LoginController, messagePrinter: MessagePrinter) {
        self.userService = userService
        self.routesService = routesService
        self.loginController = loginController
        self.messagePrinter = messagePrinter
    }
    
    
    func start() {
        var isRunning = true
        messagePrinter.printDeveloperMessage("Menu de bienvenida", level: .info)
        while isRunning {
            messagePrinter.printUserMessage("Bienvenido a SnowTrails \n1. Acceder como usuario \n2. Acceder como administrador \n3. Salir")
//            let errorMessage = ("Opción inválida, intenta de nuevo.")
            guard let choice = readLine() else { continue }
            
            switch choice {
                    case "1":
                        loginController.login(
                            onSuccess: { user in
                                if user.role == .regular {
                                    showUserMenu(user: user)
                                } else {
                                    messagePrinter.printUserMessage("Este usuario es administrador. Usa la opción 2.")
                                }
                            },
                            onFailure: { errorMessage in
                                messagePrinter.printUserMessage(" \(errorMessage)")
                            }
                        )
                    case "2":
                        loginController.login(
                            onSuccess: { user in
                                if user.role == .admin {
                                    showAdminMenu(user: user)
                                } else {
                                    messagePrinter.printUserMessage("Este usuario es regular. Usa la opción 1.")
                                }
                            },
                            onFailure: { errorMessage in
                                messagePrinter.printUserMessage(" \(errorMessage)")
                            }
                        )
                    case "3":
                        isRunning = false
                        messagePrinter.printUserMessage("Saliendo de la aplicación...")
                    default:
                        messagePrinter.printUserMessage("Opción inválida, intenta de nuevo.")
                    }
                }
            }
    
    
    /// Menú para usuarios regulares.
    func showUserMenu(user: User) {
        var inUserMenu = true
        while inUserMenu {
            messagePrinter.printUserMessage("Menú usuario - Selecciona una opción: \n1. Ver todas las rutas \n2. Obtener la ruta más corta entre dos puntos \n3. Log out")
            
            guard let choice = readLine() else { continue }
            switch choice {
            case "1":
                messagePrinter.printDeveloperMessage("Listado de Rutas", level: .info)
                let routes = routesService.getAllRoutes()
                for route in routes {
                    let distance = routesService.distancePointsRoute(of: route)
                    messagePrinter.printUserMessage("\(route.name) - \(String(format: "%.2f", distance/1000)) Km")
                }
            case "2":
                messagePrinter.printDeveloperMessage( "Obtener ruta más corta no esta implementada", level: .info)
                messagePrinter.printUserMessage("La funcionalidad de obtener la ruta más corta no está implementada todavía.")
            case "3":
                inUserMenu = false
                messagePrinter.printDeveloperMessage("saliendo al menu Login", level: .info)
                messagePrinter.printUserMessage("Cerrando sesión...")
            default:
                messagePrinter.printDeveloperMessage("se ha seleccionado una opcion no permitida", level: .error)
                messagePrinter.printUserMessage("Opción inválida, intenta de nuevo.")
            }
        }
    }
    
    /// Menú para administradores.
    func showAdminMenu(user: User) {
        var inAdminMenu = true
        while inAdminMenu {
            messagePrinter.printUserMessage("Menú admin - Selecciona una opción: \n1. Ver todos los usuarios \n2. Añadir usuario \n3. Eliminar usuario \n4. Añadir punto a una ruta \n5. Logout")
            
            guard let choice = readLine() else { continue }
            switch choice {
            case "1":
                let users = userService.getAllUsers()
                for user in users {
                    let roleText = user.role == UserRole.admin ? "Admin" : "Regular user"
                    messagePrinter.printDeveloperMessage("Se muestra usuario y su email", level: .info)
                    messagePrinter.printUserMessage("\(roleText): \(user.name) --- Email: \(user.email)")
                }
            case "2":
                messagePrinter.printDeveloperMessage("Entramos a opcion añadir usuario y se solicitan los datos", level: .info)
                messagePrinter.printUserMessage("Añadir usuario")
                messagePrinter.printUserMessage("Introduce el nombre:")
                guard let name = readLine(), !name.isEmpty else { continue }
                messagePrinter.printUserMessage("Introduce el email:")
                guard let email = readLine(), !email.isEmpty else { continue }
                messagePrinter.printUserMessage("Introduce la contraseña:")
                guard let password = readLine(), !password.isEmpty else { continue }
                if let newUser = userService.addUser( name: name, email: email, password: password ) {
                    messagePrinter.printUserMessage("Usuario \(newUser.name) con email \(newUser.email) añadido satisfactoriamente.")
                }else {
                    messagePrinter.printUserMessage("No se pudo añadir el usuario.")
                }
            case "3":
                messagePrinter.printUserMessage("Introduce el nombre del usuario a eliminar:")
                guard let name = readLine(), !name.isEmpty else { continue }
                let removedCount = userService.removeUser(withName: name)
                if removedCount > 0 {
                    messagePrinter.printUserMessage("Se han eliminado \(removedCount) usuario(s) con el nombre \(name).")
                } else {
                    messagePrinter.printUserMessage("No se encontró ningún usuario con ese nombre.")
                }
            case "4":
                messagePrinter.printUserMessage("La funcionalidad de añadir punto a una ruta no está implementada todavía.")
            case "5":
                inAdminMenu = false
                messagePrinter.printUserMessage("Cerrando sesión...")
            default:
                messagePrinter.printUserMessage("Opción inválida, intenta de nuevo.")
            }
        }
    }
    
}
