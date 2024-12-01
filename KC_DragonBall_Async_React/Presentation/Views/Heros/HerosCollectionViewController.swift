//
//  KC_DragonBall_Async_React
//  HerosCollectionViewController.swift
//  Created by Juan Carlos Rubio Casas on 26/11/24.
//

import UIKit // Importa UIKit para trabajar con la interfaz gráfica.
import Combine // Importa Combine para manejar la programación reactiva.

final class HerosCollectionViewController: UIViewController {
    // Clase final para gestionar el controlador de la colección de héroes.

    // MARK: - Properties
    private var appState: AppState? // Referencia al estado global de la aplicación.
    private var herosViewModel: HerosViewModel // ViewModel que gestiona los datos de héroes.
    private var subscriptions = Set<AnyCancellable>() // Conjunto de suscripciones para Combine, evitando fugas de memoria.
    private var isSearchBarVisible = false // Indica si la barra de búsqueda está visible.
    private var searchString: String = "" // Cadena de texto utilizada como filtro de búsqueda.

    public var herosCollectionView: HerosCollectionView? // Vista personalizada para la colección de héroes.

    // MARK: - Initializer
    init(appState: AppState, viewModel: HerosViewModel) {
        // Inicializador con inyección de dependencias.
        self.appState = appState // Asigna el estado global de la aplicación.
        self.herosViewModel = viewModel // Asigna el ViewModel para los héroes.
        super.init(nibName: nil, bundle: nil) // Llama al inicializador de la clase base.
    }
    
    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }
    
    // MARK: - View Lifecycle
    override func loadView() {
        // Método que define la vista principal del controlador.
        herosCollectionView = HerosCollectionView() // Crea una instancia de la vista personalizada.
        view = herosCollectionView // Asigna la vista personalizada como la vista principal.
    }
    
    override func viewDidLoad() {
        // Método llamado después de que la vista ha sido cargada.
        super.viewDidLoad() // Llama a la implementación base.
        setupNavigationBar() // Configura la barra de navegación.
        setupBindings() // Configura los bindings entre el ViewModel y la vista.
        herosCollectionView?.setupSearchBar(delegate: self) // Configura la barra de búsqueda.
        herosCollectionView?.setupCollectionView(delegate: self, dataSource: self) // Configura la colección de vistas.
    }
    
    override func viewDidLayoutSubviews() {
        // Método llamado después de ajustar las sub-vistas.
        super.viewDidLayoutSubviews() // Llama a la implementación base.
        herosCollectionView?.configureCellLayout(for: view.frame.width)
        // Configura el diseño de las celdas según el ancho de la vista.
    }

    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        // Configura los elementos de la barra de navegación.

        let logoutButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(closeSession)
        ) // Botón para cerrar sesión.
        logoutButton.tintColor = .red // Color rojo para el botón.

        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(toggleSearchBar)
        ) // Botón para mostrar/ocultar la barra de búsqueda.
        searchButton.tintColor = .red // Color rojo para el botón.

        let musicButton = UIBarButtonItem(
            image: UIImage(systemName: "music.note"),
            style: .plain,
            target: self,
            action: #selector(toggleMusic)
        ) // Botón para reproducir/pausar música.
        musicButton.tintColor = .blue // Color azul para el botón.

        navigationItem.leftBarButtonItem = logoutButton // Agrega el botón de cerrar sesión al lado izquierdo.
        navigationItem.rightBarButtonItem = searchButton
        // Agrega los botones de música y búsqueda al lado derecho.
        title = "Lista de Heroes" // Título de la barra de navegación.
    }

    // MARK: - Actions
    @objc private func closeSession() {
        // Acción para cerrar sesión.
        appState?.closeSessionUser() // Llama al método de cerrar sesión en el estado global.
    }
    
    @objc private func toggleSearchBar() {
        // Acción para mostrar/ocultar la barra de búsqueda.
        isSearchBarVisible.toggle() // Cambia el estado de visibilidad de la barra de búsqueda.
        herosCollectionView?.toggleSearchBar(isVisible: isSearchBarVisible)
        // Muestra u oculta la barra de búsqueda según el estado.
    }
    
    @objc private func toggleMusic() {
        // Acción para reproducir/pausar música.
        // Implementar lógica de reproducción de música.
    }

    // MARK: - Bindings
    private func setupBindings() {
        // Configura los bindings entre el ViewModel y la vista.
        herosViewModel.$herosData
            .receive(on: DispatchQueue.main) // Asegura que los eventos se manejen en el hilo principal.
            .sink { [weak self] _ in
                // Actualiza la colección de vistas cuando cambian los datos.
                self?.herosCollectionView?.reloadData()
            }
            .store(in: &subscriptions) // Almacena la suscripción para evitar fugas de memoria.
    }
}

// MARK: - UISearchBarDelegate
extension HerosCollectionViewController: UISearchBarDelegate {
    // Implementación del delegado de la barra de búsqueda.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Método llamado cuando cambia el texto de la barra de búsqueda.
        searchString = searchText // Actualiza la cadena de búsqueda.
        Task {
            await herosViewModel.getHeros(hero: searchString)
            // Llama al ViewModel para filtrar los héroes según la cadena de búsqueda.
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HerosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Implementación de los delegados y fuentes de datos para la colección.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Retorna el número de elementos en la sección.
        return herosViewModel.herosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configura y retorna una celda para la colección.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HerosCell", for: indexPath) as? HerosCollectionViewCell else {
            fatalError("Unable to dequeue HerosCollectionViewCell")
        }
        let hero = herosViewModel.herosData[indexPath.item]
        cell.configure(with: hero) // Configura la celda con los datos del héroe.
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Método llamado cuando se selecciona un elemento de la colección.
        let hero = herosViewModel.herosData[indexPath.item] // Obtiene el héroe seleccionado.
        NSLog("Hero tap => \(hero.name)") // Imprime el nombre del héroe seleccionado en la consola.

        // Navega a la vista de detalles del héroe.
        let heroDetailViewController = HeroDetailViewController(hero: hero)
        navigationController?.pushViewController(heroDetailViewController, animated: true)
    }
}
