//
//  KC_DragonBall_Async_React
//  HerosCollectionViewCell.swift
//  Created by Juan Carlos Rubio Casas on 26/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes gráficos de la interfaz.

final class HerosCollectionViewCell: UICollectionViewCell {
    // Clase final para representar una celda personalizada en un CollectionView.

    // MARK: - UI Components

    public let photoImageView: UIImageView = {
        // Imagen del héroe, mostrada en la parte superior de la celda.
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // Ajusta la imagen para llenar su contenedor, recortando los bordes si es necesario.
        imageView.layer.cornerRadius = 8 // Redondea las esquinas de la imagen.
        imageView.clipsToBounds = true // Asegura que la imagen no se desborde de los bordes redondeados.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva las restricciones automáticas.
        return imageView
    }()
    
    public let nameLabel: UILabel = {
        // Etiqueta para mostrar el nombre del héroe.
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold) // Fuente en negrita con tamaño 16.
        label.textColor = .white // Texto blanco para buen contraste.
        label.textAlignment = .center // Centra el texto horizontalmente.
        label.translatesAutoresizingMaskIntoConstraints = false // Desactiva las restricciones automáticas.
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
        // Método para configurar las sub-vistas y sus restricciones.

        // Configuración del `contentView`.
        contentView.backgroundColor = .orange // Fondo naranja para la celda.
        contentView.layer.cornerRadius = 8 // Bordes redondeados en el contenido.
        contentView.layer.borderWidth = 4 // Borde de 4 puntos.
        contentView.layer.borderColor = UIColor.yellow.cgColor // Color del borde amarillo.
        contentView.clipsToBounds = true // Asegura que los elementos no se desborden del contenedor.

        // Agregar sub-vistas al `contentView`.
        contentView.addSubview(photoImageView) // Agrega la imagen al contenido.
        contentView.addSubview(nameLabel) // Agrega la etiqueta del nombre al contenido.

        // Configuración de las restricciones.
        NSLayoutConstraint.activate([
            // Restricciones para la imagen.
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor), // La imagen comienza en la parte superior.
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // La imagen se alinea al borde izquierdo.
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), // La imagen se alinea al borde derecho.
            photoImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor), // La imagen es cuadrada, con altura igual al ancho.

            // Restricciones para el label.
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor), // El label comienza justo debajo de la imagen.
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // El label se alinea al borde izquierdo.
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), // El label se alinea al borde derecho.
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor) // El label termina en la parte inferior del contenido.
        ])
    }
    
    // MARK: - Configuration

    func configure(with hero: HerosModel) {
        // Configura la celda con un modelo de héroe.
        nameLabel.text = hero.name // Asigna el nombre del héroe a la etiqueta.
        if let url = URL(string: hero.photo) {
            // Intenta crear una URL a partir de la cadena de la foto.
            photoImageView.loadImageRemote(url: url)
            // Carga la imagen de manera remota utilizando un método definido en una extensión de `UIImageView`.
        }
    }
}
