//
//  KC_DragonBall_Async_React
//  HeroDetailViewController.swift
//  Created by Juan Carlos Rubio Casas on 26/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes gráficos.
import Combine // Importa Combine para manejar la programación reactiva.

final class HeroDetailViewController: UIViewController {
    // Clase final para mostrar los detalles de un héroe seleccionado.

    // MARK: - Properties

    private let hero: HerosModel // Modelo del héroe para mostrar sus detalles.
    public var transformationsViewModel: TransformationsViewModel? // ViewModel para manejar las transformaciones.
    public var heroDetailView: HeroDetailView? // Vista personalizada para los detalles del héroe.
    public var transformations: [TransformationModel] = [] // Array para almacenar las transformaciones del héroe.
    public var subscriptions = Set<AnyCancellable>() // Conjunto de suscripciones para Combine, evitando fugas de memoria.

    // MARK: - Initializer

    init(hero: HerosModel) {
        // Inicializador que recibe un modelo de héroe.
        self.hero = hero // Asigna el héroe recibido al controlador.
        self.transformationsViewModel = TransformationsViewModel() // Inicializa el ViewModel de transformaciones.
        super.init(nibName: nil, bundle: nil) // Llama al inicializador de la clase base.
    }

    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }

    // MARK: - View Lifecycle

    override func loadView() {
        // Método que define la vista principal del controlador.
        heroDetailView = HeroDetailView(hero: hero) // Crea la vista personalizada con los datos del héroe.
        heroDetailView?.setCollectionViewDelegate(self, dataSource: self)
        // Configura la colección con delegado y fuente de datos.
        view = heroDetailView // Asigna la vista personalizada como la vista principal.
    }

    override func viewDidLoad() {
        // Método llamado después de cargar la vista.
        super.viewDidLoad() // Llama a la implementación base.
        setupNavigationBar() // Configura la barra de navegación.
        setupBindings() // Configura los bindings entre el ViewModel y la vista.
        fetchTransformations() // Obtiene las transformaciones del héroe.
    }

    // MARK: - Bindings

    private func setupBindings() {
        // Configura los bindings entre el ViewModel y la vista.
        transformationsViewModel?.$transformationsData
            .receive(on: DispatchQueue.main) // Asegura que las actualizaciones ocurran en el hilo principal.
            .sink { [weak self] transformations in
                // Actualiza las transformaciones cuando cambian en el ViewModel.
                guard let self = self else { return }
                self.transformations = transformations // Asigna las transformaciones al array local.
                self.heroDetailView?.updateTransformations(isHidden: transformations.isEmpty)
                // Muestra u oculta la sección de transformaciones según su contenido.
                self.heroDetailView?.transformationsCollectionView.reloadData()
                // Recarga la colección con los nuevos datos.
            }
            .store(in: &subscriptions) // Almacena la suscripción para evitar fugas de memoria.
    }

    // MARK: - Data Fetching

    public func fetchTransformations() {
        // Obtiene las transformaciones para el héroe.
        Task {
            await transformationsViewModel?.getTransformations(id: hero.id)
            // Llama al método del ViewModel para obtener las transformaciones.
        }
    }

    // MARK: - Navigation Bar

    private func setupNavigationBar() {
        // Configura la barra de navegación.
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(navigateBack)
        ) // Botón para regresar a la vista anterior.
        backButton.tintColor = .white // Define el color del botón como blanco.
        navigationItem.leftBarButtonItem = backButton // Agrega el botón a la barra de navegación.
    }

    @objc public func navigateBack() {
        // Acción para regresar a la vista anterior.
        navigationController?.popViewController(animated: true)
        // Navega hacia atrás en la pila del controlador de navegación.
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Implementación de los delegados y fuente de datos para la colección.

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Retorna el número de transformaciones.
        return transformations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configura y retorna una celda para la colección.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransformationCell", for: indexPath) as? TransformationCell else {
            fatalError("Unable to dequeue TransformationCell")
        }
        let transformation = transformations[indexPath.item] // Obtiene la transformación correspondiente al índice.
        cell.configure(with: transformation) // Configura la celda con los datos de la transformación.
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Método llamado cuando se selecciona un elemento de la colección.
        let transformation = transformations[indexPath.item] // Obtiene la transformación seleccionada.
        let transformationDetailViewController = TransformationDetailViewController(transformation: transformation)
        // Crea un controlador para mostrar los detalles de la transformación.
        navigationController?.pushViewController(transformationDetailViewController, animated: true)
        // Navega al controlador de detalles de la transformación.
    }
}
