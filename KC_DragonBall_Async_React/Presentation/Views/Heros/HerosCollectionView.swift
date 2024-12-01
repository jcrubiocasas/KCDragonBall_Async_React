//
//  KC_DragonBall_Async_React
//  HerosCollectionView.swift
//  Created by Juan Carlos Rubio Casas on 26/11/24.
//

import UIKit // Importa UIKit para trabajar con vistas y componentes gráficos.

final class HerosCollectionView: UIView {
    // Clase final que representa la vista personalizada para mostrar la colección de héroes.

    // MARK: - UI Components

    public let searchBar: UISearchBar = {
        // Barra de búsqueda para filtrar héroes.
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar héroe" // Placeholder con el texto inicial.
        searchBar.isHidden = true // Oculta la barra de búsqueda inicialmente.
        searchBar.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        return searchBar
    }()
    
    public let collectionView: UICollectionView = {
        // Vista de colección para mostrar héroes en formato grid.
        let layout = UICollectionViewFlowLayout()
        // Define un diseño en flujo para la colección.
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        // Define márgenes para las secciones.
        layout.minimumLineSpacing = 16 // Espaciado mínimo entre filas.
        layout.minimumInteritemSpacing = 16 // Espaciado mínimo entre columnas.
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Crea la colección con el diseño definido.
        collectionView.translatesAutoresizingMaskIntoConstraints = false // Desactiva restricciones automáticas.
        collectionView.backgroundColor = .black // Establece el fondo negro.
        collectionView.register(HerosCollectionViewCell.self, forCellWithReuseIdentifier: "HerosCell")
        // Registra la celda personalizada `HerosCollectionViewCell`.
        return collectionView
    }()
    
    private var collectionViewTopConstraint: NSLayoutConstraint!
    // Restricción para manejar la posición de la colección según el estado de la barra de búsqueda.

    // MARK: - Initializer

    override init(frame: CGRect) {
        // Inicializador principal de la vista.
        super.init(frame: frame) // Llama al inicializador de la clase base.
        setupViews() // Configura las vistas y sus restricciones.
    }
    
    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }
    
    // MARK: - Setup

    private func setupViews() {
        // Configura las sub-vistas iniciales y define sus restricciones.
        backgroundColor = .white // Asigna un fondo blanco a la vista principal.
        addSubview(searchBar) // Agrega la barra de búsqueda como sub-vista.
        addSubview(collectionView) // Agrega la colección como sub-vista.
        
        collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        // Define la restricción superior de la colección relativa a la barra de búsqueda.

        NSLayoutConstraint.activate([
            // Restricciones para la barra de búsqueda.
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), // Ubica la barra en la parte superior del área segura.
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor), // Alinea la barra al borde izquierdo.
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor), // Alinea la barra al borde derecho.
            
            // Restricciones para la colección.
            collectionViewTopConstraint, // Aplica la restricción superior.
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor), // Alinea la colección al borde izquierdo.
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor), // Alinea la colección al borde derecho.
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor) // Ubica la colección en la parte inferior.
        ])
    }
    
    // MARK: - Configuration Methods

    func setupSearchBar(delegate: UISearchBarDelegate) {
        // Configura la barra de búsqueda con un delegado.
        searchBar.delegate = delegate
    }
    
    func setupCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        // Configura la colección con un delegado y una fuente de datos.
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func configureCellLayout(for width: CGFloat) {
        // Configura el diseño de las celdas según el ancho de la pantalla.
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidth = (width - 48) / 2 // Calcula el ancho de cada celda (dos columnas con márgenes).
        let cellHeight = cellWidth * 1.5 * 0.90 // Calcula la altura de la celda con un ajuste proporcional.
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight) // Asigna el tamaño de las celdas.
    }
    
    func toggleSearchBar(isVisible: Bool) {
        // Muestra u oculta la barra de búsqueda.
        searchBar.isHidden = !isVisible // Cambia la visibilidad de la barra.
        collectionViewTopConstraint.constant = isVisible ? 56 : 0 // Ajusta la posición de la colección según la visibilidad.
        UIView.animate(withDuration: 0.3) {
            // Anima la transición al cambiar la visibilidad.
            self.layoutIfNeeded()
        }
    }
    
    func reloadData() {
        // Recarga los datos de la colección.
        collectionView.reloadData()
    }
}
