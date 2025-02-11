//
//  LoginController.swift
//  SnowTrails
//
//  Created by Javier Gomez on 11/02/25.
//  
import Foundation
import OSLog

enum LogLevel: String {
    case info = "[INFO]"
    case debug = "[DEBUG]"
    case error = "[ERROR]"
}

class MessagePrinter {
    func printUserMessage(_ message: String) {
        print(message)
    }
    
    func printLog(_ message: String, level: LogLevel = .debug) {
        print("\(level.rawValue) \(message)")
    }
}

class LoginController {
    
    // Se declaran las dependencias para este controlador
    let userService: UserService
    let messagePrinter: MessagePrinter

    init(userService: UserService, messagePrinter: MessagePrinter) {
        self.userService = userService
        self.messagePrinter = messagePrinter
    }
            // Se encarga de solicitar las credenciales al usuario
    func login() -> User? {
        messagePrinter.printUserMessage("Introduce tu email:")
        guard let email = readLine(), !email.isEmpty else {
            messagePrinter.printUserMessage("El email no puede estar vacío.")
            return nil
        }
        
        messagePrinter.printUserMessage("Introduce tu contraseña:")
        guard let password = readLine(), !password.isEmpty else {
            messagePrinter.printUserMessage("La contraseña no puede estar vacía.")
            return nil
        }
        guard let user = userService.findUser(ByEmail: email) else {
            messagePrinter.printUserMessage("Usuario no encontrado.")
            return nil
        }
        if user.password == password {
            messagePrinter.printLog("Login correcto para \(user.name)", level: .info)
            messagePrinter.printUserMessage("Bienvenido, \(user.name).")
            return user
        } else {
            messagePrinter.printUserMessage("Contraseña incorrecta.")
            messagePrinter.printLog("Intento de login fallido para \(email)", level: .error)
            return nil
        }
    }
}
// Se crea un método auxiliar que valida las credenciales sin depender de readLine().
// Esto permite testear la lógica del login sin tener que simular la entrada de la consola.
extension LoginController {
    func validateLogin(email: String, password: String) -> User? {
        guard let user = userService.findUser(ByEmail: email) else {
            return nil
        }
        return user.password == password ? user : nil
    }
}
