//
//  KC_DragonBall_Async_React
//  LoginRepository.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar funciones básicas y asincronismo.

/// Repositorio que implementa las operaciones reales relacionadas con el login.
final class DefaultLoginRepository: LoginRepositoryProtocol {

    // MARK: - Properties

    private var network: NetworkLoginProtocol // Protocolo de red utilizado para manejar las solicitudes de login.

    // MARK: - Initializer

    /// Inicializador que permite inyectar una capa de red.
    ///
    /// - Parameter network: Capa de red que implementa `NetworkLoginProtocol`.
    init(network: NetworkLoginProtocol) {
        self.network = network // Asigna la capa de red proporcionada.
    }

    // MARK: - Methods

    /// Realiza el inicio de sesión de un usuario llamando a la capa de red.
    ///
    /// - Parameters:
    ///   - user: El nombre de usuario o correo electrónico.
    ///   - pasword: La contraseña asociada al usuario.
    /// - Returns: Una cadena que representa el resultado del login (por ejemplo, un token de autenticación).
    func loginApp(user: String, pasword: String) async -> String {
        return await network.loginApp(user: user, password: pasword)
        // Llama al método de la capa de red para procesar el login.
    }
}

/// Repositorio que implementa operaciones simuladas (fake) relacionadas con el login.
final class LoginRepositoryFake: LoginRepositoryProtocol {

    // MARK: - Properties

    private var network: NetworkLoginProtocol // Capa de red simulada utilizada para manejar las solicitudes de login.

    // MARK: - Initializer

    /// Inicializador que permite inyectar una capa de red simulada.
    ///
    /// - Parameter network: Capa de red que implementa `NetworkLoginProtocol` (por defecto, `NetworkLoginFake`).
    init(network: NetworkLoginProtocol = NetworkLoginFake()) {
        self.network = network // Asigna la capa de red proporcionada o usa la simulada por defecto.
    }

    // MARK: - Methods

    /// Realiza el inicio de sesión de un usuario llamando a la capa de red simulada.
    ///
    /// - Parameters:
    ///   - user: El nombre de usuario o correo electrónico.
    ///   - pasword: La contraseña asociada al usuario.
    /// - Returns: Una cadena que representa el resultado del login simulado (por ejemplo, un token fake).
    func loginApp(user: String, pasword: String) async -> String {
        return await network.loginApp(user: user, password: pasword)
        // Llama al método de la capa de red simulada para procesar el login.
    }
}
