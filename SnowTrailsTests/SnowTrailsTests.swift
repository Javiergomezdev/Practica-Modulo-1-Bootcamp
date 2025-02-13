//
//  SnowTrailsTests.swift
//  SnowTrailsTests
//
//  Created by Javier Gomez on 13/02/25.
//

import Testing
import Foundation

class UserServiceTests {

    @Suite("UserService Tests")
    class UserTests {

        var userService: UserService?

        init() {
            userService = UserService()
        }

        deinit {
            userService = nil
        }

        @Test func whenCalled_getAllUsers_returnAtLeastTwo() async throws {
            #expect(userService!.getAllUsers().count >= 2, "The number of default users should be at least 2")
        }

        @Test func whenCalled_findUserByEmail_returnsCorrectUser() async throws {
            let user = userService!.findUser(ByEmail: "adminuser@keepcoding.es")
            #expect(user != nil, "Admin debe existir")
            #expect(user!.email == "adminuser@keepcoding.es", "Email no coincide")
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
}
