//
//  KC_DragonBall_Async_React
//  KeyChainKC.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa Foundation para manejar cadenas y datos.
import Security // Importa Security para trabajar con Keychain.
import KeychainSwift // Importa KeychainSwift para simplificar las operaciones con Keychain.

/// Estructura que encapsula operaciones básicas con Keychain usando la librería KeychainSwift.
public struct KeyChainKC {

    // MARK: - Initializer

    /// Inicializador público.
    public init() {}

    // MARK: - Save

    /// Guarda un valor en el Keychain asociado a una clave específica.
    ///
    /// - Parameters:
    ///   - key: Clave con la que se asociará el valor en el Keychain.
    ///   - value: Valor que se desea almacenar.
    /// - Returns: `true` si la operación fue exitosa, `false` en caso contrario.
    @discardableResult public func saveKC(key: String, value: String) -> Bool {
        if let data = value.data(using: .utf8) { // Convierte el valor en datos UTF-8.
            let keychain = KeychainSwift() // Instancia de KeychainSwift.
            return keychain.set(data, forKey: key) // Intenta guardar los datos en Keychain.
        } else {
            return false // Retorna `false` si no se puede convertir el valor a datos.
        }
    }

    // MARK: - Load

    /// Carga un valor desde el Keychain asociado a una clave específica.
    ///
    /// - Parameter key: Clave con la que se guardó el valor en el Keychain.
    /// - Returns: El valor almacenado como `String` si existe, o una cadena vacía si no se encuentra.
    public func loadKC(key: String) -> String? {
        let keychain = KeychainSwift() // Instancia de KeychainSwift.
        if let data = keychain.get(key) { // Intenta obtener el valor asociado a la clave.
            return data // Retorna el valor si existe.
        } else {
            return "" // Retorna una cadena vacía si no se encuentra.
        }
    }

    // MARK: - Delete

    /// Elimina un valor del Keychain asociado a una clave específica.
    ///
    /// - Parameter key: Clave asociada al valor que se desea eliminar.
    /// - Returns: `true` si la operación fue exitosa, `false` en caso contrario.
    @discardableResult public func deleteKC(key: String) -> Bool {
        let keychain = KeychainSwift() // Instancia de KeychainSwift.
        return keychain.delete(key) // Intenta eliminar el valor asociado a la clave.
    }
}
