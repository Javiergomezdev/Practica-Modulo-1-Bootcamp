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
    // Se encarga de solicitar las credenciales al usuario y se colocan los mensajes del Logger
    func login(onSuccess: (User) -> Void, onFailure: (String) -> Void) {
        
        messagePrinter.printUserMessage("Introduce tu email:")
        messagePrinter.printDeveloperMessage( "Solicitando email al usuario.", level: .info)
        
        guard let email = readLine(), !email.isEmpty else {
            let errorMessage = ("El email no puede estar vacío.")
            messagePrinter.printUserMessage(errorMessage)
            messagePrinter.printDeveloperMessage((errorMessage), level: .error)
            onFailure(errorMessage)
            return
        }
        
        messagePrinter.printUserMessage("Introduce tu contraseña:")
        messagePrinter.printDeveloperMessage("Solicitando contraseña al usuario.", level: .info)
        
        guard let password = readLine(), !password.isEmpty else {
            let errorMessage = ("La contraseña no puede estar vacía")
            messagePrinter.printUserMessage(errorMessage)
            messagePrinter.printDeveloperMessage("Error: La contraseña no puede estar vacía.", level: .error)
            onFailure(errorMessage)
            return
        }
        
        guard let user = userService.findUser(ByEmail: email) else {
            let errorMessage = ("Usuario no encontrado.")
            messagePrinter.printUserMessage(errorMessage)
            messagePrinter.printDeveloperMessage("Error: \(errorMessage) para email \(email).", level: .error)
            onFailure(errorMessage)
            return
        }
        
        if user.password == password {
            messagePrinter.printUserMessage("Bienvenido, \(user.name).")
            messagePrinter.printDeveloperMessage("Login correcto para \(user.name).", level: .info)
            onSuccess(user)
        } else {
            let errorMessage = ("Contraseña incorrecta.")
            messagePrinter.printUserMessage(errorMessage)
            messagePrinter.printDeveloperMessage("Intento de login fallido para \(email).", level: .error)
            onFailure(errorMessage)
        }
    }
    func validateLogin(email: String, password: String) -> User? {
        guard let user = userService.findUser(ByEmail: email) else {
            return nil
        }
        return user.password == password ? user : nil
    }
}
    
