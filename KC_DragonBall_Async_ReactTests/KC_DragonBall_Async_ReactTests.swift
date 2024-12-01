//
//  KC_DragonBall_Async_ReactTests.swift
//  KC_DragonBall_Async_ReactTests
//
//  Created by Juan Carlos Rubio Casas on 30/11/24.
//

// NOTA IMPORTANTE: Los test esta en español
// Si algun tecto falla, seguramente es por estar ejecutandose en ingles

import XCTest
import Combine
import CombineCocoa
import UIKit
@testable import KC_DragonBall_Async_React

 final class KC_DragonBall_Async_ReactTests: XCTestCase {
 
 override func setUpWithError() throws {
  }
 
 override func tearDownWithError() throws {
 }
 
 func testExample() throws {
 }
 
 func testPerformanceExample() throws {
     measure {
 
     }
 }
 
 func testKeyChainLibrary() throws {
 let KC = KeyChainKC()
 XCTAssertNotNil(KC)
 
 let save = KC.saveKC(key: "Test", value: "123")
 XCTAssertEqual(save, true)
 
 let value = KC.loadKC(key: "Test")
 if let valor = value {
 XCTAssertEqual(valor, "123")
 }
 XCTAssertNoThrow(KC.deleteKC(key: "Test"))
 }
 
 func testLoginFake() async throws {
 let KC = KeyChainKC()
 XCTAssertNotNil(KC)
 
 
 let obj = LoginUseCaseFake()
 XCTAssertNotNil(obj)
 
 //Validate Token
 let resp = await obj.validateToken()
 XCTAssertEqual(resp, true)
 
 
 // login
 let loginDo = await obj.loginApp(user: "", password: "")
 XCTAssertEqual(loginDo, true)
 var jwt = KC.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
 XCTAssertNotEqual(jwt, "")
 
 //Close Session
 await obj.logout()
 jwt = KC.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
 XCTAssertEqual(jwt, "")
 }
 
 func testLoginReal() async throws  {
 let CK = KeyChainKC()
 XCTAssertNotNil(CK)
 //reset the token
 CK.saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: "")
 
 //Caso se uso con repo Fake
 let userCase = LoginUseCase(repo: LoginRepositoryFake())
 XCTAssertNotNil(userCase)
 
 //validacion
 let resp = await userCase.validateToken()
 XCTAssertEqual(resp, false)
 
 //login
 let loginDo = await userCase.loginApp(user: "", password: "")
 XCTAssertEqual(loginDo, true)
 var jwt = CK.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
 XCTAssertNotEqual(jwt, "")
 
 //Close Session
 await userCase.logout()
 jwt = CK.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
 XCTAssertEqual(jwt, "")
 }
 
 func testLoginAutoLoginAsincrono()  throws  {
 var suscriptor = Set<AnyCancellable>()
 let exp = self.expectation(description: "Login Auto ")
 
 let vm = AppState(loginUseCase: LoginUseCaseFake())
 XCTAssertNotNil(vm)
 
 vm.$statusLogin
 .sink { completion in
 switch completion{
 
 case .finished:
 print("finalizado")
 }
 } receiveValue: { estado in
 print("Recibo estado \(estado)")
 if estado == .success {
 exp.fulfill()
 }
 }
 .store(in: &suscriptor)
 
 vm.validateControlLogin()
 
 self.waitForExpectations(timeout: 10)
 }
 
 
 
 // LoginView
 func testUILoginView()  throws  {
 XCTAssertNoThrow(LoginView())
 let view = LoginView()
 XCTAssertNotNil(view)
 
 let headerImage =   view.getHeaderImageView()
 XCTAssertNotNil(headerImage)
 let logoImage =   view.getLogoImageView()
 XCTAssertNotNil(logoImage)
 let txtEmail = view.getEmailTextField()
 XCTAssertNotNil(txtEmail)
 let txtPass = view.getPasswordTextField()
 XCTAssertNotNil(txtPass)
 let button = view.getLoginButton()
 XCTAssertNotNil(button)
 let error = view.getErrorLabel()
 XCTAssertNotNil(error)
 
 XCTAssertEqual(txtEmail.placeholder, "Correo electrónico")
 XCTAssertEqual(txtPass.placeholder, "Clave")
 XCTAssertEqual(button.titleLabel?.text, "Entrar")
 
 //la vista esta generada
 let View2 =  LoginViewController(appState: AppState(loginUseCase: LoginUseCaseFake()))
 XCTAssertNotNil(View2)
 XCTAssertNoThrow(View2.loadView()) //generamos la vista
 XCTAssertNotNil(View2.header)
 XCTAssertNotNil(View2.logo)
 XCTAssertNotNil(View2.emailTextfield)
 XCTAssertNotNil(View2.passwordTextfield)
 XCTAssertNotNil(View2.loginButton)
 //el binding
 XCTAssertNoThrow(View2.setupBindings())
 
 View2.emailTextfield?.text = "Hola"
 //el boton debe estar desactivado
 XCTAssertEqual(View2.emailTextfield?.text, "Hola")
 }
  // ErrorView
 func testUIErrorView() {
 // Inicializamos la vista
 let errorView = ErrorView()
 XCTAssertNotNil(errorView)
 
 // Validamos que los subcomponentes no sean nulos
 XCTAssertNotNil(errorView.getErrorHeaderImageView())
 XCTAssertNotNil(errorView.errorLabel)
 XCTAssertNotNil(errorView.backButton)
 
 // Verificamos configuraciones iniciales
 XCTAssertEqual(errorView.backButton.title(for: .normal), "Volver") // Botón debe decir "Back"
 XCTAssertEqual(errorView.errorLabel.textColor, .red) // Color de texto de error
 XCTAssertTrue(errorView.errorLabel.text?.isEmpty ?? true) // Por defecto, no debe tener texto
 
 // Establecer texto de error y validar
 let errorMessage = "This is a test error"
 errorView.setErrorText(errorMessage)
 XCTAssertEqual(errorView.errorLabel.text, errorMessage)
 
 // Validar jerarquía de subcomponentes
 let subviews = errorView.subviews
 XCTAssertTrue(subviews.contains(errorView.getErrorHeaderImageView()))
 XCTAssertTrue(subviews.contains(where: { $0 is UIStackView })) // StackView debe estar presente
 }
 
 // HerosCollectionView
 func testHerosCollectionView_Initialization() {
 // Inicializamos la vista
 let herosCollectionView = HerosCollectionView()
 XCTAssertNotNil(herosCollectionView)
 
 // Verificamos que los subcomponentes no sean nulos
 XCTAssertNotNil(herosCollectionView.searchBar)
 XCTAssertNotNil(herosCollectionView.collectionView)
 
 // Validar configuración inicial
 XCTAssertTrue(herosCollectionView.searchBar.isHidden) // SearchBar debe estar oculto por defecto
 XCTAssertEqual(herosCollectionView.collectionView.backgroundColor, .black)
 }
 
 func testHerosCollectionView_ToggleSearchBar() {
 let herosCollectionView = HerosCollectionView()
 XCTAssertTrue(herosCollectionView.searchBar.isHidden) // Inicialmente oculto
 
 // Simular mostrar el SearchBar
 herosCollectionView.toggleSearchBar(isVisible: true)
 XCTAssertFalse(herosCollectionView.searchBar.isHidden)
 
 // Simular ocultar el SearchBar
 herosCollectionView.toggleSearchBar(isVisible: false)
 XCTAssertTrue(herosCollectionView.searchBar.isHidden)
 }
 
 func testHerosCollectionView_ReloadData() {
 let herosCollectionView = HerosCollectionView()
 XCTAssertNoThrow(herosCollectionView.reloadData()) // Debe ejecutarse sin errores
 }
 
 func testUIHerosCollectionViewController() throws {
 // Inicializamos los datos necesarios
 let appState = AppState()
 let herosViewModel = HerosViewModel()
 
 // Agregamos datos al ViewModel
 let testHero = HerosModel(id: UUID(),
 favorite: false,
 description: "",
 photo: "https://example.com/goku.jpg",
 name: "Goku")
 herosViewModel.herosData = [testHero]
 
 // Inicializamos el controlador con el estado y el ViewModel
 let herosController = HerosCollectionViewController(appState: appState, viewModel: herosViewModel)
 XCTAssertNotNil(herosController)
 
 // Envolvemos el controlador en un UINavigationController
 let navigationController = UINavigationController(rootViewController: herosController)
 XCTAssertNotNil(navigationController)
 
 // Cargar la vista
 herosController.loadViewIfNeeded()
 
 // Validar que la vista y sus subcomponentes están correctamente configurados
 XCTAssertNotNil(herosController.herosCollectionView)
 XCTAssertNotNil(herosController.herosCollectionView?.collectionView)
 XCTAssertNotNil(herosController.herosCollectionView?.searchBar)
 
 // Validar configuración inicial
 XCTAssertEqual(herosController.navigationItem.title, "Lista de Heroes")
 XCTAssertTrue(herosController.herosCollectionView?.searchBar.isHidden ?? false)
 
 // Simular la recarga de datos en la colección
 herosController.herosCollectionView?.reloadData()
 XCTAssertEqual(herosViewModel.herosData.count, 1) // Un héroe agregado
 
 // Obtener celda y verificar que está configurada correctamente
 let collectionView = herosController.herosCollectionView!.collectionView
 let cell = try XCTUnwrap(collectionView.dataSource?.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? HerosCollectionViewCell)
 XCTAssertEqual(cell.nameLabel.text, "Goku")
 
 // Simular selección de un héroe en la colección
 herosController.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
 
 // Validar que la navegación se ejecutó
 XCTAssertNotNil(navigationController.topViewController as? HeroDetailViewController)
 }
 
 // HeroDetailView
 func testHeroDetailView_Initialization() {
 // Crear un héroe de prueba
 let hero = HerosModel(id: UUID(),
 favorite: false,
 description: "El guerrero más fuerte",
 photo: "https://example.com/goku.jpg",
 name: "Goku")
 
 // Inicializar la vista
 let detailView = HeroDetailView(hero: hero)
 XCTAssertNotNil(detailView)
 
 // Verificar subcomponentes
 XCTAssertNotNil(detailView.heroImageView)
 XCTAssertNotNil(detailView.descriptionTextView)
 XCTAssertNotNil(detailView.transformationsCollectionView)
 
 // Verificar estilos iniciales
 XCTAssertTrue(detailView.transformationsCollectionView.isHidden) // Oculta por defecto
 XCTAssertTrue(detailView.transformationsTitleLabel.isHidden)    // Oculta por defecto
 }
 
 func testHeroDetailView_Configuration() {
 // Crear un héroe de prueba
 let hero = HerosModel(id: UUID(),
 favorite: false,
 description: "El guerrero más fuerte",
 photo: "https://example.com/goku.jpg",
 name: "Goku")
 
 // Inicializar la vista
 let detailView = HeroDetailView(hero: hero)
 
 // Validar configuración inicial
 XCTAssertEqual(detailView.descriptionTextView.text, "El guerrero más fuerte")
 
 // Validar que se cargue la imagen (Mockeable en pruebas avanzadas)
 // Aquí podrías usar una librería de Mock para simular la carga de imágenes
 }
 
 func testHeroDetailView_UpdateTransformations() {
 // Crear un héroe de prueba
 let hero = HerosModel(id: UUID(),
 favorite: false,
 description: "El guerrero más fuerte",
 photo: "https://example.com/goku.jpg",
 name: "Goku")
 
 // Inicializar la vista
 let detailView = HeroDetailView(hero: hero)
 
 // Simular mostrar transformaciones
 detailView.updateTransformations(isHidden: false)
 XCTAssertFalse(detailView.transformationsCollectionView.isHidden)
 XCTAssertFalse(detailView.transformationsTitleLabel.isHidden)
 
 // Simular ocultar transformaciones
 detailView.updateTransformations(isHidden: true)
 XCTAssertTrue(detailView.transformationsCollectionView.isHidden)
 XCTAssertTrue(detailView.transformationsTitleLabel.isHidden)
 }
 
 // HeroDetailViewController
 func testHeroDetailViewController_Initialization() {
 // Crear un héroe de prueba
 let hero = HerosModel(id: UUID(),
 favorite: false,
 description: "El guerrero más fuerte",
 photo: "https://example.com/goku.jpg",
 name: "Goku")
 
 // Inicializar el controlador
 let controller = HeroDetailViewController(hero: hero)
 XCTAssertNotNil(controller)
 
 // Cargar la vista
 controller.loadViewIfNeeded()
 
 // Verificar subcomponentes
 XCTAssertNotNil(controller.heroDetailView)
 XCTAssertNotNil(controller.heroDetailView?.transformationsCollectionView)
 }
 
 func testHeroDetailViewController_Navigation() {
 // Crear un héroe de prueba
 let hero = HerosModel(id: UUID(),
 favorite: false,
 description: "El guerrero más fuerte",
 photo: "https://example.com/goku.jpg",
 name: "Goku")
 
 // Inicializar el controlador
 let controller = HeroDetailViewController(hero: hero)
 let navigationController = UINavigationController(rootViewController: controller)
 controller.loadViewIfNeeded()
 
 // Simular la navegación hacia atrás
 controller.navigateBack()
 XCTAssertEqual(navigationController.viewControllers.count, 1)
 }
 /*
  func testHeroDetailViewController_Bindings() async {
  // Crear un héroe de prueba
  let hero = HerosModel(
  id: UUID(),
  favorite: false,
  description: "El guerrero más fuerte",
  photo: "https://example.com/goku.jpg",
  name: "Goku"
  )
  
  // Crear ViewModel simulado
  let viewModel = TransformationsViewModel()
  let transformation = TransformationModel(id: UUID(),
  name: "Super Saiyan",
  description: "Super Saiyan",
  photo: "https://example.com/ss.jpg",
  hero: Hero(id: UUID()))
  viewModel.transformationsData = [transformation]
  
  // Inicializar el controlador
  let controller = await HeroDetailViewController(hero: hero)
  await controller.loadViewIfNeeded()
  
  // Simular la asignación de datos y recarga de colección en el actor principal
  await MainActor.run {
  controller.transformationsViewModel = viewModel
  }
  
  // Llamar a fetchTransformations en el hilo principal
  await controller.fetchTransformations()
  
  // Realizar las validaciones también en el hilo principal
  await MainActor.run {
  XCTAssertEqual(controller.transformations.count, 1) // Asegurar que se cargó la transformación
  XCTAssertFalse(controller.heroDetailView?.transformationsCollectionView.isHidden ?? true) // Verificar que la colección no está oculta
  }
  }
  */
 func testHeroDetailViewController_Bindings() async {
 // Crear un héroe de prueba
 let hero = HerosModel(
 id: UUID(),
 favorite: false,
 description: "El guerrero más fuerte",
 photo: "https://example.com/goku.jpg",
 name: "Goku"
 )
 
 // Crear ViewModel simulado
 let viewModel = TransformationsViewModel()
 let transformation = TransformationModel(
 id: UUID(),
 name: "Super Saiyan",
 description: "Super Saiyan",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id: hero.id)
 )
 viewModel.transformationsData = [transformation]
 
 // Inicializar el controlador
 let controller = HeroDetailViewController(hero: hero)
 controller.transformationsViewModel = viewModel
 await controller.loadViewIfNeeded()
 
 // Llamar a fetchTransformations
 await controller.fetchTransformations()
 
 // Validar que la transformación se cargó correctamente
 XCTAssertEqual(controller.transformations.count, 1, "La transformación no se cargó correctamente")
 XCTAssertFalse(controller.heroDetailView?.transformationsCollectionView.isHidden ?? true, "El UICollectionView debería estar visible")
 }
 
 // TransformationCell
 func testTransformationCell_Initialization() {
 // Inicializar la celda
 let cell = TransformationCell()
 XCTAssertNotNil(cell)
 
 // Verificar subcomponentes
 XCTAssertNotNil(cell.imageView)
 XCTAssertNotNil(cell.nameLabel)
 }
 
 func testTransformationCell_Configuration() {
 // Crear un modelo de transformación de prueba
 let transformation = TransformationModel(id: UUID(),
 name: "Super Saiyan",
 description: "Super Saiyan",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id:UUID()))
 
 // Inicializar la celda y configurarla
 let cell = TransformationCell()
 cell.configure(with: transformation)
 
 // Verificar configuración
 XCTAssertEqual(cell.nameLabel.text, "Super Saiyan")
 // Verificar que la imagen se carga correctamente (Mockeable en pruebas avanzadas)
 }
 
 func testUIHeroDetailViewController() throws {
 // Crear un héroe de prueba
 let hero = HerosModel(id: UUID(),
 favorite: false,
 description: "El guerrero más fuerte",
 photo: "https://example.com/goku.jpg",
 name: "Goku")
 
 // Inicializar el controlador
 let controller = HeroDetailViewController(hero: hero)
 XCTAssertNotNil(controller)
 
 // Cargar la vista
 controller.loadViewIfNeeded()
 
 // Validar que los subcomponentes existen
 XCTAssertNotNil(controller.heroDetailView)
 XCTAssertNotNil(controller.heroDetailView?.heroImageView)
 XCTAssertNotNil(controller.heroDetailView?.descriptionTextView)
 XCTAssertNotNil(controller.heroDetailView?.transformationsCollectionView)
 
 // Validar configuración inicial
 XCTAssertEqual(controller.heroDetailView?.descriptionTextView.text, "El guerrero más fuerte")
 XCTAssertTrue(controller.heroDetailView?.transformationsCollectionView.isHidden ?? false)
 
 // Simular asignación de transformaciones
 let transformation = TransformationModel(id: UUID(),
 name: "Super Saiyan",
 description: "Super Saiyan",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id: UUID()))
 controller.transformations = [transformation]
 
 // Recargar datos directamente en el collectionView
 controller.heroDetailView?.transformationsCollectionView.reloadData()
 
 // Validar que el collectionView ya no está oculto
 controller.heroDetailView?.updateTransformations(isHidden: false) // Lógica explícita para mostrar la vista
 XCTAssertFalse(controller.heroDetailView?.transformationsCollectionView.isHidden ?? true)
 }
 
 // TransformationDetailView
 func testTransformationDetailView_Initialization() {
 // Crear un modelo de transformación de prueba
 let transformation = TransformationModel(id: UUID(),
 name: "Super Saiyan",
 description: "El primer nivel de transformación Saiyan.",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id: UUID()))
 
 // Inicializar la vista
 let detailView = TransformationDetailView(transformation: transformation)
 XCTAssertNotNil(detailView)
 
 // Validar subcomponentes
 XCTAssertNotNil(detailView.nameLabel)
 XCTAssertNotNil(detailView.descriptionTextView)
 XCTAssertNotNil(detailView.transformationImageView)
 }
 
 func testTransformationDetailView_Configuration() {
 // Crear un modelo de transformación de prueba
 let transformation = TransformationModel(id: UUID(),
 name: "Super Saiyan",
 description: "El primer nivel de transformación Saiyan.",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id: UUID()))
 
 // Inicializar la vista y configurarla
 let detailView = TransformationDetailView(transformation: transformation)
 
 // Validar que la configuración sea correcta
 XCTAssertEqual(detailView.nameLabel.text, "Super Saiyan")
 XCTAssertEqual(detailView.descriptionTextView.text, "El primer nivel de transformación Saiyan.")
 // La imagen se cargaría de forma asincrónica (requiere mocks para pruebas avanzadas)
 }
 
 func testTransformationDetailViewController_Initialization() {
 // Crear un modelo de transformación de prueba
 let transformation = TransformationModel(id: UUID(),
 name: "Super Saiyan",
 description: "El primer nivel de transformación Saiyan.",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id: UUID()))
 
 // Inicializar el controlador
 let controller = TransformationDetailViewController(transformation: transformation)
 XCTAssertNotNil(controller)
 
 // Cargar la vista
 controller.loadViewIfNeeded()
 
 // Validar que los subcomponentes existen
 let detailView = controller.view as? TransformationDetailView
 XCTAssertNotNil(detailView)
 XCTAssertEqual(detailView?.nameLabel.text, "Super Saiyan")
 XCTAssertEqual(detailView?.descriptionTextView.text, "El primer nivel de transformación Saiyan.")
 }
 
 func testTransformationDetailViewController_Navigation() {
 // Crear un modelo de transformación de prueba
 let transformation = TransformationModel(id: UUID(),
 name: "Super Saiyan",
 description: "El primer nivel de transformación Saiyan.",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id: UUID()))
 
 // Inicializar el controlador
 let controller = TransformationDetailViewController(transformation: transformation)
 let navigationController = UINavigationController(rootViewController: controller)
 controller.loadViewIfNeeded()
 
 // Simular la navegación hacia atrás
 controller.navigateBack()
 XCTAssertEqual(navigationController.viewControllers.count, 1)
 }
 
 func testUITransformationDetailViewController() {
 // Crear un modelo de transformación de prueba
 let transformation = TransformationModel(id: UUID(),
 name: "Super Saiyan",
 description: "El primer nivel de transformación Saiyan.",
 photo: "https://example.com/ss.jpg",
 hero: Hero(id: UUID()))
 
 // Inicializar el controlador
 let controller = TransformationDetailViewController(transformation: transformation)
 XCTAssertNotNil(controller)
 
 // Cargar la vista
 controller.loadViewIfNeeded()
 
 // Validar que los subcomponentes existen
 let detailView = controller.view as? TransformationDetailView
 XCTAssertNotNil(detailView)
 XCTAssertNotNil(detailView?.headerImageView)
 XCTAssertNotNil(detailView?.transformationImageView)
 XCTAssertNotNil(detailView?.nameLabel)
 XCTAssertNotNil(detailView?.descriptionTextView)
 
 // Validar configuración inicial
 XCTAssertEqual(detailView?.nameLabel.text, "Super Saiyan")
 XCTAssertEqual(detailView?.descriptionTextView.text, "El primer nivel de transformación Saiyan.")
 }
 
 // HerosViewModel
 
 func testHeroViewModel() async throws  {
 let vm = HerosViewModel(useCase: HeroUseCaseFake())
 XCTAssertNotNil(vm)
 // Esperar a que se carguen los datos
 await Task.sleep(500_000_000) // 500 ms para simular espera
 XCTAssertEqual(vm.herosData.count, 2) //debe haber 2 heroes Fake mokeados
 }
 
 func testHerosUseCase() async throws  {
 let caseUser = HeroUseCase(repo: HerosRepositoryFake())
 XCTAssertNotNil(caseUser)
 
 let data = await caseUser.getHeros(filter: "")
 XCTAssertNotNil(data)
 XCTAssertEqual(data.count, 15)
 }
 
 func testHeros_Combine() async throws {
 var suscriptor = Set<AnyCancellable>()
 
 // Crear una expectativa explícita con tipo XCTestExpectation
 let expectation: XCTestExpectation = XCTestExpectation(description: "Heros get")
 
 let vm: HerosViewModel = HerosViewModel(useCase: HeroUseCaseFake())
 XCTAssertNotNil(vm)
 
 vm.$herosData
 .sink { completion in
 switch completion {
 case .finished:
 print("Finalizado")
 case .failure(let error):
 XCTFail("Error en la obtención de datos: \(error)")
 }
 } receiveValue: { data in
 if data.count == 2 {
 expectation.fulfill()
 }
 }
 .store(in: &suscriptor)
 
 // Esperar la expectativa de forma asíncrona
 await fulfillment(of: [expectation], timeout: 10)
 }
 
 func testHeros_Data() async throws  {
 let network = NetworkHerosFake()
 XCTAssertNotNil(network)
 let repo = HerosRepository(network: network)
 XCTAssertNotNil(repo)
 
 let repo2 = HerosRepositoryFake()
 XCTAssertNotNil(repo2)
 
 let data = await repo.getHeros(filter: "")
 XCTAssertNotNil(data)
 XCTAssertEqual(data.count, 2)
 
 
 let data2 = await repo2.getHeros(filter: "")
 XCTAssertNotNil(data2)
 XCTAssertEqual(data2.count, 15)
 }
 
 func testHeros_Domain() async throws  {
 //Models
 let model = HerosModel(id: UUID(), favorite: true, description: "des", photo: "url", name: "goku")
 XCTAssertNotNil(model)
 XCTAssertEqual(model.name, "goku")
 XCTAssertEqual(model.favorite, true)
 
 let requestModel = HeroModelRequest(name: "goku")
 XCTAssertNotNil(requestModel)
 XCTAssertEqual(requestModel.name, "goku")
 }
 
 func testHeros_Presentation() async throws  {
 let viewModel = HerosViewModel(useCase: HeroUseCaseFake())
 XCTAssertNotNil(viewModel)
 
 let view =  await HerosCollectionViewController(appState: AppState(loginUseCase: LoginUseCaseFake()), viewModel: viewModel)
 XCTAssertNotNil(view)
 
 }
 
 // TransformationsViewModel
 func testTransformationsViewModel_Initialization() async {
 let fakeUseCase = TransformationsUseCaseFake()
 let viewModel = TransformationsViewModel(useCase: fakeUseCase)
 XCTAssertNotNil(viewModel)
 }
 
 func testTransformationsViewModel_GetTransformations() async {
 let fakeUseCase = TransformationsUseCaseFake()
 let viewModel = TransformationsViewModel(useCase: fakeUseCase)
 
 // Simular la carga de transformaciones
 let heroID = UUID()
 await viewModel.getTransformations(id: heroID)
 
 await Task.sleep(500_000_000) // 500 ms para simular espera
 // Validar que las transformaciones se cargaron
 XCTAssertEqual(viewModel.transformationsData.count, 14)
 }
 
 func testTransformationsViewModel_ProcessTransformations() {
 let fakeUseCase = TransformationsUseCaseFake()
 let viewModel = TransformationsViewModel(useCase: fakeUseCase)
 
 let transformations = [
 TransformationModel(id: UUID(), name: "2. Kaio-Ken", description: "", photo: "", hero: Hero(id: UUID())),
 TransformationModel(id: UUID(), name: "1. Oozaru", description: "", photo: "", hero: Hero(id: UUID())),
 TransformationModel(id: UUID(), name: "2. Kaio-Ken", description: "", photo: "", hero: Hero(id: UUID())) // Duplicado
 ]
 
 let processed = viewModel.processTransformations(transformations)
 XCTAssertEqual(processed.count, 2)
 XCTAssertEqual(processed.first?.name, "1. Oozaru")
 }
 
 func testTransformationUseCase_GetTransformations() async {
 let fakeRepo = TransformationsRepository(network: NetworkTransformationsFake())
 let useCase = TransformationUseCase(repo: fakeRepo)
 
 let heroID = UUID()
 let transformations = await useCase.getTransformations(filter: heroID)
 
 await Task.sleep(500_000_000) // 500 ms para simular espera
 // Validar que las transformaciones se cargaron correctamente
 XCTAssertEqual(transformations.count, 16)
 XCTAssertEqual(transformations.first?.name, "1. Oozaru – Gran Mono")
 }
 
 func testTransformationsUseCaseFake_GetTransformations() async {
 let fakeRepo = TransformationsRepository(network: NetworkTransformationsFake())
 let fakeUseCase = TransformationsUseCaseFake(repo: fakeRepo)
 
 let heroID = UUID()
 let transformations = await fakeUseCase.getTransformations(filter: heroID)
 
 //await Task.sleep(500_000_000) // 500 ms para simular espera
 // Validar que las transformaciones se cargaron correctamente
 XCTAssertEqual(transformations.count, 16)
 XCTAssertEqual(transformations.last?.name, "1. Oozaru – Gran Mono")
 }
 
 func testNetworkTransformations_GetTransformationsFake() async {
 let network = NetworkTransformationsFake()
 
 let heroID = UUID()
 let transformations = await network.getTransformations(filter: heroID)
 
 // Validar que las transformaciones se cargaron desde el JSON fake
 XCTAssertEqual(transformations.count, 16)
 XCTAssertEqual(transformations.first?.name, "1. Oozaru – Gran Mono")
 }
 
 func testNetworkTransformations_GetTransformationsHardcoded() {
 let transformations = getTransformationsHardcoded()
 
 // Validar que las transformaciones hardcodeadas se cargaron correctamente
 XCTAssertEqual(transformations.count, 2)
 XCTAssertEqual(transformations.first?.name, "1. Oozaru – Gran Mono")
 XCTAssertEqual(transformations.last?.name, "2. Kaio-Ken")
 }
 }
 


