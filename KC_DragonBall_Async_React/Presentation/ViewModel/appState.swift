//
//  KC_DragonBall_Async_React
//  appState.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa el módulo Foundation para usar funcionalidades esenciales de Swift.

enum LoginStatus { // Define un enumerado para representar los diferentes estados del login.
    case none // Representa el estado inicial o sin acción.
    case success // Indica que el login fue exitoso.
    case error // Indica que hubo un error durante el login.
    case notValidate // Indica que el token de login no es válido.
}

final class AppState { // Define una clase final para evitar herencia, que maneja el estado global de la aplicación.

    // MARK: - Published Properties
    @Published var statusLogin: LoginStatus = .none // Propiedad observable que representa el estado actual del login.

    // MARK: - Private Properties
    private var loginUseCase: LoginUseCaseProtocol // Propiedad privada que maneja la lógica del caso de uso del login.

    // MARK: - Initializer
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) { // Inicializador con inyección de dependencia para el caso de uso.
        self.loginUseCase = loginUseCase // Asigna el caso de uso proporcionado o el caso de uso por defecto.
    }
    
    // MARK: - Public Methods
    func loginApp(user: String, pass: String) { // Método público para iniciar sesión con un usuario y contraseña.
        Task { // Crea un contexto asíncrono para ejecutar operaciones suspendibles.
            if (await loginUseCase.loginApp(user: user, password: pass)) {
                // Llama al caso de uso para realizar el login y espera la respuesta.
                self.statusLogin = .success // Actualiza el estado del login a `success` si es exitoso.
            } else {
                self.statusLogin = .error // Actualiza el estado del login a `error` si falla.
            }
        }
    }
    
    func validateControlLogin() { // Método público para validar el token de sesión.
        Task { // Crea un contexto asíncrono para validar el token.
            if (await loginUseCase.validateToken()) {
                // Llama al caso de uso para validar el token y espera la respuesta.
                self.statusLogin = .success // Actualiza el estado del login a `success` si el token es válido.
            } else {
                self.statusLogin = .notValidate // Actualiza el estado del login a `notValidate` si el token no es válido.
            }
        }
    }
    
    func closeSessionUser() { // Método público para cerrar sesión.
        Task { // Crea un contexto asíncrono para realizar el cierre de sesión.
            await loginUseCase.logout() // Llama al caso de uso para cerrar sesión.
            self.statusLogin = .none // Actualiza el estado del login a `none` tras cerrar sesión.
        }
    }
}
