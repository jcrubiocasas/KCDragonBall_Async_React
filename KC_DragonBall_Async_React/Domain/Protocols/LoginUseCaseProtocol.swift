//
//  KC_DragonBall_Async_React
//  LoginUseCaseProtocol.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar funciones y estructuras básicas del sistema.

/// Protocolo que define las operaciones relacionadas con el caso de uso del login.
protocol LoginUseCaseProtocol {

    // MARK: - Properties

    /// Repositorio que implementa las operaciones relacionadas con el login.
    var repo: LoginRepositoryProtocol { get set }

    // MARK: - Methods

    /// Realiza el inicio de sesión de un usuario.
    ///
    /// - Parameters:
    ///   - user: El nombre de usuario o correo electrónico utilizado para iniciar sesión.
    ///   - password: La contraseña asociada al usuario.
    /// - Returns: Un valor booleano indicando si el login fue exitoso (`true`) o no (`false`).
    func loginApp(user: String, password: String) async -> Bool

    /// Realiza el cierre de sesión del usuario actual.
    ///
    /// Este método no requiere parámetros y se ejecuta de forma asincrónica.
    func logout() async

    /// Valida el estado del token de autenticación del usuario actual.
    ///
    /// - Returns: Un valor booleano indicando si el token es válido (`true`) o no (`false`).
    func validateToken() async -> Bool
}
