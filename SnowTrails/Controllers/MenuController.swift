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
        while isRunning {
            messagePrinter.printUserMessage("\nBienvenido a SnowTrails")
            messagePrinter.printUserMessage("1. Acceder como usuario")
            messagePrinter.printUserMessage("2. Acceder como administrador")
            messagePrinter.printUserMessage("3. Salir")
            
            guard let choice = readLine() else { continue }
            switch choice {
            case "1":
                if let user = loginController.login() {
                    if user.role == .regular {
                        showUserMenu(user: user)
                    } else {
                        messagePrinter.printUserMessage("Este usuario es administrador. Usa la opción 2.")
                    }
                }
            case "2":
                if let user = loginController.login() {
                    if user.role == .admin {
                        showAdminMenu(user: user)
                    } else {
                        messagePrinter.printUserMessage("Este usuario es regular. Usa la opción 1.")
                    }
                }
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
            messagePrinter.printUserMessage("\nMenú usuario - Selecciona una opción:")
            messagePrinter.printUserMessage("1. Ver todas las rutas")
            messagePrinter.printUserMessage("2. Obtener la ruta más corta entre dos puntos")
            messagePrinter.printUserMessage("3. Log out")
            
            guard let choice = readLine() else { continue }
            switch choice {
            case "1":
                let routes = routesService.getAllRoutes()
                for route in routes {
                    let distance = routesService.distancePointsRoute(of: route)
                    messagePrinter.printUserMessage("\(route.name) - \(String(format: "%.2f", distance/1000)) Km")
                }
            case "2":
                messagePrinter.printUserMessage("La funcionalidad de obtener la ruta más corta no está implementada todavía.")
            case "3":
                inUserMenu = false
                messagePrinter.printUserMessage("Cerrando sesión...")
            default:
                messagePrinter.printUserMessage("Opción inválida, intenta de nuevo.")
            }
        }
    }
    
    /// Menú para administradores.
    func showAdminMenu(user: User) {
        var inAdminMenu = true
        while inAdminMenu {
            messagePrinter.printUserMessage("\nMenú admin - Selecciona una opción:")
            messagePrinter.printUserMessage("1. Ver todos los usuarios")
            messagePrinter.printUserMessage("2. Añadir usuario")
            messagePrinter.printUserMessage("3. Eliminar usuario")
            messagePrinter.printUserMessage("4. Añadir punto a una ruta")
            messagePrinter.printUserMessage("5. Logout")
            
            guard let choice = readLine() else { continue }
            switch choice {
            case "1":
                let users = userService.getAllUsers()
                for user in users {
                    let roleText = user.role == UserRole.admin ? "Admin" : "Regular user"
                    messagePrinter.printUserMessage("\(roleText): \(user.name) --- Email: \(user.email)")
                }
            case "2":
                messagePrinter.printUserMessage("Añadir usuario")
                messagePrinter.printUserMessage("Introduce el nombre:")
                guard let name = readLine(), !name.isEmpty else { continue }
                messagePrinter.printUserMessage("Introduce el email:")
                guard let email = readLine(), !email.isEmpty else { continue }
                messagePrinter.printUserMessage("Introduce la contraseña:")
                guard let password = readLine(), !password.isEmpty else { continue }
                let newUser = User( name: name, role: UserRole.regular, email: email, password: password )
                userService.addUser(newUser)
                messagePrinter.printUserMessage("Usuario \(newUser.name) con email \(newUser.email) añadido satisfactoriamente.")
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
