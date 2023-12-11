//
//  Constants.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 27/11/23.
//

import Foundation

struct Constants {
    
    struct Keychain {
        static let token = "authToken"
    }
    
    static let typeDocumentOptions = [ListModal(name: "CC", value: "CC"),ListModal(name: "TI", value: "TI")]
    static let digitVerificationOptions = [ListModal(name: "1", value: "1"),ListModal(name: "2", value: "2")]
    
    struct Strings {

        struct Errors {
            static let `default` = "Ha ocurrido un error, inténtalo de nuevo más tarde"
        }
        
        struct Loader {
            static let starting = "Iniciando..."
            static let loading = "Cargando..."
        }
        
        struct Header {
            static let hello = "Hola"
            static let welcomeToMyApp = "Bienvenido a mi MiBancoAPP"
            static let returntext = "   volver"
        }
        
        struct EmptySearchResult {
            static let title = "¡Disculpanos!\n No encontramos lo que buscas"
            static let message = "Parece que hubo un error con tu búsqueda o el accesp que buscas no existe, ¿Quieres intentarlo de nuevo?"
            static let tryAgain = "Intentar de nuevo"
        }
        
        struct Alert {
            static let logout = "Cerrar sesión"
            static let logoutMessage = "¿Estás seguro de que quieres cerrar sesión?"
            static let yes = "SI"
            static let not = "NO"
        }
        
        struct Controllers {
            struct Login {
                static let hello = "¡Hola!"
                static let enterMyBank = "Ingresa a tu banco en línea"
                static let typeDocument = "Tipo de documento"
                static let selectYourDocument = "Selecciona tu documento"
                static let email = "Correo electrónico"
                static let password = "Contraseña"
                static let writeYourPassword = "Escribe tu contraseña"
                static let forgotPasswordHere = "Recupera tu contraseña aquí"
                static let login = "Iniciar sesión"
                static let errorDocument = "Debes ingresar tu documento"
                static let errorPassword = "Debes ingresar tu contraseña"
                static let doNotHaveAUser = "¿Aún no tienes usuario?"
                static let createAccount = "Crea tu usuario"
                static let errorEmailFormat = "Formato de correo inválido"
            }
            
            struct Home {
                static let start = "Inicio"
                static let lastVisited = "Último visitado"
                static let cardLastVisited = "Ficha Integral del Cliente - FIC"
                static let noticeAndEvents = "Noticias y Eventos"
                static let cardNoticeAndEvents = "Mantente al día con todos los eventos que realizamos en MiBanco para que hagas parte de ellos y participes."
                static let sustainability = "Sostenibilidad"
                static let cardSustainability = "Conoce como en Mi Banco desarrollamos nuestra política de sostenibilidad."
            }
            
            struct Collection {
                static let myLibrary = "Mi Biblioteca"
                static let comprehensiveSheet = "Ficha Integral del Cliente - FIC"
                static let advisorsPymes = "Asesores Pymes"
                static let advisorsMuleteers = "Asesores Arrieros"
            }
            
            struct Search {
                static let doYourSearch = "Haz tu búsqueda"
            }
            
            struct SearchByName {
                static let comprehensiveClient = "FICHA INTEGRAL DEL CLIENTE"
                static let exampleNumberDocument = "Ej: 1.345.432455"
                static let consult = "Consultar"
                static let clean = "Limpiar"
                static let searchByNameOrSocialReason = "Nombre o razón social"
                static let numberDocument = "Número de documento"
                static let nameAndLastNameOrSocialReason = "Nombres y Apellidos o Razón Social"
                static let selectTypeDocument = "Seleccionar tipo de documento"
                static let chooseTypeDocumentClient = "1. Escoge el tipo de documento del cliente"
                static let chooseVerificationDigit = "2. Escoge el digito de verificacion"
                static let searchOfNumberDocumentClient = "3. Busca el número del documento del cliente"
                static let selectDigitVerification = "Seleccione el Dígito de verificación"
                static let errorDocument = "Debes ingresar un número de documento"
                static let errorTypeDocument = "Debes seleccionar un tipo de documento"
                static let errorName = "Debes ingresar un nombre"
                static let errorDigitVerification = "Debes seleccionar un digito de verificación"
            }
        }
    }
}

struct App {
    static let shared = App()
    static let infoPath = Bundle.main.path(forResource: "Info", ofType: ".plist")
    let configDictionary = NSDictionary(contentsOfFile: infoPath ?? "")
    
    static func getValueFromInfoPlist(with key: String) -> String {
        guard let dictionary = App.shared.configDictionary,
            let value = dictionary[key] as? String else {
            return String()
        }
        return value
    }
    
    static func getAnyValueFromInfoPlist(with key: String) -> AnyObject {
        guard let dictionary = App.shared.configDictionary,
            let value = dictionary[key] else {
            return String() as AnyObject
        }
        return value as AnyObject
    }
}
