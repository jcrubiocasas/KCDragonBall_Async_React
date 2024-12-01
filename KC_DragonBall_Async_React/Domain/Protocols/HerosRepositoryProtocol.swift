//
//  KC_DragonBall_Async_React
//  HerosRepositoryProtocol.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar funciones y estructuras básicas del sistema.

/// Protocolo que define las operaciones relacionadas con el acceso a los datos de héroes.
protocol HerosRepositoryProtocol {

    // MARK: - Methods

    /// Obtiene una lista de héroes según un filtro específico.
    ///
    /// - Parameter filter: Una cadena utilizada para filtrar los héroes (por ejemplo, por nombre o categoría).
    /// - Returns: Un array de objetos `HerosModel` que cumplen con el criterio de búsqueda.
    func getHeros(filter: String) async -> [HerosModel]
}
