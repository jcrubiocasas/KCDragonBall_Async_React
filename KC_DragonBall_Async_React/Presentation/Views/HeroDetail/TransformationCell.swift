//
//  KC_DragonBall_Async_React
//  TransformationCell.swift
//  Created by Juan Carlos Rubio Casas on 29/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes gráficos.

final class TransformationCell: UICollectionViewCell {
    // Clase final que representa una celda personalizada para mostrar transformaciones.

    // MARK: - UI Components

    public let imageView: UIImageView = {
        // Imagen de la transformación.
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Ajusta la imagen para que se mantenga en su proporción.
        imageView.layer.borderColor = UIColor.yellow.cgColor // Asigna un borde amarillo.
        imageView.layer.borderWidth = 2 // Define un ancho de borde de 2 puntos.
        imageView.layer.cornerRadius = 8 // Redondea las esquinas de la imagen.
        imageView.clipsToBounds = true // Asegura que el contenido no se desborde de los bordes redondeados.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return imageView
    }()
    
    public let nameLabel: UILabel = {
        // Etiqueta para mostrar el nombre de la transformación.
        let label = UILabel()
        label.textAlignment = .center // Centra el texto horizontalmente.
        label.font = UIFont.boldSystemFont(ofSize: 14) // Fuente en negrita con tamaño 14.
        label.textColor = .white // Texto blanco para buen contraste.
        label.numberOfLines = 1 // Permite solo una línea de texto.
        label.adjustsFontSizeToFitWidth = true // Ajusta el tamaño de la fuente si el texto es demasiado largo.
        label.minimumScaleFactor = 0.8 // Reduce la fuente hasta el 80% del tamaño original si es necesario.
        label.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return label
    }()
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        // Inicializador principal de la celda.
        super.init(frame: frame) // Llama al inicializador de la clase base.
        setupViews() // Configura las sub-vistas de la celda.
    }
    
    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }
    
    // MARK: - Setup

    private func setupViews() {
        // Configura las sub-vistas y sus restricciones.
        backgroundColor = .clear // Fondo transparente para la celda.
        contentView.backgroundColor = .clear // Fondo transparente para el contenido.
        contentView.layer.cornerRadius = 10 // Redondea las esquinas del contenido.
        contentView.layer.masksToBounds = true // Asegura que las sub-vistas no se desborden del contenido.

        contentView.addSubview(imageView) // Agrega la imagen como sub-vista.
        contentView.addSubview(nameLabel) // Agrega la etiqueta como sub-vista.
        
        NSLayoutConstraint.activate([
            // Restricciones para la imagen.
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9), // Margen superior.
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Margen izquierdo.
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Margen derecho.
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor), // La altura es igual al ancho (imagen cuadrada).
            
            // Restricciones para la etiqueta.
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8), // Margen superior relativo a la imagen.
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Margen izquierdo.
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Margen derecho.
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // Margen inferior.
        ])
    }
    
    // MARK: - Configuration

    func configure(with transformation: TransformationModel) {
        // Configura la celda con un modelo de transformación.

        // Configurar la imagen con una URL.
        if let url = URL(string: transformation.photo) {
            // Verifica que la URL de la imagen sea válida.
            DispatchQueue.global().async {
                // Descarga la imagen en un hilo en segundo plano.
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    // Intenta descargar y convertir los datos en una imagen.
                    DispatchQueue.main.async {
                        // Actualiza la interfaz de usuario en el hilo principal.
                        self.imageView.image = image // Asigna la imagen descargada al `imageView`.
                    }
                }
            }
        }
        
        // Configurar el nombre de la transformación.
        nameLabel.text = transformation.name // Asigna el nombre de la transformación al `nameLabel`.
    }
}
