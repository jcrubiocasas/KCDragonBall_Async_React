//
//  KC_DragonBall_Async_React
//  LoginView.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes gráficos de la interfaz.

final class LoginView: UIView { // Clase final para definir la vista personalizada de Login.

    // MARK: - UI Components

    private let headerImageView: UIImageView = {
        // Imagen de encabezado para el título de la vista.
        let imageView = UIImageView()
        imageView.image = UIImage(named: "title") // Asigna la imagen del título desde los assets.
        imageView.contentMode = .scaleAspectFit // Ajusta la imagen para mantener su proporción.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        // Imagen del logo central de la vista.
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KeepCoding") // Asigna la imagen del logo desde los assets.
        imageView.contentMode = .scaleAspectFit // Ajusta la imagen para mantener su proporción.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return imageView
    }()
    
    public let emailTextField: UITextField = {
        // Campo de texto para ingresar el email.
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Email", comment: "Email placeholder") // Asigna un placeholder con soporte para localización.
        textField.borderStyle = .roundedRect // Estilo de borde redondeado.
        textField.keyboardType = .emailAddress // Define el teclado adecuado para direcciones de email.
        textField.autocapitalizationType = .none // Desactiva la capitalización automática.
        textField.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return textField
    }()
    
    public let passwordTextField: UITextField = {
        // Campo de texto para ingresar la contraseña.
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Password", comment: "Password placeholder") // Asigna un placeholder con soporte para localización.
        textField.borderStyle = .roundedRect // Estilo de borde redondeado.
        textField.isSecureTextEntry = true // Oculta el texto ingresado para proteger la contraseña.
        textField.autocapitalizationType = .none // Desactiva la capitalización automática.
        textField.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return textField
    }()
    
    public let loginButton: UIButton = {
        // Botón para iniciar sesión.
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Login", comment: "Login button"), for: .normal) // Asigna el título del botón con soporte para localización.
        button.isEnabled = false // Desactiva el botón inicialmente.
        button.backgroundColor = .systemBlue // Asigna un color de fondo azul.
        button.setTitleColor(.white, for: .normal) // Define el color del texto del botón.
        button.layer.cornerRadius = 8 // Redondea las esquinas del botón.
        button.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return button
    }()
    
    public let errorLabel: UILabel = {
        // Etiqueta para mostrar mensajes de error.
        let label = UILabel()
        label.textColor = .red // Define el color del texto como rojo.
        label.font = .systemFont(ofSize: 14) // Asigna una fuente de tamaño 14.
        label.textAlignment = .center // Centra el texto horizontalmente.
        label.isHidden = true // Oculta la etiqueta inicialmente.
        label.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return label
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        // Inicializador principal de la vista.
        super.init(frame: frame) // Llama al inicializador de la clase base.
        setupViews() // Configura las sub-vistas.
        setupConstraints() // Configura las restricciones de diseño.
    }
    
    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }
    
    // MARK: - Setup
    private func setupViews() {
        // Método para configurar las sub-vistas iniciales.
        backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage") ?? UIImage())
        // Asigna una imagen de fondo desde los assets.
        addSubview(headerImageView) // Agrega la imagen de encabezado como sub-vista.
        addSubview(logoImageView) // Agrega el logo como sub-vista.
        addSubview(emailTextField) // Agrega el campo de texto para el email como sub-vista.
        addSubview(passwordTextField) // Agrega el campo de texto para la contraseña como sub-vista.
        addSubview(loginButton) // Agrega el botón de inicio de sesión como sub-vista.
        addSubview(errorLabel) // Agrega la etiqueta de error como sub-vista.
    }
    
    private func setupConstraints() {
        // Método para configurar las restricciones de diseño.
        NSLayoutConstraint.activate([
            // Restricciones para la imagen de encabezado.
            headerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerImageView.heightAnchor.constraint(equalToConstant: 128),
            
            // Restricciones para la imagen del logo.
            logoImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Restricciones para el campo de texto del email.
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Restricciones para el campo de texto de la contraseña.
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Restricciones para el botón de login.
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Restricciones para la etiqueta de error.
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public Accessors
    func getHeaderImageView() -> UIImageView {
        headerImageView // Retorna la imagen de encabezado.
    }
    
    func getLogoImageView() -> UIImageView {
        logoImageView // Retorna la imagen del logo.
    }
    
    func getEmailTextField() -> UITextField {
        emailTextField // Retorna el campo de texto del email.
    }
    
    func getPasswordTextField() -> UITextField {
        passwordTextField // Retorna el campo de texto de la contraseña.
    }
    
    func getLoginButton() -> UIButton {
        loginButton // Retorna el botón de inicio de sesión.
    }
    
    func getErrorLabel() -> UILabel {
        errorLabel // Retorna la etiqueta de error.
    }
}
