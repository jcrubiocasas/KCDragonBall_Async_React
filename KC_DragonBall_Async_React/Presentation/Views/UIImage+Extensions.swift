//
//  KC_DragonBall_Async_React
//  UIImage+Extensions.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import UIKit // Importa UIKit para trabajar con componentes gráficos como `UIImageView`.

extension UIImageView { // Extiende la funcionalidad de `UIImageView` para añadir métodos personalizados.
    
    // MARK: - Public Methods
    func loadImageRemote(url: URL) {
        // Método público para cargar una imagen desde una URL de manera asíncrona.
        DispatchQueue.global().async { [weak self] in
            // Cambia al hilo global para realizar operaciones en segundo plano, evitando bloquear el hilo principal.
            if let data = try? Data(contentsOf: url) {
                // Intenta descargar los datos desde la URL y, si falla, no hace nada.
                if let image = UIImage(data: data) {
                    // Intenta convertir los datos descargados en una imagen.
                    DispatchQueue.main.async {
                        // Cambia al hilo principal para actualizar la interfaz de usuario.
                        self?.image = image // Asigna la imagen descargada al `UIImageView`.
                    }
                }
            }
        }
    }
}
