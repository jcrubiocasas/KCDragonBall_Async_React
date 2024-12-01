//
//  KC_DragonBall_Async_React
//  HeroesModel.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar codificación, decodificación y estructuras básicas.

/// Modelo que representa un héroe en la aplicación.
struct HerosModel: Codable {

    // MARK: - Properties

    let id: UUID // Identificador único del héroe.
    let favorite: Bool // Indica si el héroe está marcado como favorito.
    let description: String // Descripción detallada del héroe.
    let photo: String // URL de la imagen asociada al héroe.
    let name: String // Nombre del héroe.

    // `Codable` permite codificar y decodificar automáticamente el modelo desde/para formatos como JSON.
}

/// Modelo utilizado para solicitudes relacionadas con héroes.
struct HeroModelRequest: Codable {

    // MARK: - Properties

    let name: String // Nombre del héroe solicitado.

    // `Codable` permite codificar y decodificar automáticamente este modelo.
}
