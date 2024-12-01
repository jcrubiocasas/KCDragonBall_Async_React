//
//  KC_DragonBall_Async_React
//  TransformationsRepositoryProtocol.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import Foundation // Importa Foundation para manejar funciones y estructuras básicas del sistema.

/// Protocolo que define las operaciones relacionadas con el acceso a los datos de transformaciones.
protocol TransformationsRepositoryProtocol {

    // MARK: - Methods

    /// Obtiene una lista de transformaciones asociadas a un héroe específico.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe para filtrar sus transformaciones.
    /// - Returns: Un array de objetos `TransformationModel` que representan las transformaciones del héroe.
    func getTransformations(filter: UUID) async -> [TransformationModel]
}
