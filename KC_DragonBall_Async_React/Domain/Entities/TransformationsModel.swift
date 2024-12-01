//
//  KC_DragonBall_Async_React
//  TransformationsModel.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import Foundation // Importa Foundation para manejar estructuras básicas y codificación.

/// Modelo que representa una transformación asociada a un héroe.
struct TransformationModel: Codable {

    // MARK: - Properties

    let id: UUID // Identificador único de la transformación.
    let name: String // Nombre de la transformación.
    let description: String // Descripción detallada de la transformación.
    let photo: String // URL de la imagen asociada a la transformación.
    let hero: Hero // Información del héroe asociado a la transformación.

    // `Codable` permite codificar y decodificar automáticamente este modelo desde/para formatos como JSON.
}

/// Modelo que representa un héroe simplificado (usado dentro de `TransformationModel`).
struct Hero: Codable {

    // MARK: - Properties

    let id: UUID // Identificador único del héroe.

    // `Codable` permite codificar y decodificar automáticamente este modelo.
}

/// Modelo utilizado para solicitudes relacionadas con transformaciones.
struct TransformationModelRequest: Codable {

    // MARK: - Properties

    let id: UUID // Identificador único de la transformación solicitada.

    // `Codable` permite codificar y decodificar automáticamente este modelo.
}
