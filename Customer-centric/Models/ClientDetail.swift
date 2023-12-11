//
//  ClientDetail.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 8/12/23.
//

import Foundation

struct ClientDetail: Decodable {
    var alert: Alert?
    var clientBase: ClientBase?
    var creditRisk: CreditRisk?
    var creditRiskReportType: CreditRiskReportType?
    var contact: Contact?
    var spouse: Spouse?
    var revolvingQuota: RevolvingQuota?
    var verificationDigit: Int?
    var address: Address?
    var companyAddress: CompanyAddress?
    var maritalStatus: String?
    var lastUpdateOfficer: String?
    var business: Business?
    var legalRepresentativeDocumentNumber: String?
    var offer: Offer?
    var liability: Liability?
    var PQR: PQR?
    var loan: String?
    var legalRepresentativeName: String?
    var socialReason: String?
    var updateRequired: String?
    var legalRepresentativeDocumentType: String?
    var totalAssets: String?
    var lastUpdateDate: String?
    var pqr: PQR?

    enum CodingKeys: String, CodingKey {
        case alert = "alerta"
        case clientBase = "clienteBase"
        case creditRisk = "centralRiesgo"
        case creditRiskReportType = "reporteCentralRiesgoType"
        case contact = "contacto"
        case spouse = "conyuge"
        case revolvingQuota = "cupoRotativo"
        case verificationDigit = "digitoVerificacion"
        case address = "domicilio"
        case companyAddress = "domicilioEmpresa"
        case maritalStatus = "estadoCivil"
        case lastUpdateOfficer = "funcionarioUltimaActualizacion"
        case business = "negocio"
        case legalRepresentativeDocumentNumber = "numeroDocumentoRepresentanteLegal"
        case offer = "oferta"
        case liability = "pasivo"
        case PQR
        case loan = "prestamo"
        case legalRepresentativeName = "nombreRepresentanteLegal"
        case socialReason = "razonSocial"
        case updateRequired = "seRequiereActualizacion"
        case legalRepresentativeDocumentType = "tipoDocumentoRepresentanteLegal"
        case totalAssets = "totalActivos"
        case lastUpdateDate = "ultimaFechaActualizacion"
        case pqr
    }

    struct Alert: Decodable {
        var alertType: String?
        var bank: String?
        var date: String?
        var documentType: String?
        var documentNumber: String?
        var verificationDigit: String?

        enum CodingKeys: String, CodingKey {
            case alertType = "tipoAlerta"
            case bank = "banco"
            case date = "fecha"
            case documentType = "tipoDocumento"
            case documentNumber = "numeroDocumento"
            case verificationDigit = "digitoVerificacion"
        }
    }

    struct ClientBase: Decodable {
        var id: String?
        var clientNumber: String?
        var personType: String?
        var documentType: String?
        var documentNumber: String?
        var documentExpeditionDate: String?
        var firstName: String?
        var cellNumber: String?
        var secondName: String?
        var firstSurname: String?
        var secondSurname: String?
        var email: String?

        enum CodingKeys: String, CodingKey {
            case id
            case clientNumber = "numeroCliente"
            case personType = "tipoPersona"
            case documentType = "tipoDocumento"
            case documentNumber = "numeroDocumento"
            case documentExpeditionDate = "fechaExpedicionDocumento"
            case firstName = "primerNombre"
            case cellNumber = "numeroCelular"
            case secondName = "segundoNombre"
            case firstSurname = "primerApellido"
            case secondSurname = "segundoApellido"
            case email = "correoElectronico"
        }
    }

    struct CreditRisk: Decodable {
        var clientNumber: String?
        var mostRecentConsultationResult: String?
        var validForConsultation: String?
        var mostRecentConsultationDate: String?

        enum CodingKeys: String, CodingKey {
            case clientNumber = "numeroCliente"
            case mostRecentConsultationResult = "resultadoConsultaMasReciente"
            case validForConsultation = "vbVigenteParaSerConsultado"
            case mostRecentConsultationDate = "fechaConsultaMasReciente"
        }
    }

    struct CreditRiskReportType: Decodable {
        var locationSeniority: String?
        var detailedConsultation: String?
        var documentState: String?
        var mostRecentConsultationDate: String?
        var documentExpeditionDate: String?
        var gender: String?
        var indebtednessHistory: String?
        var expeditionPlace: String?
        var documentNumber: String?
        var ageRange: String?
        var mostRecentConsultationResult: String?
        var hasRUT: String?
        var documentType: String?
        var relationType: String?
        var reportType: String?
        var validForConsultation: String?
        var verificationDigit: String?

