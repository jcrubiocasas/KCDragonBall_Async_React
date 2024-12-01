//
//  KC_DragonBall_Async_React
//  LoginViewController.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import UIKit // Importa UIKit para trabajar con la interfaz de usuario.
import Combine // Importa Combine para manejar programación reactiva.
import CombineCocoa // Importa CombineCocoa para simplificar bindings con UIKit.

final class LoginViewController: UIViewController { // Clase final que gestiona la pantalla de login.

    // MARK: - Private Properties
    private var appState: AppState? // Propiedad que almacena el estado global de la aplicación.
    private var subscriptions = Set<AnyCancellable>() // Conjunto de suscripciones para Combine, evitando fugas de memoria.
    private var user: String = "" // Propiedad para almacenar el texto del campo de usuario.
    private var pass: String = "" // Propiedad para almacenar el texto del campo de contraseña.
    
    // MARK: - UI Components
    var header: UIImageView? // Imagen de encabezado.
    var logo: UIImageView? // Imagen del logo.
    var emailTextfield: UITextField? // Campo de texto para el email.
    var passwordTextfield: UITextField? // Campo de texto para la contraseña.
    var loginButton: UIButton? // Botón de inicio de sesión.

    // MARK: - Initializers
    init(appState: AppState) {
        // Inicializador que recibe el estado global de la aplicación.
        self.appState = appState // Asigna el estado global.
        super.init(nibName: nil, bundle: nil) // Llama al inicializador de la clase base.
    }
    
    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        // Método llamado después de cargar la vista.
        super.viewDidLoad() // Llama a la implementación base.
        setupBindings() // Configura los bindings entre los elementos de la vista y el modelo.
    }
    
    override func loadView() {
        // Método que define la vista principal del controlador.
        let loginView = LoginView() // Crea una instancia de `LoginView`.
        header = loginView.getHeaderImageView() // Obtiene la vista del encabezado.
        logo = loginView.getLogoImageView() // Obtiene la vista del logo.
        emailTextfield = loginView.getEmailTextField() // Obtiene el campo de texto del email.
        passwordTextfield = loginView.getPasswordTextField() // Obtiene el campo de texto de la contraseña.
        loginButton = loginView.getLoginButton() // Obtiene el botón de inicio de sesión.
        view = loginView // Asigna la vista personalizada como la vista principal.
    }
    
    // MARK: - Private Methods
    func setupBindings() {
        // Método para configurar los bindings reactivos entre los elementos de la vista y el modelo.

        // Email text binding
        if let emailTextfield = self.emailTextfield {
            // Verifica si el campo de texto de email no es nulo.
            emailTextfield.textPublisher // Observa los cambios en el texto del campo.
                .receive(on: DispatchQueue.main) // Asegura que los eventos se reciban en el hilo principal.
                .sink(receiveValue: { [weak self] data in
                    // Maneja los cambios en el texto del email.
                    if let usr = data {
                        // Verifica si hay texto ingresado.
                        print("Text user: \(usr)") // Imprime el texto ingresado en la consola.
                        self?.user = usr // Asigna el texto a la propiedad `user`.
                        
                        if let button = self?.loginButton {
                            // Verifica si el botón no es nulo.
                            button.isEnabled = (self?.user.count ?? 0) > 5
                            // Habilita o deshabilita el botón según la longitud del texto ingresado.
                        }
                    }
                })
                .store(in: &subscriptions) // Almacena la suscripción para evitar fugas de memoria.
        }
        
        // Password text binding
        if let passwordTextfield = self.passwordTextfield {
            // Verifica si el campo de texto de contraseña no es nulo.
            passwordTextfield.textPublisher // Observa los cambios en el texto del campo.
                .receive(on: DispatchQueue.main) // Asegura que los eventos se reciban en el hilo principal.
                .sink(receiveValue: { [weak self] data in
                    // Maneja los cambios en el texto de la contraseña.
                    if let pass = data {
                        // Verifica si hay texto ingresado.
                        print("Text pass: \(pass)") // Imprime el texto ingresado en la consola.
                        self?.pass = pass // Asigna el texto a la propiedad `pass`.
                    }
                })
                .store(in: &subscriptions) // Almacena la suscripción para evitar fugas de memoria.
        }
        
        // Button binding
        if let button = self.loginButton {
            // Verifica si el botón no es nulo.
            button.tapPublisher // Observa los eventos de toque en el botón.
                .receive(on: DispatchQueue.main) // Asegura que los eventos se reciban en el hilo principal.
                .sink(receiveValue: { [weak self] _ in
                    // Maneja el evento de toque del botón.
                    if let user = self?.user, let pass = self?.pass {
                        // Verifica que ambos campos tengan valores.
                        self?.appState?.loginApp(user: user, pass: pass)
                        // Llama al método de login en el estado global con los valores ingresados.
                    }
                }).store(in: &subscriptions) // Almacena la suscripción para evitar fugas de memoria.
        }
    }
}

// MARK: - Preview
#Preview {
    // Proporciona una vista previa para SwiftUI.
    LoginViewController(appState: AppState()) // Crea una instancia del controlador con un estado de ejemplo.
}
