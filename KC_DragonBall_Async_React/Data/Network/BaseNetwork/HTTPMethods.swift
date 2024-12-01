//
//  KC_DragonBall_Async_React
//  HTTPMethods.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar strings y estructuras básicas.

/// Estructura que define los métodos HTTP y el tipo de contenido utilizados en las solicitudes de red.
struct HTTPMethods {

    // MARK: - HTTP Methods

    static let post = "POST" // Método HTTP utilizado para enviar datos al servidor.
    static let get = "GET" // Método HTTP utilizado para obtener datos del servidor.
    static let put = "PUT" // Método HTTP utilizado para actualizar recursos en el servidor.
    static let delete = "DELETE" // Método HTTP utilizado para eliminar recursos del servidor.

    // MARK: - Content Type

    static let content = "application/json" // Tipo de contenido utilizado para indicar que los datos están en formato JSON.

    // Esta estructura centraliza los métodos HTTP y el tipo de contenido para ser reutilizados en toda la aplicación.
}
