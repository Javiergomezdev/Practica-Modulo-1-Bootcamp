//
//  main.swift
//  SnowTrails
//
//  Created by Javier Gomez on 6/2/25.
//
import Foundation

class App {
    func run() {
        let userService = UserService()
        let routesService = RoutesService()
        let messagePrinter = MessagePrinter()
        let loginController = LoginController(userService: userService, messagePrinter: messagePrinter)
        let menuController = MenuController(userService: userService,
                                            routesService: routesService,
                                            loginController: loginController,
                                            messagePrinter: messagePrinter)
        menuController.start()
    }
}

let app = App()
app.run()


