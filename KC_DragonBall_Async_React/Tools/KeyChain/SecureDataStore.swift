//
//  KC_DragonBall_Async_React
//  SecureDataStore.swift
//  Created by Juan Carlos Rubio Casas on 17/11/24.
//

import KeychainSwift // Importa KeychainSwift para facilitar el manejo de datos sensibles.

/// Protocolo que define las operaciones relacionadas con el almacenamiento seguro de datos.
protocol SecureDataStoreProtocol {
    /// Guarda un token en el almacenamiento seguro.
    ///
    /// - Parameter token: El token que se desea guardar.
    func setToken(_ token: String)
    
    /// Recupera un token del almacenamiento seguro.
    ///
    /// - Returns: El token almacenado como `String`, o `nil` si no existe.
    func getToken() -> String?
    
    /// Elimina el token del almacenamiento seguro.
    func deleteToken()
}

/// Clase que implementa el protocolo `SecureDataStoreProtocol` para manejar datos sensibles utilizando Keychain.
class SecureDataStore: SecureDataStoreProtocol {
    
    // MARK: - Properties

    /// Clave utilizada para identificar el token en Keychain.
    private let kToken = "KC_Token"
    
    /// Instancia de KeychainSwift para manejar operaciones con Keychain.
    private let keychain = KeychainSwift()
    
    /// Instancia compartida de `SecureDataStore` para facilitar su uso como singleton.
    static let shared: SecureDataStore = .init()
    
    // MARK: - Token Management

    /// Guarda un token en Keychain.
    ///
    /// - Parameter token: El token que se desea guardar.
    func setToken(_ token: String) {
        keychain.set(token, forKey: kToken) // Guarda el token utilizando la clave `kToken`.
    }
    
    /// Recupera un token desde Keychain.
    ///
    /// - Returns: El token almacenado como `String`, o `nil` si no existe.
    func getToken() -> String? {
        return keychain.get(kToken) // Obtiene el token asociado a la clave `kToken`.
    }
    
    /// Elimina un token del Keychain.
    func deleteToken() {
        keychain.delete(kToken) // Elimina el token asociado a la clave `kToken`.
    }
}
