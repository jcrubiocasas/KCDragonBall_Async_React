//
//  KC_DragonBall_Async_React
//  LoginUseCase.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar estructuras básicas del sistema.
// import KCLibrarySwift // Comentado, podría ser necesario si se utilizan componentes de esta librería.

/// Caso de uso para gestionar el proceso de login.
final class LoginUseCase: LoginUseCaseProtocol {

    // MARK: - Properties

    var repo: LoginRepositoryProtocol // Repositorio que implementa las operaciones relacionadas con el login.

    // MARK: - Initializer

    /// Inicializador que permite inyectar un repositorio.
    ///
    /// - Parameter repo: El repositorio a utilizar para las operaciones de login (por defecto, `DefaultLoginRepository`).
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo // Asigna el repositorio proporcionado o el valor por defecto.
    }

    // MARK: - Methods

    /// Realiza el login de un usuario.
    ///
    /// - Parameters:
    ///   - user: Nombre de usuario o correo electrónico.
    ///   - password: Contraseña del usuario.
    /// - Returns: `true` si el login fue exitoso, `false` en caso contrario.
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, pasword: password)
        // Obtiene el token del repositorio.

        if token != "" {
            // Si el token no está vacío, se almacena en el Keychain.
            KeyChainKC().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else {
            // Si el token está vacío, elimina cualquier valor previo en el Keychain.
            KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
    }

    /// Realiza el cierre de sesión del usuario actual.
    func logout() async {
        KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        // Elimina el token almacenado en el Keychain.
    }

    /// Valida el estado del token de autenticación.
    ///
    /// - Returns: `true` si el token es válido, `false` en caso contrario.
    func validateToken() async -> Bool {
        if KeyChainKC().loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != "" {
            // Si el token no está vacío, retorna `true`.
            return true
        } else {
            // Si el token está vacío, retorna `false`.
            return false
        }
    }
}

/// Caso de uso para login con datos simulados (fake).
final class LoginUseCaseFake: LoginUseCaseProtocol {

    // MARK: - Properties

    var repo: LoginRepositoryProtocol // Repositorio utilizado para las operaciones de login (simulado).

    // MARK: - Initializer

    /// Inicializador que permite inyectar un repositorio simulado.
    ///
    /// - Parameter repo: Repositorio utilizado para las operaciones de login (por defecto, `DefaultLoginRepository`).
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo // Asigna el repositorio proporcionado o el valor por defecto.
    }

    // MARK: - Methods

    /// Realiza el login de un usuario con datos simulados.
    ///
    /// - Parameters:
    ///   - user: Nombre de usuario o correo electrónico.
    ///   - password: Contraseña del usuario.
    /// - Returns: Siempre retorna `true`.
    func loginApp(user: String, password: String) async -> Bool {
        // Simula el almacenamiento de un token en el Keychain.
        KeyChainKC().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: "LoginFakeSuccess")
        return true
    }

    /// Realiza el cierre de sesión simulando la eliminación del token.
    func logout() async {
        KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        // Simula la eliminación del token del Keychain.
    }

    /// Valida el token simulando que siempre es válido.
    ///
    /// - Returns: Siempre retorna `true`.
    func validateToken() async -> Bool {
        return true // Retorna siempre `true` en el caso simulado.
    }
}
