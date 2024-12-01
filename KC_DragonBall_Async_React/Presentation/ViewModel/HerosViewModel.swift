//
//  KC_DragonBall_Async_React
//  HerosViewModel.swift
//  Created by Juan Carlos Rubio Casas on 24/11/24.
//

import Foundation // Importa el módulo Foundation para trabajar con tipos básicos y funcionalidades esenciales.

final class HerosViewModel: ObservableObject { // Define una clase final para evitar que sea heredada y la hace conforme a `ObservableObject` para la reactividad.

    // MARK: - Published Properties
    @Published var herosData = [HerosModel]() // Declara una propiedad observable que publica cambios en un array de `HerosModel`.

    // MARK: - Private Properties
    private var useCaseHeros: HerosUseCaseProtocol // Define una propiedad privada para manejar la lógica de negocio a través de un protocolo.

    // MARK: - Initializer
    init(useCase: HerosUseCaseProtocol = HeroUseCase()) { // Inicializador que inyecta una dependencia con un caso de uso por defecto.
        self.useCaseHeros = useCase // Asigna el caso de uso proporcionado o el caso de uso por defecto.
        Task { // Crea un contexto asíncrono para ejecutar tareas suspendibles.
            await getHeros(hero: "") // Llama al método `getHeros` pasando una cadena vacía como filtro.
        }
    }
    
    // MARK: - Public Methods
    func getHeros(hero: String) async { // Define un método asíncrono para obtener héroes filtrados por nombre.
        let data = await useCaseHeros.getHeros(filter: hero) // Llama al método asíncrono del caso de uso para obtener datos de héroes.
        
        DispatchQueue.main.async { // Cambia al hilo principal para actualizar la interfaz de usuario.
            self.herosData = data // Actualiza la propiedad observable `herosData` con los datos obtenidos.
        }
    }
}
