//
//  KC_DragonBall_Async_React
//  TransformationViewModel.swift
//  Created by Juan Carlos Rubio Casas on 27/11/24.
//

import Foundation // Importa el módulo Foundation para usar tipos y funcionalidades esenciales de Swift.

final class TransformationsViewModel: ObservableObject { // Define una clase final conforme a `ObservableObject` para la reactividad.

    // MARK: - Published Properties
    @Published var transformationsData: [TransformationModel] = [] // Declara una propiedad observable que publica cambios en un array de `TransformationModel`.

    // MARK: - Private Properties
    private var useCaseTransformation: TransformationsUseCaseProtocol // Propiedad privada para manejar la lógica de negocio a través de un protocolo.

    // MARK: - Initializer
    init(useCase: TransformationsUseCaseProtocol = TransformationUseCase()) { // Inicializador con inyección de dependencia para el caso de uso.
        self.useCaseTransformation = useCase // Asigna el caso de uso proporcionado o el caso de uso por defecto.
        Task { // Crea un contexto asíncrono para ejecutar tareas suspendibles.
            await getTransformations(id: UUID()) // Llama al método `getTransformations` pasando un UUID vacío como ejemplo.
        }
    }
    
    // MARK: - Public Methods
    func processTransformations(_ transformations: [TransformationModel]) -> [TransformationModel] {
        // Método público para procesar una lista de transformaciones eliminando duplicados y ordenando.

        var uniqueTransformationsDict: [String: TransformationModel] = [:] // Crea un diccionario para almacenar transformaciones únicas por `name`.

        for transformation in transformations { // Itera a través de las transformaciones.
            if uniqueTransformationsDict[transformation.name] == nil { // Comprueba si el nombre ya existe en el diccionario.
                uniqueTransformationsDict[transformation.name] = transformation // Si no existe, lo agrega al diccionario.
            }
        }

        let sortedTransformations = uniqueTransformationsDict.values.sorted { a, b in
            // Convierte los valores del diccionario a un array y los ordena por número inicial en el `name`.
            extractLeadingNumber(from: a.name) < extractLeadingNumber(from: b.name) // Compara números extraídos del nombre.
        }

        return sortedTransformations // Retorna las transformaciones únicas y ordenadas.
    }

    // MARK: - Private Methods
    private func extractLeadingNumber(from name: String) -> Int {
        // Extrae el número inicial de una cadena usando una expresión regular.
        let pattern = #"^\d+"# // Define un patrón para encontrar un número al inicio del texto.
        if let range = name.range(of: pattern, options: .regularExpression) {
            // Busca coincidencias en el nombre.
            return Int(name[range]) ?? Int.max // Intenta convertir el número encontrado a entero o retorna un valor alto por defecto.
        }
        return Int.max // Si no se encuentra un número, retorna un valor alto para que quede al final en la ordenación.
    }

    func getTransformations(id: UUID) async {
        // Método público para obtener transformaciones asociadas a un ID.
        let data = await useCaseTransformation.getTransformations(filter: id)
        // Llama al caso de uso para obtener las transformaciones filtradas por el ID.

        let processedData = processTransformations(data)
        // Procesa los datos para eliminar duplicados y ordenarlos.

        DispatchQueue.main.async {
            // Cambia al hilo principal para actualizar la interfaz de usuario.
            self.transformationsData = processedData // Actualiza la propiedad `transformationsData` con los datos procesados.
        }
    }
}
