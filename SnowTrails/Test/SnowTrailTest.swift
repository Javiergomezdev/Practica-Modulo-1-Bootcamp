//
//  SnowTrailsTests.swift
//  SnowTrailsTests
//
//  Created by Javier Gomez on 13/02/25.
//

import Testing
import Foundation

struct  SnowTrailTest {
    
    @Suite("UserService Tests")
    class UserTests {
        
        var userService: UserService?
        var loginController: LoginController?
        var messagePrinter: MessagePrinter?
        
        init() {
            
            userService = UserService()
            
        }
        
        deinit {
            
            userService = nil
            
        }
        
        @Test func whenCalled_getAllUsers_returnAtLeastTwo() async throws {
            #expect(userService!.getAllUsers().count >= 2, "The number of default users should be at least 2")
        }
        
        @Test func whenCalled_addUser_increasesUserCount() async throws {
            let initialCount = userService!.getAllUsers().count
            _ = userService!.addUser(name: "New User", email: "newuser@correo.com", password: "1234")
            #expect(userService!.getAllUsers().count == initialCount + 1, "el contador no puede incrementarse despues de añadir un usuario")
        }
        
        @Test func whenCalled_removeUser_decreasesUserCount() async throws {
            _ = userService!.addUser(name: "paraBorrar", email: "paraborrar@correo.com", password: "1234")
            let initialCount = userService!.getAllUsers().count
            _ = userService!.removeUser(withName: "paraBorrar")
            #expect(userService!.getAllUsers().count == initialCount - 1, "el contador de usuarios no se puede reducir despues de borrar un usuario")
        }
    }
    
    @Suite("LoginController Tests")
    class LoginTests {
        
        var userService: UserService?
        var loginController: LoginController?
        var messagePrinter: MessagePrinter?
        
        init() {
            
            userService = UserService()
            messagePrinter = MessagePrinter()
            loginController = LoginController(userService: userService!, messagePrinter: messagePrinter! )
            
            _ = userService!.addUser(name: "testUser", email: "test@test.com", password: "testPassword")
        }
        
        deinit {
            loginController = nil
            userService = nil
            messagePrinter = nil
        }
        
        @Test func whenCalled_getAllUsers_returnAtLeastTwo() async throws {
            #expect(userService!.getAllUsers().count >= 2, "El numero de usuarios debe ser al menos 2.")
        }
        
        @Test func whenCalled_withWrongPassword_returnsNil() async throws {
            let user = loginController!.validateLogin(email: "test@test.com", password: "PassWordIncorrecto")
            #expect(user == nil, "El usuario debe estar logueado correctamente con su password")
        }
        
        @Test func whenCalled_withNonExistingEmail_returnsNil() async throws {
            let user = loginController!.validateLogin(email: "notexist@correo.com", password: "testPassword")
            #expect(user == nil, "el usuario no existe en la base de datos")
        }
    }
    
    @Suite("RouterServices Tests")
    class RoutesTest {
        
        var routesService: RoutesService?
        
        init() {
            
            routesService = RoutesService()
            
        }
        
        deinit {
            
            routesService = nil
            
        }
        
        @Test func whenCalled_getAllRoutesReturnsAllRoutes() {
            let routes = routesService!.getAllRoutes()
            #expect(!routes.isEmpty, "La lista de rutas no puede estar vacia.")
        }
        @Test func whenCaled_findPointByNameReturnsPoint() {
            let point = routesService!.findPoint(byName: "Alpina Grande")
            #expect(point != nil, "El punto debe ser encontrado.")
            #expect(point!.name == "Alpina Grande", "El nombre del punto no es el correcto.")
        }
    }
}
