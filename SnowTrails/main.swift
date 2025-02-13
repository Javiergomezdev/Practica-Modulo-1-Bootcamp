//
//  main.swift
//  SnowTrails
//
//  Created by Javier Gomez on 6/2/25.
//

import Foundation

// Clase principal de la aplicación
class App {
    // Punto de entrada para iniciar la ejecución
    func run() {
        // Servicio que maneja la información de usuarios
        let userService = UserService()
        
        // Servicio que administra la lógica de rutas
        let routesService = RoutesService()
        
        // Encargado de imprimir mensajes al usuario
        let messagePrinter = MessagePrinter()
        
        // Controlador para manejo de autenticación
        let loginController = LoginController(userService: userService, messagePrinter: messagePrinter)
        
        // Controlador principal que organiza menús y flujo de la app
        let menuController = MenuController(userService: userService,
                                            routesService: routesService,
                                            loginController: loginController,
                                            messagePrinter: messagePrinter)
        
        // Inicia el programa mostrando el menú
        menuController.start()
    }
}

// Instancia y ejecución de la aplicación
let app = App()
app.run()
