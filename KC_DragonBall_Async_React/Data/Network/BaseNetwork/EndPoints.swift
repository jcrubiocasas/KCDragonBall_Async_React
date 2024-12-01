//
//  KC_DragonBall_Async_React
//  EndPoints.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar strings y estructuras básicas.

/// Enum que define los endpoints utilizados en las solicitudes de red de la aplicación.
enum EndPoints: String {

    // MARK: - Cases

    case login = "/api/auth/login" // Endpoint para realizar el inicio de sesión.
    case heros = "/api/heros/all" // Endpoint para obtener la lista de héroes.
    case transformations = "/api/heros/tranformations" // Endpoint para obtener las transformaciones de los héroes.

    // Este enum permite un fácil acceso a las rutas de la API utilizadas en el proyecto.
}