        enum CodingKeys: String, CodingKey {
            case locationSeniority = "antiguedadUbicacion"
            case detailedConsultation = "consultaDetallada"
            case documentState = "estadoDocumento"
            case mostRecentConsultationDate = "fechaConsultaMasReciente"
            case documentExpeditionDate = "fechaExpedicion"
            case gender = "genero"
            case indebtednessHistory = "historicoEndeudamiento"
            case expeditionPlace = "lugarExpedicion"
            case documentNumber = "numeroDocumento"
            case ageRange = "rangoEdad"
            case mostRecentConsultationResult = "resultadoConsultaMasReciente"
            case hasRUT = "tieneRUT"
            case documentType = "tipoDocumento"
            case relationType = "tipoRelacion"
            case reportType = "tipoReporte"
            case validForConsultation = "vbVigenteParaSerConsultado"
            case verificationDigit = "digitoVerificacion"
        }
    }

    struct Contact: Decodable {
        var date: String?
        var contactType: String?
        var commentsResult: String?
        var clientNumber: String?

        enum CodingKeys: String, CodingKey {
            case date = "fecha"
            case contactType = "tipoContacto"
            case commentsResult = "resultadoComentarios"
            case clientNumber = "numeroCliente"
        }
    }

    struct Spouse: Decodable {
        var documentType: String?
        var documentNumber: String?
        var name: String?
        var clientNumber: String?

        enum CodingKeys: String, CodingKey {
            case documentType = "tipoDocumento"
            case documentNumber = "numeroDocumento"
            case name = "nombre"
            case clientNumber = "numeroCliente"
        }
    }

    struct RevolvingQuota: Decodable {
        var state: String?
        var expirationDate: String?
        var creditQuotaAmount: String?
        var amountUsed: String?
        var clientNumber: String?
        var quotaNumber: String?
        var availableBalance: String?

        enum CodingKeys: String, CodingKey {
            case state = "estado"
            case expirationDate = "fechaDeVencimiento"
            case creditQuotaAmount = "montoCupoCredito"
            case amountUsed = "montoUtilizado"
            case clientNumber = "numeroCliente"
            case quotaNumber = "numeroCupo"
            case availableBalance = "saldoDisponible"
        }
    }

    struct Address: Decodable {
        var clientNumber: String?
        var housingType: String?

        enum CodingKeys: String, CodingKey {
            case clientNumber = "numeroCliente"
            case housingType = "tipoVivienda"
        }
    }

    struct CompanyAddress: Decodable {
        var clientNumber: String?
        var address: String?
        var phone1: String?
        var phone2: String?
        var CIIUActivityType: String?
        var localType: String?

        enum CodingKeys: String, CodingKey {
            case clientNumber = "numeroCliente"
            case address = "direccion"
            case phone1 = "telefono1"
            case phone2 = "telefono2"
            case CIIUActivityType = "tipoActividadCIIU"
            case localType = "tipoLocal"
        }
    }

    struct Business: Decodable {
        var address: String?
        var phone: String?
        var CIIUActivityType: String?
        var clientNumber: String?

        enum CodingKeys: String, CodingKey {
            case address = "direccion"
            case phone = "telefono"
            case CIIUActivityType = "tipoActividadCIIU"
            case clientNumber = "numeroCliente"
        }
    }

    struct Offer: Decodable {
        var offerNumber: String?
        var leadType: String?
        var offerType: String?
        var amount: String?
        var term: String?
        var clientNumber: String?
        var leagueType: String?
        var warrantyCondition: String?

        enum CodingKeys: String, CodingKey {
            case offerNumber = "numeroOferta"
            case leadType = "tipoLead"
            case offerType = "tipoOferta"
            case amount = "monto"
            case term = "plazo"
            case clientNumber = "numeroCliente"
            case leagueType = "tipoDeLiga"
            case warrantyCondition = "condicionGarantia"
        }
    }

    struct Liability: Decodable {
        var clientNumber: String?
        var productNumber: String?
        var productType: String?
        var productDetail: String?
        var liabilityState: String?
        var openingDate: String?
        var closingDate: String?
        var capital: String?
        var interests: String?
        var others: String?
        var totalBalance: String?

        enum CodingKeys: String, CodingKey {
            case clientNumber = "numeroCliente"
            case productNumber = "numeroProducto"
            case productType = "tipoProducto"
            case productDetail = "detalleProducto"
            case liabilityState = "estadoPasivo"
            case openingDate = "fechaApertura"
            case closingDate = "fechaCierre"
            case capital = "capital"
            case interests = "intereses"
            case others = "otros"
            case totalBalance = "saldoTotal"
        }
    }

    struct PQR: Decodable {
        var clientNumber: String?
        var date: String?
        var PQRNumber: String?
        var reason: String?
        var PQRResult: String?
        var comment: String?

        enum CodingKeys: String, CodingKey {
            case clientNumber = "numeroCliente"
            case date = "fecha"
            case PQRNumber = "numeroPQR"
            case reason = "motivo"
            case PQRResult = "resultadoPQR"
            case comment = "comentario"
        }
    }
}
