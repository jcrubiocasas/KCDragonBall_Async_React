//
//  KC_DragonBall_Async_React
//  TransformationDetailViewController.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import UIKit // Importa UIKit para trabajar con la interfaz gráfica.

final class TransformationDetailViewController: UIViewController {
    // Clase final que representa el controlador de vista para mostrar los detalles de una transformación.

    // MARK: - Properties

    private let transformation: TransformationModel
    // Modelo que contiene los datos de la transformación a mostrar.

    // MARK: - Initializer

    init(transformation: TransformationModel) {
        // Inicializador que recibe un modelo de transformación.
        self.transformation = transformation // Asigna la transformación recibida.
        super.init(nibName: nil, bundle: nil) // Llama al inicializador de la clase base.
    }

    required init?(coder: NSCoder) {
        // Inicializador requerido para decodificación (no implementado).
        fatalError("init(coder:) has not been implemented") // Genera un error si se utiliza este inicializador.
    }

    // MARK: - View Lifecycle

    override func loadView() {
        // Define la vista principal del controlador.
        view = TransformationDetailView(transformation: transformation)
        // Asigna una instancia de `TransformationDetailView` configurada con los datos de la transformación.
    }

    override func viewDidLoad() {
        // Método llamado después de que la vista se haya cargado.
        super.viewDidLoad() // Llama a la implementación base.
        setupNavigationBar() // Configura la barra de navegación.
    }

    // MARK: - Navigation Bar

    private func setupNavigationBar() {
        // Configura los elementos de la barra de navegación.
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(navigateBack)
        ) // Botón para regresar a la vista anterior.
        backButton.tintColor = .white // Define el color del botón como blanco.
        navigationItem.leftBarButtonItem = backButton // Agrega el botón a la barra de navegación.
    }

    // MARK: - Actions

    @objc public func navigateBack() {
        // Acción para regresar a la vista anterior.
        navigationController?.popViewController(animated: true)
        // Navega hacia atrás en la pila del controlador de navegación.
    }
}
