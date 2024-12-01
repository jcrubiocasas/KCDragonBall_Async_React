//
//  KC_DragonBall_Async_React
//  NetworkTransformations.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import Foundation // Importa Foundation para manejar estructuras básicas, asincronismo y codificación JSON.

/// Protocolo que define las operaciones de red relacionadas con las transformaciones.
protocol NetworkTransformationsProtocol {
    /// Obtiene una lista de transformaciones asociadas a un héroe.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe para filtrar sus transformaciones.
    /// - Returns: Un array de objetos `TransformationModel`.
    func getTransformations(filter: UUID) async -> [TransformationModel]
}

/// Implementación real del protocolo `NetworkTransformationsProtocol` para obtener transformaciones desde la API.
final class NetworkTransformations: NetworkTransformationsProtocol {

    // MARK: - Methods

    /// Obtiene una lista de transformaciones asociadas a un héroe desde el servidor.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe.
    /// - Returns: Un array de objetos `TransformationModel`.
    func getTransformations(filter: UUID) async -> [TransformationModel] {
        var modelReturn = [TransformationModel]() // Resultado de la solicitud.

        // Construcción de la URL del endpoint de transformaciones.
        let urlCad: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.transformations.rawValue)"
        
        // Configuración de la solicitud HTTP.
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post // Método HTTP POST.
        request.httpBody = try? JSONEncoder().encode(TransformationModelRequest(id: filter)) // Cuerpo en formato JSON con el ID del héroe.
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") // Tipo de contenido JSON.

        // Obtención del token JWT desde el KeyChain.
        if let tokenJWT = KeyChainKC().loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization") // Token de autorización.
        }
        
        // Ejecución de la solicitud HTTP.
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let resp = response as? HTTPURLResponse,
               resp.statusCode == HTTPResponseCodes.SUCCESS {
                // Decodificación de los datos recibidos a un array de `TransformationModel`.
                modelReturn = try! JSONDecoder().decode([TransformationModel].self, from: data)
            }
        } catch {
            // Manejo de errores: se retorna un array vacío.
        }
        return modelReturn
    }
}

/// Implementación simulada del protocolo `NetworkTransformationsProtocol` para obtener transformaciones desde un archivo JSON local.
final class NetworkTransformationsFake: NetworkTransformationsProtocol {

    // MARK: - Methods

    /// Obtiene transformaciones desde un archivo JSON local.
    ///
    /// - Parameter filter: El identificador único (`UUID`) del héroe (no utilizado en esta implementación).
    /// - Returns: Un array de objetos `TransformationModel`.
    func getTransformations(filter: UUID) async -> [TransformationModel] {
        return getTransformationsFromJson() // Llama al método para cargar transformaciones desde el JSON.
    }
}

/// Carga transformaciones desde un archivo JSON en el bundle.
func getTransformationsFromJson() -> [TransformationModel] {
    if let url = Bundle.main.url(forResource: "transformations", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url) // Carga los datos desde el archivo.
            let decoder = JSONDecoder()
            return try decoder.decode([TransformationModel].self, from: data) // Decodifica los datos.
        } catch {
            print("Error al decodificar JSON: \(error)")
        }
    }
    return [] // Retorna un array vacío si ocurre un error.
}

/// Proporciona transformaciones hardcodeadas para pruebas.
func getTransformationsHardcoded() -> [TransformationModel] {
    let model1 = TransformationModel(
        id: UUID(),
        name: "1. Oozaru – Gran Mono",
        description: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena...",
        photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp",
        hero: Hero(id: UUID())
    )

    let model2 = TransformationModel(
        id: UUID(),
        name: "2. Kaio-Ken",
        description: "La técnica de Kaio-sama permitía a Goku aumentar su poder de forma exponencial...",
        photo: "https://areajugones.sport.es/wp-content/uploads/2017/05/Goku_Kaio-Ken_Coolers_Revenge.jpg",
        hero: Hero(id: UUID())
    )

    return [model1, model2] // Retorna un array con las transformaciones hardcodeadas.
}
