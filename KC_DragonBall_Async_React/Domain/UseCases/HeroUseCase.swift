//
//  KC_DragonBall_Async_React
//  HeroUseCase.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar funciones y estructuras básicas del sistema.

/// Protocolo que define las operaciones del caso de uso relacionadas con los héroes.
protocol HerosUseCaseProtocol {

    // MARK: - Properties

    /// Repositorio que implementa las operaciones relacionadas con los héroes.
    var repo: HerosRepositoryProtocol { get set }

    // MARK: - Methods

    /// Obtiene una lista de héroes filtrados según un criterio.
    ///
    /// - Parameter filter: Una cadena utilizada para filtrar los héroes (por ejemplo, por nombre).
    /// - Returns: Un array de objetos `HerosModel` que representan a los héroes encontrados.
    func getHeros(filter: String) async -> [HerosModel]
}

/// Implementación del caso de uso para gestionar héroes reales.
final class HeroUseCase: HerosUseCaseProtocol {

    // MARK: - Properties

    var repo: HerosRepositoryProtocol // Repositorio utilizado para acceder a los datos de los héroes.

    // MARK: - Initializer

    /// Inicializador que permite inyectar un repositorio.
    ///
    /// - Parameter repo: Repositorio a utilizar para las operaciones de héroes (por defecto, `HerosRepository`).
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros())) {
        self.repo = repo // Asigna el repositorio proporcionado o el valor por defecto.
    }

    // MARK: - Methods

    /// Obtiene una lista de héroes filtrados.
    ///
    /// - Parameter filter: Una cadena utilizada para filtrar los héroes.
    /// - Returns: Un array de objetos `HerosModel` que cumplen con el filtro.
    func getHeros(filter: String) async -> [HerosModel] {
        return await repo.getHeros(filter: filter)
        // Llama al método del repositorio para obtener la lista de héroes.
    }
}

/// Implementación del caso de uso para gestionar héroes con datos simulados (fake).
final class HeroUseCaseFake: HerosUseCaseProtocol {

    // MARK: - Properties

    var repo: HerosRepositoryProtocol // Repositorio utilizado para acceder a los datos simulados de los héroes.

    // MARK: - Initializer

    /// Inicializador que permite inyectar un repositorio simulado.
    ///
    /// - Parameter repo: Repositorio a utilizar para las operaciones de héroes (por defecto, `HerosRepository` con red simulada).
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHerosFake())) {
        self.repo = repo // Asigna el repositorio proporcionado o el valor por defecto.
    }

    // MARK: - Methods

    /// Obtiene una lista de héroes filtrados con datos simulados.
    ///
    /// - Parameter filter: Una cadena utilizada para filtrar los héroes simulados.
    /// - Returns: Un array de objetos `HerosModel` que cumplen con el filtro.
    func getHeros(filter: String) async -> [HerosModel] {
        return await repo.getHeros(filter: filter)
        // Llama al método del repositorio simulado para obtener la lista de héroes.
    }
}
