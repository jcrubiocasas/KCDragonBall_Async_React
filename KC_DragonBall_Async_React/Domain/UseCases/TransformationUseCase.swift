//
//  KC_DragonBall_Async_React
//  TransformationUseCase.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import Foundation // Importa Foundation para manejar funciones y estructuras básicas del sistema.

/// Protocolo que define las operaciones del caso de uso relacionadas con las transformaciones.
protocol TransformationsUseCaseProtocol {

    // MARK: - Properties

    /// Repositorio que implementa las operaciones relacionadas con las transformaciones.
    var repo: TransformationsRepositoryProtocol { get set }

    // MARK: - Methods

    /// Obtiene una lista de transformaciones asociadas a un héroe específico.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe para filtrar sus transformaciones.
    /// - Returns: Un array de objetos `TransformationModel` que representan las transformaciones del héroe.
    func getTransformations(filter: UUID) async -> [TransformationModel]
}

/// Implementación del caso de uso para gestionar transformaciones reales.
final class TransformationUseCase: TransformationsUseCaseProtocol {

    // MARK: - Properties

    var repo: TransformationsRepositoryProtocol // Repositorio utilizado para acceder a los datos de transformaciones.

    // MARK: - Initializer

    /// Inicializador que permite inyectar un repositorio.
    ///
    /// - Parameter repo: Repositorio a utilizar para las operaciones de transformaciones (por defecto, `TransformationsRepository`).
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformations())) {
        self.repo = repo // Asigna el repositorio proporcionado o el valor por defecto.
    }

    // MARK: - Methods

    /// Obtiene una lista de transformaciones asociadas a un héroe específico.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe para filtrar las transformaciones.
    /// - Returns: Un array de objetos `TransformationModel` que representan las transformaciones del héroe.
    func getTransformations(filter: UUID) async -> [TransformationModel] {
        return await repo.getTransformations(filter: filter)
        // Llama al método del repositorio para obtener las transformaciones.
    }
}

/// Implementación del caso de uso para gestionar transformaciones con datos simulados (fake).
final class TransformationsUseCaseFake: TransformationsUseCaseProtocol {

    // MARK: - Properties

    var repo: TransformationsRepositoryProtocol // Repositorio utilizado para acceder a los datos simulados de transformaciones.

    // MARK: - Initializer

    /// Inicializador que permite inyectar un repositorio simulado.
    ///
    /// - Parameter repo: Repositorio a utilizar para las operaciones de transformaciones (por defecto, `TransformationsRepository` con red simulada).
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformationsFake())) {
        self.repo = repo // Asigna el repositorio proporcionado o el valor por defecto.
    }

    // MARK: - Methods

    /// Obtiene una lista de transformaciones asociadas a un héroe específico con datos simulados.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe para filtrar las transformaciones.
    /// - Returns: Un array de objetos `TransformationModel` que representan las transformaciones simuladas del héroe.
    func getTransformations(filter: UUID) async -> [TransformationModel] {
        return await repo.getTransformations(filter: filter)
        // Llama al método del repositorio simulado para obtener las transformaciones.
    }
}
