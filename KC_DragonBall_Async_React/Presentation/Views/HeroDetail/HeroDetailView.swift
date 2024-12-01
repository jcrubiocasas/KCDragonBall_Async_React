//
//  KC_DragonBall_Async_React
//  HeroDetailView.swift
//  Created by Juan Carlos Rubio Casas on 26/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes gráficos.

final class HeroDetailView: UIView {
    // Clase final que representa la vista personalizada para los detalles de un héroe.

    // MARK: - UI Components

    public let headerImageView: UIImageView = {
        // Imagen del encabezado de la vista.
        let imageView = UIImageView()
        imageView.image = UIImage(named: "title") // Cambia "title" por el nombre correcto en tus assets.
        imageView.contentMode = .scaleAspectFit // Ajusta la imagen para mantener su proporción.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return imageView
    }()

    public let heroImageView: UIImageView = {
        // Imagen para mostrar al héroe.
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.yellow.cgColor // Color del borde amarillo.
        imageView.layer.borderWidth = 5 // Ancho del borde.
        imageView.layer.cornerRadius = 16 // Redondea las esquinas.
        imageView.contentMode = .scaleAspectFit // Ajusta la imagen para mantener su proporción.
        imageView.clipsToBounds = true // Asegura que la imagen no se desborde de los bordes redondeados.
        imageView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return imageView
    }()

    public let descriptionTextView: UITextView = {
        // Vista de texto para mostrar la descripción del héroe.
        let textView = UITextView()
        textView.isEditable = false // Desactiva la edición.
        textView.isSelectable = false // Desactiva la selección.
        textView.backgroundColor = .clear // Fondo transparente.
        textView.textColor = .white // Texto blanco.
        textView.font = .systemFont(ofSize: 18, weight: .medium) // Fuente de tamaño 18.
        textView.layer.borderColor = UIColor.yellow.cgColor // Color del borde amarillo.
        textView.layer.borderWidth = 5 // Ancho del borde.
        textView.layer.cornerRadius = 16 // Redondea las esquinas.
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        // Define márgenes internos del texto.
        textView.textAlignment = .justified // Alineación justificada del texto.
        textView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return textView
    }()

    public let transformationsTitleLabel: UILabel = {
        // Etiqueta para el título de transformaciones.
        let label = UILabel()
        label.text = "TRANSFORMATIONS" // Texto del título.
        label.textColor = .white // Texto blanco.
        label.font = UIFont.boldSystemFont(ofSize: 16) // Fuente en negrita de tamaño 16.
        label.textAlignment = .center // Texto centrado.
        label.isHidden = true // Oculto inicialmente.
        label.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return label
    }()

    public let transformationsCollectionView: UICollectionView = {
        // Vista de colección para mostrar las transformaciones del héroe.
        let layout = UICollectionViewFlowLayout() // Diseño en flujo.
        layout.scrollDirection = .horizontal // Desplazamiento horizontal.
        layout.minimumLineSpacing = 16 // Espaciado mínimo entre celdas.
        layout.itemSize = CGSize(width: 120, height: 140) // Tamaño de las celdas.
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        collectionView.backgroundColor = .clear // Fondo transparente.
        collectionView.isHidden = true // Oculta la colección inicialmente.
        collectionView.register(TransformationCell.self, forCellWithReuseIdentifier: "TransformationCell")
        // Registra la celda personalizada `TransformationCell`.
        return collectionView
    }()

    // MARK: - Initializer

    init(hero: HerosModel) {
        // Inicializador que recibe el modelo del héroe.
        super.init(frame: .zero) // Llama al inicializador de la clase base.
        setupViews() // Configura las sub-vistas.
        configure(with: hero) // Configura la vista con los datos del héroe.
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
        addSubview(heroImageView) // Agrega la imagen del héroe.
        addSubview(descriptionTextView) // Agrega la descripción.
        addSubview(transformationsTitleLabel) // Agrega el título de transformaciones.
        addSubview(transformationsCollectionView) // Agrega la colección de transformaciones.

        NSLayoutConstraint.activate([
            // Restricciones para la imagen del encabezado.
            headerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerImageView.heightAnchor.constraint(equalToConstant: 100),

            // Restricciones para la imagen del héroe.
            heroImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 8),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            heroImageView.heightAnchor.constraint(equalTo: heroImageView.widthAnchor, multiplier: 0.6),

            // Restricciones para la descripción.
            descriptionTextView.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 300),

            // Restricciones para el título de transformaciones.
            transformationsTitleLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 8),
            transformationsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            transformationsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            transformationsTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            // Restricciones para la colección de transformaciones.
            transformationsCollectionView.topAnchor.constraint(equalTo: transformationsTitleLabel.bottomAnchor, constant: 10),
            transformationsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            transformationsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            transformationsCollectionView.heightAnchor.constraint(equalToConstant: 120),
            transformationsCollectionView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Configuration

    func configure(with hero: HerosModel) {
        // Configura la vista con los datos del héroe.
        if let url = URL(string: hero.photo) {
            // Verifica que la URL de la imagen sea válida.
            DispatchQueue.global().async {
                // Descarga la imagen en un hilo en segundo plano.
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // Actualiza la interfaz en el hilo principal.
                        self.heroImageView.image = image // Asigna la imagen descargada.
                    }
                }
            }
        }
        descriptionTextView.text = hero.description // Asigna la descripción del héroe.
    }

    func updateTransformations(isHidden: Bool) {
        // Muestra u oculta las transformaciones y su título.
        transformationsTitleLabel.isHidden = isHidden // Oculta/muestra el título.
        transformationsCollectionView.isHidden = isHidden // Oculta/muestra la colección.
    }

    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        // Configura el delegado y la fuente de datos para la colección.
        transformationsCollectionView.delegate = delegate
        transformationsCollectionView.dataSource = dataSource
    }
}
