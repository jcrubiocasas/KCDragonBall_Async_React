//
//  KC_DragonBall_Async_React
//  ErrorViewController.swift
//  Created by Juan Carlos Rubio Casas on 25/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes de la interfaz de usuario.
import Combine // Importa Combine para trabajar con programación reactiva.
import CombineCocoa // Importa CombineCocoa para simplificar bindings con elementos de UIKit.

final class ErrorViewController: UIViewController { // Define una clase final para evitar herencia, que gestiona la pantalla de errores.

    // MARK: - Private Properties
    private var appState: AppState? // Propiedad privada que almacena el estado global de la aplicación.
    private var subscriptions = Set<AnyCancellable>() // Conjunto de suscripciones para manejar Combine y evitar fugas de memoria.
    private var error: String? // Propiedad privada para almacenar el mensaje de error.
    private var errorView: ErrorView? // Propiedad privada para manejar la vista personalizada de errores.

    // MARK: - Initializers
    init(appState: AppState, error: String) {
        // Inicializador personalizado que recibe el estado de la aplicación y el mensaje de error.
        self.appState = appState // Asigna el estado de la aplicación a la propiedad local.
        self.error = error // Asigna el mensaje de error a la propiedad local.
        super.init(nibName: nil, bundle: nil) // Llama al inicializador de la clase base con valores nulos para nibName y bundle.
    }
    
    required init?(coder: NSCoder) {
        // Inicializador requerido para la decodificación, no implementado aquí.
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }
    
    // MARK: - View Lifecycle
    override func loadView() {
        // Método que define la vista principal del controlador.
        errorView = ErrorView() // Crea una instancia de la vista de errores personalizada.
        view = errorView // Asigna la vista personalizada como la vista principal del controlador.
    }
    
    override func viewDidLoad() {
        // Método llamado después de que la vista ha sido cargada.
        super.viewDidLoad() // Llama a la implementación de la clase base.
        setupView() // Configura los elementos visuales iniciales.
        setupBindings() // Configura los bindings para la interacción.
    }
    
    // MARK: - Private Methods
    private func setupView() {
        // Método para configurar el contenido de la vista de error.
        errorView?.setErrorText(error ?? NSLocalizedString("Unknown Error", comment: "Default error message"))
        // Establece el texto de error, usando un mensaje predeterminado si no hay error proporcionado.
    }
    
    private func setupBindings() {
        // Método para configurar los bindings reactivos.
        errorView?.backButton.tapPublisher
            // Observa los eventos de toque del botón "back" utilizando CombineCocoa.
            .sink { [weak self] in
                // Define una acción que se ejecutará al recibir un evento de toque.
                self?.appState?.statusLogin = .none // Restablece el estado de login al valor predeterminado (`none`).
            }
            .store(in: &subscriptions) // Almacena la suscripción en el conjunto de suscripciones para evitar fugas de memoria.
    }
}

// MARK: - Preview
#Preview {
    // Proporciona una vista previa para SwiftUI.
    ErrorViewController(appState: AppState(), error: "Something went wrong!")
    // Crea una instancia del controlador con un mensaje de error de ejemplo.
}
