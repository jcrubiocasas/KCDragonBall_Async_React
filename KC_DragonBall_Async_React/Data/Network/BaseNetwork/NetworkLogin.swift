//
//  KC_DragonBall_Async_React
//  NetworkLogin.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar estructuras básicas y asincronismo.

/// Protocolo que define las operaciones de red relacionadas con el login.
protocol NetworkLoginProtocol {
    /// Realiza el inicio de sesión enviando las credenciales a la API.
    ///
    /// - Parameters:
    ///   - user: Nombre de usuario o correo electrónico.
    ///   - password: Contraseña asociada al usuario.
    /// - Returns: Un token de autenticación en formato `String`.
    func loginApp(user: String, password: String) async -> String
}

/// Implementación real del protocolo `NetworkLoginProtocol` para realizar el login a través de la red.
final class NetworkLogin: NetworkLoginProtocol {

    // MARK: - Methods

    /// Realiza el inicio de sesión enviando las credenciales al servidor real.
    ///
    /// - Parameters:
    ///   - user: Nombre de usuario o correo electrónico.
    ///   - password: Contraseña asociada al usuario.
    /// - Returns: Un token JWT (`String`) en caso de éxito, o una cadena vacía en caso de error.
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT: String = "" // Variable para almacenar el token obtenido.
        
        // Construcción de la URL del endpoint de login.
        let urlString: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.login.rawValue)"
        
        // Codificación de credenciales en formato Base64.
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        
        // Preparación del encabezado de autorización.
        var segCredential: String = ""
        if let credentials = encodeCredentials {
            segCredential = "Basic \(credentials)"
        }
        
        // Creación de la solicitud HTTP.
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethods.post // Método HTTP POST.
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") // Tipo de contenido JSON.
        request.addValue(segCredential, forHTTPHeaderField: "Authorization") // Encabezado de autorización.
        
        // Ejecución de la solicitud.
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let resp = response as? HTTPURLResponse,
               resp.statusCode == HTTPResponseCodes.SUCCESS {
                // Si la respuesta es exitosa, decodifica el token.
                tokenJWT = String(decoding: data, as: UTF8.self)
            }
        } catch {
            // En caso de error, devuelve una cadena vacía.
            tokenJWT = ""
        }
        return tokenJWT
    }
}

/// Implementación simulada del protocolo `NetworkLoginProtocol` para realizar login sin una red real.
final class NetworkLoginFake: NetworkLoginProtocol {

    // MARK: - Methods

    /// Simula el inicio de sesión devolviendo un token UUID aleatorio.
    ///
    /// - Parameters:
    ///   - user: Nombre de usuario o correo electrónico.
    ///   - password: Contraseña asociada al usuario.
    /// - Returns: Un token en formato UUID como `String`.
    func loginApp(user: String, password: String) async -> String {
        return UUID().uuidString // Retorna un token simulado.
    }
}
