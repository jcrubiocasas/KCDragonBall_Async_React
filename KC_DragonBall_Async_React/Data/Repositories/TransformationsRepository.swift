//
//  KC_DragonBall_Async_React
//  TransformationsRepository.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import Foundation // Importa Foundation para manejar funciones básicas y asincronismo.

/// Repositorio que implementa las operaciones reales relacionadas con las transformaciones.
final class TransformationsRepository: TransformationsRepositoryProtocol {

    // MARK: - Properties

    private var network: NetworkTransformationsProtocol // Protocolo de red utilizado para manejar las solicitudes de transformaciones.

    // MARK: - Initializer

    /// Inicializador que permite inyectar una capa de red.
    ///
    /// - Parameter network: Capa de red que implementa `NetworkTransformationsProtocol`.
    init(network: NetworkTransformationsProtocol) {
        self.network = network // Asigna la capa de red proporcionada.
    }

    // MARK: - Methods

    /// Obtiene una lista de transformaciones asociadas a un héroe llamando a la capa de red.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe para filtrar sus transformaciones.
    /// - Returns: Un array de objetos `TransformationModel` que representan las transformaciones del héroe.
    func getTransformations(filter: UUID) async -> [TransformationModel] {
        return await network.getTransformations(filter: filter)
        // Llama al método de la capa de red para obtener las transformaciones.
    }
}

/// Repositorio que implementa operaciones simuladas (fake) relacionadas con las transformaciones.
final class TransformationsRepositoryFake: TransformationsRepositoryProtocol {

    // MARK: - Properties

    private var network: NetworkTransformationsProtocol // Capa de red simulada utilizada para manejar las solicitudes de transformaciones.

    // MARK: - Initializer

    /// Inicializador que permite inyectar una capa de red simulada.
    ///
    /// - Parameter network: Capa de red que implementa `NetworkTransformationsProtocol` (por defecto, `NetworkTransformationsFake`).
    init(network: NetworkTransformationsProtocol = NetworkTransformationsFake()) {
        self.network = network // Asigna la capa de red proporcionada o usa la simulada por defecto.
    }

    // MARK: - Methods

    /// Obtiene una lista de transformaciones asociadas a un héroe llamando a la capa de red simulada.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe para filtrar sus transformaciones.
    /// - Returns: Un array de objetos `TransformationModel` que representan las transformaciones simuladas del héroe.
    func getTransformations(filter: UUID) async -> [TransformationModel] {
        return await network.getTransformations(filter: filter)
        // Llama al método de la capa de red simulada para obtener las transformaciones.
    }
}
