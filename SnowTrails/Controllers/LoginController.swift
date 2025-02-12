//
//  LoginController.swift
//  SnowTrails
//
//  Created by Javier Gomez on 11/02/25.
//

import OSLog
import Foundation

enum LogLevel {
    case info
    case debug
    case error
}

class MessagePrinter {
    private let logger = Logger(subsystem: "SnowTrails", category: "MessagePrinter")
    func printUserMessage(_ message: String) {
        print(message)
    }
    func printDeveloperMessage(_ message: String, level: LogLevel = .debug) {
        switch level {
        case .info:
            logger.info("\(message, privacy: .public)")
        case .debug:
            logger.debug("\(message, privacy: .public)")
        case .error:
            logger.error("\(message, privacy: .public)")
        }
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
    // TOCHECK: Se encarga de solicitar las credenciales al usuario y se colocan los mensajes del Logger
    func login() -> User? {
        messagePrinter.printUserMessage("Introduce tu email:")
       
        
        guard let email = readLine(), !email.isEmpty else {
            messagePrinter.printUserMessage("El email no puede estar vacío.")
            messagePrinter.printDeveloperMessage("Error: El email no puede estar vacío.", level: .error)
            return nil
        }
        
        messagePrinter.printUserMessage("Introduce tu contraseña:")
        messagePrinter.printDeveloperMessage("Solicitando contraseña al usuario.", level: .info)
        
        guard let password = readLine(), !password.isEmpty else {
            messagePrinter.printUserMessage("La contraseña no puede estar vacía.")
            messagePrinter.printDeveloperMessage("Error: La contraseña no puede estar vacía.", level: .error)
            return nil
        }
        
        guard let user = userService.findUser(ByEmail: email) else {
            messagePrinter.printUserMessage("Usuario no encontrado.")
            messagePrinter.printDeveloperMessage("Error: Usuario no encontrado para email \(email).", level: .error)
            return nil
        }
        
        if user.password == password {
            messagePrinter.printUserMessage("Bienvenido, \(user.name).")
            messagePrinter.printDeveloperMessage("Login correcto para \(user.name).", level: .info)
            return user
        } else {
            messagePrinter.printUserMessage("Contraseña incorrecta.")
            messagePrinter.printDeveloperMessage("Intento de login fallido para \(email).", level: .error)
            return nil
        }
    }
    func validateLogin(email: String, password: String) -> User? {
        guard let user = userService.findUser(ByEmail: email) else {
            return nil
        }
        return user.password == password ? user : nil
    }
}
    
