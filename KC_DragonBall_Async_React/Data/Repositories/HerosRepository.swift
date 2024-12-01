//
//  KC_DragonBall_Async_React
//  HerosRepository.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar funciones básicas y asincronismo.

/// Repositorio que implementa las operaciones reales relacionadas con los héroes.
final class HerosRepository: HerosRepositoryProtocol {

    // MARK: - Properties

    private var network: NetworkHerosProtocol // Protocolo de red utilizado para manejar las solicitudes de héroes.

    // MARK: - Initializer

    /// Inicializador que permite inyectar una capa de red.
    ///
    /// - Parameter network: Capa de red que implementa `NetworkHerosProtocol`.
    init(network: NetworkHerosProtocol) {
        self.network = network // Asigna la capa de red proporcionada.
    }

    // MARK: - Methods

    /// Obtiene una lista de héroes filtrados llamando a la capa de red.
    ///
    /// - Parameter filter: Una cadena utilizada para filtrar los héroes (por ejemplo, por nombre).
    /// - Returns: Un array de objetos `HerosModel` que cumplen con el criterio de búsqueda.
    func getHeros(filter: String) async -> [HerosModel] {
        return await network.getHeros(filter: filter)
        // Llama al método de la capa de red para obtener los héroes.
    }
}

/// Repositorio que implementa operaciones simuladas (fake) relacionadas con los héroes.
final class HerosRepositoryFake: HerosRepositoryProtocol {

    // MARK: - Properties

    private var network: NetworkHerosProtocol // Capa de red simulada utilizada para manejar las solicitudes de héroes.

    // MARK: - Initializer

    /// Inicializador que permite inyectar una capa de red simulada.
    ///
    /// - Parameter network: Capa de red que implementa `NetworkHerosProtocol` (por defecto, `NetworkHerosFakeJSON`).
    init(network: NetworkHerosProtocol = NetworkHerosFakeJSON()) {
        self.network = network // Asigna la capa de red proporcionada o usa la simulada por defecto.
    }

    // MARK: - Methods

    /// Obtiene una lista de héroes filtrados llamando a la capa de red simulada.
    ///
    /// - Parameter filter: Una cadena utilizada para filtrar los héroes (por ejemplo, por nombre).
    /// - Returns: Un array de objetos `HerosModel` que cumplen con el criterio de búsqueda simulado.
    func getHeros(filter: String) async -> [HerosModel] {
        return await network.getHeros(filter: filter)
        // Llama al método de la capa de red simulada para obtener los héroes.
    }
}
