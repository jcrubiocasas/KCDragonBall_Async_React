//
//  KC_DragonBall_Async_React
//  ErrorView.swift
//  Created by Juan Carlos Rubio Casas on 25/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes de la interfaz de usuario.

final class ErrorView: UIView { // Clase final para una vista personalizada que muestra un error.

    // MARK: - UI Components
    public let headerImageView: UIImageView = {
        // Imagen de encabezado que muestra una imagen representativa.
        let imageView = UIImageView() // Crea una instancia de `UIImageView`.
        imageView.image = UIImage(named: "title") // Asigna una imagen desde los assets. Asegúrate de que exista.
        imageView.contentMode = .scaleAspectFit // Ajusta el contenido de la imagen manteniendo su proporción.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva las restricciones automáticas.
        return imageView // Retorna la instancia configurada.
    }()
    
    public let errorLabel: UILabel = {
        // Etiqueta para mostrar el mensaje de error.
        let label = UILabel() // Crea una instancia de `UILabel`.
        label.textColor = .red // Asigna el color rojo al texto.
        label.font = .systemFont(ofSize: 16, weight: .bold) // Configura la fuente con tamaño 16 y estilo negrita.
        label.numberOfLines = 0 // Permite múltiples líneas de texto.
        label.textAlignment = .center // Centra el texto horizontalmente.
        label.translatesAutoresizingMaskIntoConstraints = false // Desactiva las restricciones automáticas.
        return label // Retorna la instancia configurada.
    }()
    
    public let backButton: UIButton = {
        // Botón que permite volver a la pantalla anterior.
        let button = UIButton(type: .system) // Crea un botón de tipo `system`.
        button.setTitle(NSLocalizedString("Back", comment: "Back button title"), for: .normal)
        // Asigna un título al botón, con soporte para localización.
        button.setTitleColor(.white, for: .normal) // Establece el color del texto del botón.
        button.backgroundColor = .systemBlue // Asigna un color de fondo al botón.
        button.layer.cornerRadius = 8 // Configura un radio de esquina redondeada de 8 puntos.
        button.translatesAutoresizingMaskIntoConstraints = false // Desactiva las restricciones automáticas.
        return button // Retorna la instancia configurada.
    }()
    
    public let stackView: UIStackView = {
        // Contenedor vertical para organizar los componentes.
        let stackView = UIStackView() // Crea una instancia de `UIStackView`.
        stackView.axis = .vertical // Establece la orientación vertical.
        stackView.spacing = 20 // Configura un espacio de 20 puntos entre elementos.
        stackView.alignment = .fill // Establece el alineamiento como relleno completo.
        stackView.distribution = .equalSpacing // Configura una distribución equitativa del espacio.
        stackView.translatesAutoresizingMaskIntoConstraints = false // Desactiva las restricciones automáticas.
        return stackView // Retorna la instancia configurada.
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
        fatalError("init(coder:) has not been implemented") // Lanza un error si se utiliza este inicializador.
    }
    
    // MARK: - Setup
    private func setupViews() {
        // Método para configurar las sub-vistas iniciales.
        backgroundColor = .white // Asigna un color de fondo blanco a la vista.
        addSubview(headerImageView) // Agrega la imagen de encabezado como sub-vista.
        addSubview(stackView) // Agrega el `UIStackView` como sub-vista.
        stackView.addArrangedSubview(errorLabel) // Agrega la etiqueta de error al stack view.
        stackView.addArrangedSubview(backButton) // Agrega el botón de regreso al stack view.
    }
    
    private func setupConstraints() {
        // Método para configurar las restricciones de diseño.
        NSLayoutConstraint.activate([
            // Restricciones para la imagen de encabezado.
            headerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            // Establece el margen superior relativo al área segura.
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            // Establece el margen izquierdo.
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            // Establece el margen derecho.
            headerImageView.heightAnchor.constraint(equalToConstant: 128),
            // Establece una altura fija de 128 puntos.

            // Restricciones para el stack view.
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            // Centra el stack view verticalmente en la vista.
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            // Establece el margen izquierdo.
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            // Establece el margen derecho.
        ])
        
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Establece una altura fija de 50 puntos para el botón.
    }
    
    // MARK: - Public Methods
    func setErrorText(_ text: String) {
        // Configura el texto que muestra la etiqueta de error.
        errorLabel.text = text // Asigna el texto proporcionado a la etiqueta.
    }
    
    func getErrorHeaderImageView() -> UIImageView {
        // Método para obtener la imagen de encabezado.
        headerImageView // Retorna la instancia de `UIImageView`.
    }
    
    func getErrorLabel() -> UILabel {
        // Método para obtener la etiqueta de error.
        errorLabel // Retorna la instancia de `UILabel`.
    }
            
    func getBackButton() -> UIButton {
        // Método para obtener el botón de regreso.
        backButton // Retorna la instancia de `UIButton`.
    }
    
    func getStackView() -> UIStackView {
        // Método para obtener el stack view.
        stackView // Retorna la instancia de `UIStackView`.
    }
}
