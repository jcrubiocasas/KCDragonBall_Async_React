//
//  KC_DragonBall_Async_React
//  LoginRepositoryProtocol.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar funciones y estructuras básicas del sistema.

/// Protocolo que define las operaciones relacionadas con el login en la aplicación.
protocol LoginRepositoryProtocol {

    /// Realiza el inicio de sesión de un usuario.
    ///
    /// - Parameters:
    ///   - user: El nombre de usuario o correo electrónico utilizado para iniciar sesión.
    ///   - pasword: La contraseña asociada al usuario.
    /// - Returns: Una cadena que representa el resultado del login (por ejemplo, un token de autenticación).
    func loginApp(user: String, pasword: String) async -> String
}
