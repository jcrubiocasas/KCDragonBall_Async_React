//
//  KC_DragonBall_Async_React
//  HTTPResponseCodes.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar constantes y estructuras básicas.

/// Estructura que define los códigos de respuesta HTTP utilizados en la aplicación.
struct HTTPResponseCodes {

    // MARK: - Success Codes

    static let SUCCESS = 200 // Código de éxito para solicitudes completadas correctamente.

    // MARK: - Error Codes

    static let NOT_AUTHORIZED = 401 // Código de error para solicitudes no autorizadas (falta de autenticación).
    static let ERROR = 502 // Código de error para problemas en el servidor o en la puerta de enlace.

    // Esta estructura proporciona un acceso centralizado a los códigos HTTP relevantes en el proyecto.
}
