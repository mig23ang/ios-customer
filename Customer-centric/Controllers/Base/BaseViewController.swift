//
//  BaseViewController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "gradientGreen")!
        appearance.shadowImage = nil
        appearance.shadowColor = .none
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        // Configura el color de fondo de la barra de navegación
        navigationController?.navigationBar.barTintColor = UIColor(named: "gradientGreen")! // Verde Material Design
        navigationController?.navigationBar.backgroundColor = UIColor(named: "gradientGreen")!
        navigationController?.navigationBar.tintColor = .white

        // Configura el título y los atributos de texto de la barra de navegación
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // Configura el botón de menú (suponiendo que tienes una imagen llamada 'menu_icon' en tus assets)
        let menuButton = UIBarButtonItem(image: UIImage(named: "Burger-menu"), style: .plain, target: self, action: #selector(menuButtonTapped))

        let logoutButton = UIBarButtonItem(image: UIImage(named: "box-arrow-in-right"), style: .plain, target: self, action: #selector(logoutButtonTapped))
         
        navigationItem.rightBarButtonItems = [menuButton, logoutButton]
        
        NavigationBarManager.shared.setupRightBarButton(on: navigationItem)
        
        let supportVie = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 80, height: 40))
        let image = UIImageView(image: UIImage(named: "negative"))
        image.frame = CGRect(x: 0, y: -5, width: supportVie.frame.size.width, height: supportVie.frame.size.height)
        supportVie.addSubview(image)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: supportVie)
    }
    
    @objc func menuButtonTapped() {
        // Implementa la lógica del botón de menú aquí
    }
    
    @objc func notificationButtonTapped() {
        // Implementa la lógica del botón de notificación aquí
    }

    @objc func logoutButtonTapped() {

        let alerta = UIAlertController(title: Constants.Strings.Alert.logout, message: Constants.Strings.Alert.logoutMessage, preferredStyle: .alert)

        let accionConfirmar = UIAlertAction(title: Constants.Strings.Alert.yes, style: .destructive) { _ in
            Keychain.shared[Constants.Keychain.token] = nil
            if let window = UIApplication.shared.currentWindow {
                window.rootViewController = LoginViewController()
            }
        }
        alerta.addAction(accionConfirmar)

        let accionCancelar = UIAlertAction(title: Constants.Strings.Alert.not, style: .cancel)
        alerta.addAction(accionCancelar)

        self.present(alerta, animated: true)
    }
    
}
