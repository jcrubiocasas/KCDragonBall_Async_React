//
//  KC_DragonBall_Async_React
//  NetworkHeros.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar estructuras básicas, asincronismo y codificación JSON.

/// Protocolo que define las operaciones de red relacionadas con los héroes.
protocol NetworkHerosProtocol {
    /// Obtiene una lista de héroes filtrados según el nombre.
    ///
    /// - Parameter filter: Nombre o parte del nombre para filtrar los héroes.
    /// - Returns: Un array de objetos `HerosModel`.
    func getHeros(filter: String) async -> [HerosModel]
}

/// Implementación real del protocolo `NetworkHerosProtocol` para obtener héroes desde la API.
final class NetworkHeros: NetworkHerosProtocol {

    // MARK: - Methods

    /// Obtiene una lista de héroes filtrados llamando al servidor.
    ///
    /// - Parameter filter: Nombre o parte del nombre para filtrar los héroes.
    /// - Returns: Un array de objetos `HerosModel`.
    func getHeros(filter: String) async -> [HerosModel] {
        var modelReturn = [HerosModel]() // Resultado de la solicitud.

        // Construcción de la URL del endpoint de héroes.
        let urlCad: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.heros.rawValue)"
        
        // Configuración de la solicitud HTTP.
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post // Método HTTP POST.
        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter)) // Cuerpo con filtro en formato JSON.
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
                // Decodificación de los datos recibidos a un array de `HerosModel`.
                modelReturn = try! JSONDecoder().decode([HerosModel].self, from: data)
            }
        } catch {
            // Manejo de errores: se retorna un array vacío.
        }
        return modelReturn
    }
}

/// Implementación simulada del protocolo `NetworkHerosProtocol` para obtener héroes desde un archivo JSON local.
final class NetworkHerosFakeJSON: NetworkHerosProtocol {

    // MARK: - Methods

    /// Obtiene héroes desde un archivo JSON local.
    ///
    /// - Parameter filter: Nombre o parte del nombre para filtrar los héroes (no utilizado en esta implementación).
    /// - Returns: Un array de objetos `HerosModel`.
    func getHeros(filter: String) async -> [HerosModel] {
        return getHerosFromJson() // Llama al método para cargar héroes desde el JSON.
    }
}

/// Carga héroes desde un archivo JSON en el bundle.
func getHerosFromJson() -> [HerosModel] {
    if let url = Bundle.main.url(forResource: "heros", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url) // Carga los datos desde el archivo.
            let decoder = JSONDecoder()
            return try decoder.decode([HerosModel].self, from: data) // Decodifica los datos.
        } catch {
            print("Error al decodificar JSON: \(error)")
        }
    }
    return [] // Retorna un array vacío si ocurre un error.
}

/// Implementación simulada del protocolo `NetworkHerosProtocol` para obtener héroes hardcodeados.
final class NetworkHerosFake: NetworkHerosProtocol {

    // MARK: - Methods

    /// Obtiene héroes hardcodeados.
    ///
    /// - Parameter filter: Nombre o parte del nombre para filtrar los héroes (no utilizado en esta implementación).
    /// - Returns: Un array de objetos `HerosModel`.
    func getHeros(filter: String) async -> [HerosModel] {
        return getHerosHardcoded() // Llama al método para obtener héroes hardcodeados.
    }
}

/// Proporciona héroes hardcodeados para pruebas.
func getHerosHardcoded() -> [HerosModel] {
    let model1 = HerosModel(
        id: UUID(),
        favorite: true,
        description: "Sobran las presentaciones cuando se habla de Goku...",
        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
        name: "Goku"
    )

    let model2 = HerosModel(
        id: UUID(),
        favorite: true,
        description: "Vegeta es todo lo contrario. Es arrogante...",
        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
        name: "Vegeta"
    )

    return [model1, model2] // Retorna un array con los héroes hardcodeados.
}
