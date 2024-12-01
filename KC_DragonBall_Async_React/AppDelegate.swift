//
//  KC_DragonBall_Async_React
//  AppDelegate.swift
//  Created by Juan Carlos Rubio Casas on 17/11/24.
//

import UIKit // Importa UIKit para manejar la interfaz de usuario y el ciclo de vida de la aplicación.

/// Punto de entrada principal de la aplicación.
/// Gestiona el ciclo de vida de la aplicación y las configuraciones iniciales.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - UIApplicationDelegate Methods

    /// Método llamado cuando la aplicación ha finalizado su lanzamiento.
    ///
    /// - Parameters:
    ///   - application: Instancia compartida de la aplicación.
    ///   - launchOptions: Información sobre las opciones de inicio de la aplicación.
    /// - Returns: `true` si el lanzamiento fue exitoso.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Punto de personalización después del lanzamiento de la aplicación.
        return true
    }

    // MARK: - UISceneSession Lifecycle

    /// Configura una nueva sesión de escena cuando se está creando.
    ///
    /// - Parameters:
    ///   - application: Instancia compartida de la aplicación.
    ///   - connectingSceneSession: Sesión de escena que se está creando.
    ///   - options: Opciones relacionadas con la conexión de la escena.
    /// - Returns: Una configuración para crear la nueva escena.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Llamado cuando se crea una nueva sesión de escena.
        debugPrint("Nueva escena: \(connectingSceneSession.role) con nombre: \(connectingSceneSession.description)")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    /// Método llamado cuando el usuario descarta una o más sesiones de escena.
    ///
    /// - Parameters:
    ///   - application: Instancia compartida de la aplicación.
    ///   - sceneSessions: Conjunto de sesiones de escena descartadas.
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Llamado cuando el usuario descarta una sesión de escena.
        debugPrint("Escena descartada.")
    }
}
