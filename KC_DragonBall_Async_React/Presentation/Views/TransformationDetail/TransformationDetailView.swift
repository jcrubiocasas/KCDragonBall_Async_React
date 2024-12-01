//
//  KC_DragonBall_Async_React
//  TransformationDetailView.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes gráficos.

final class TransformationDetailView: UIView {
    // Clase final que representa la vista personalizada para mostrar los detalles de una transformación.

    // MARK: - UI Components

    public let headerImageView: UIImageView = {
        // Imagen del encabezado.
        let imageView = UIImageView()
        imageView.image = UIImage(named: "title") // Asigna una imagen del título desde los assets.
        imageView.contentMode = .scaleAspectFit // Ajusta la imagen para mantener su proporción.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return imageView
    }()

    public let transformationImageView: UIImageView = {
        // Imagen para mostrar la transformación.
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.yellow.cgColor // Color del borde amarillo.
        imageView.layer.borderWidth = 5 // Ancho del borde.
        imageView.layer.cornerRadius = 16 // Redondea las esquinas.
        imageView.contentMode = .scaleAspectFit // Ajusta la imagen para mantener su proporción.
        imageView.clipsToBounds = true // Asegura que la imagen no se desborde de los bordes redondeados.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return imageView
    }()

    public let nameLabel: UILabel = {
        // Etiqueta para mostrar el nombre de la transformación.
        let label = UILabel()
        label.layer.borderColor = UIColor.yellow.cgColor // Color del borde amarillo.
        label.layer.borderWidth = 5 // Ancho del borde.
        label.layer.cornerRadius = 16 // Redondea las esquinas.
        label.clipsToBounds = true // Asegura que el contenido no se desborde de los bordes redondeados.
        label.textColor = .white // Texto blanco.
        label.font = .boldSystemFont(ofSize: 18) // Fuente en negrita de tamaño 18.
        label.textAlignment = .center // Centra el texto horizontalmente.
        label.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return label
    }()

    public let descriptionTextView: UITextView = {
        // Vista de texto para mostrar la descripción de la transformación.
        let textView = UITextView()
        textView.isEditable = false // Desactiva la edición.
        textView.isSelectable = false // Desactiva la selección.
        textView.backgroundColor = .clear // Fondo transparente.
        textView.textColor = .white // Texto blanco.
        textView.font = .systemFont(ofSize: 16) // Fuente de tamaño 16.
        textView.layer.borderColor = UIColor.yellow.cgColor // Color del borde amarillo.
        textView.layer.borderWidth = 5 // Ancho del borde.
        textView.layer.cornerRadius = 16 // Redondea las esquinas.
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        // Define márgenes internos para el texto.
        textView.textAlignment = .justified // Alineación justificada del texto.
        textView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return textView
    }()

    // MARK: - Initializer

    init(transformation: TransformationModel) {
        // Inicializador que recibe el modelo de transformación.
        super.init(frame: .zero) // Llama al inicializador de la clase base.
        setupViews() // Configura las sub-vistas.
        configure(with: transformation) // Configura la vista con los datos de la transformación.
    }

    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }

    // MARK: - Setup

    private func setupViews() {
        // Configura las sub-vistas y sus restricciones.
        backgroundColor = .black // Fondo negro para la vista.
        addSubview(headerImageView) // Agrega la imagen del encabezado.
        addSubview(transformationImageView) // Agrega la imagen de la transformación.
        addSubview(nameLabel) // Agrega la etiqueta del nombre.
        addSubview(descriptionTextView) // Agrega la vista de texto de descripción.

        NSLayoutConstraint.activate([
            // Restricciones para la imagen del encabezado.
            headerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), // Posiciona la parte superior.
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), // Alinea a la izquierda.
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), // Alinea a la derecha.
            headerImageView.heightAnchor.constraint(equalToConstant: 128), // Altura fija.

            // Restricciones para la imagen de la transformación.
            transformationImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 16), // Espaciado inferior.
            transformationImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), // Alinea a la izquierda.
            transformationImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), // Alinea a la derecha.
            transformationImageView.heightAnchor.constraint(equalTo: transformationImageView.widthAnchor), // Relación de aspecto cuadrada.

            // Restricciones para la etiqueta del nombre.
            nameLabel.topAnchor.constraint(equalTo: transformationImageView.bottomAnchor, constant: 16), // Espaciado inferior.
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), // Alinea a la izquierda.
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), // Alinea a la derecha.
            nameLabel.heightAnchor.constraint(equalToConstant: 50), // Altura fija.

            // Restricciones para la vista de texto de descripción.
            descriptionTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16), // Espaciado inferior.
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), // Alinea a la izquierda.
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), // Alinea a la derecha.
            descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16) // Espaciado inferior.
        ])
    }

    // MARK: - Configuration

    private func configure(with transformation: TransformationModel) {
        // Configura la vista con los datos de la transformación.
        if let url = URL(string: transformation.photo) {
            // Verifica que la URL de la imagen sea válida.
            DispatchQueue.global().async {
                // Descarga la imagen en un hilo en segundo plano.
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    // Intenta descargar y convertir los datos en una imagen.
                    DispatchQueue.main.async {
                        // Actualiza la interfaz en el hilo principal.
                        self.transformationImageView.image = image // Asigna la imagen descargada.
                    }
                }
            }
        }
        nameLabel.text = transformation.name // Asigna el nombre de la transformación.
        descriptionTextView.text = transformation.description // Asigna la descripción de la transformación.
    }
}
