//
//  KC_DragonBall_Async_React
//  SceneDelegate.swift
//  Created by Juan Carlos Rubio Casas on 17/11/24.
//

import UIKit // Importa UIKit para manejar el ciclo de vida de las escenas y la interfaz de usuario.
import Combine // Importa Combine para la programación reactiva.

/// Clase que gestiona el ciclo de vida de las escenas en la aplicación.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    /// Ventana principal de la aplicación.
    var window: UIWindow?

    /// Estado global de la aplicación.
    var appState: AppState = AppState()

    /// Suscripción para observar cambios en el estado del login.
    var cancellable: AnyCancellable?

    // MARK: - Scene Lifecycle

    /// Método llamado cuando la escena está a punto de conectarse.
    ///
    /// - Parameters:
    ///   - scene: La escena gestionada por este delegado.
    ///   - session: La sesión de la escena.
    ///   - connectionOptions: Opciones relacionadas con la conexión de la escena.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // Asegúrate de que la escena sea una instancia de `UIWindowScene`.
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Configuración de la ventana principal.
        self.window = UIWindow(windowScene: windowScene)

        // Validar el estado de login al iniciar la escena.
        appState.validateControlLogin()

        // Navegador para gestionar las pantallas.
        var nav: UINavigationController?

        // Observa los cambios en el estado del login.
        self.cancellable = appState.$statusLogin
            .sink { estado in
                switch estado {
                case .notValidate, .none:
                    // Si el estado es no validado o ninguno, muestra la pantalla de login.
                    DispatchQueue.main.async {
                        print("login")
                        nav = UINavigationController(rootViewController: LoginViewController(appState: self.appState))
                        self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                case .success:
                    // Si el login es exitoso, muestra la pantalla de inicio.
                    DispatchQueue.main.async {
                        print("Vamos a la home")
                        nav = UINavigationController(rootViewController: HerosCollectionViewController(appState: self.appState, viewModel: HerosViewModel()))
                        self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                case .error:
                    // Si ocurre un error, muestra la pantalla de error.
                    DispatchQueue.main.async {
                        print("Pantalla de error")
                        nav = UINavigationController(rootViewController: ErrorViewController(appState: self.appState, error: "Error en el login usuario/Clave"))
                        self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                }
            }
    }

    // MARK: - Scene State Transitions

    /// Método llamado cuando la escena se desconecta.
    func sceneDidDisconnect(_ scene: UIScene) {
        // Libera recursos asociados con la escena.
    }

    /// Método llamado cuando la escena se vuelve activa.
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Reinicia tareas pausadas al volver a un estado activo.
    }

    /// Método llamado cuando la escena pasará a un estado inactivo.
    func sceneWillResignActive(_ scene: UIScene) {
        // Maneja interrupciones temporales, como llamadas entrantes.
    }

    /// Método llamado cuando la escena transiciona al primer plano.
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Revierte cambios hechos al entrar en segundo plano.
    }

    /// Método llamado cuando la escena entra en segundo plano.
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Guarda datos y libera recursos compartidos.
    }
}
