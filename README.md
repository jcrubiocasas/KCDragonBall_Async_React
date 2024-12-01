Aplicación Dragon Ball modulo asincronismo y reactividad.

Funcionalidad

La app implementa las siguientes funcionalidades principales:
    1.    Login:
    •    Autenticación mediante usuario y contraseña.
    •    Manejo seguro del token JWT utilizando Keychain.
    2.    Listado de Héroes:
    •    Visualización de una lista de héroes obtenidos desde la API.
    •    Uso de UICollectionView con un diseño responsivo para dispositivos de diferentes tamaños.
    •    Posibilidad de búsqueda en tiempo real utilizando UISearchBar.
    3.    Transformaciones de un Héroe:
    •    Vista de detalles de cada héroe seleccionado.
    •    Visualización de las transformaciones asociadas al héroe.
    •    Navegación entre vistas utilizando UINavigationController.

Requerimientos Técnicos Implementados

    •    Arquitectura MVVM:
La app sigue el patrón de diseño MVVM, separando las responsabilidades de las capas:
    •    Vista: Manejo de la interfaz de usuario (LoginView, HeroDetailView, HerosCollectionView, etc.).
    •    Dominio: Lógica central gestionada por los casos de uso (LoginUseCase, HeroUseCase, TransformationUseCase).
    •    Repositorio: Comunicación con la API o datos locales (NetworkLogin, NetworkHeros, NetworkTransformations).
    •    Programación Reactiva:
    •    Se utiliza Combine para el binding entre las capas ViewModel y View.
    •    CombineCocoa es usado para manejar interacciones como botones y campos de texto en el login.
    •    Internacionalización:
    •    Todos los literales están traducidos al español e inglés utilizando Localizable.strings.
    •    Pruebas:
    •    Cobertura mínima de pruebas del 60%.
    •    Implementación de tests utilizando versiones “fake” de repositorios y redes para validar la lógica de los casos de uso y las respuestas de la API.
    •    UI sin Storyboards:
    •    Toda la interfaz de usuario se desarrolla utilizando XIB y código, eliminando la dependencia de Storyboards.
    •    Asincronismo:
    •    Las llamadas de red se gestionan con async/await.

Componentes Destacados

Capas y Componentes Clave

    1.    Vista:
    •    HeroDetailView muestra detalles del héroe, incluyendo imagen, descripción y transformaciones.
    •    HerosCollectionView maneja la lista de héroes con un diseño fluido y búsqueda.
    2.    Dominio:
    •    Casos de uso como LoginUseCase, HeroUseCase y TransformationUseCase encapsulan la lógica del negocio.
    3.    Repositorio:
    •    NetworkHeros, NetworkLogin, y NetworkTransformations gestionan las interacciones con la API, mientras que sus versiones fake (Fake) permiten pruebas unitarias.

Herramientas Utilizadas

    •    Combine para observación reactiva.
    •    KeychainSwift para el manejo seguro de tokens.
    •    JSONDecoder/Encoder para la serialización y deserialización de datos.

Pruebas Realizadas

Se realizaron pruebas unitarias sobre:
    •    Los casos de uso LoginUseCase, HeroUseCase y TransformationUseCase utilizando repositorios falsos.
    •    Validación del correcto manejo de la capa de red mediante NetworkHerosFake y NetworkTransformationsFake.
    •    La lógica de las vistas como HeroDetailView y HerosCollectionView, asegurando que responden correctamente a los cambios en los ViewModel.

Ejecución del Proyecto

    1.    Clona este repositorio.
    2.    Asegúrate de tener Xcode instalado.
    3.    Instala dependencias usando CocoaPods si es necesario:
    pod install
    4.    Abre el proyecto en Xcode y compílalo.
    5.    Ejecuta el proyecto en un simulador o dispositivo físico.

Contribuciones

Este proyecto es una práctica académica, pero si encuentras errores o tienes sugerencias, ¡no dudes en abrir un issue o pull request!

Créditos

    •    Autor: Juan Carlos Rubio Casas
    •    Contacto: rubiocasasjuancarlos@gmail.es 
    
