//
//  Keychain.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 6/12/23.
//

import Foundation


class Keychain {
    static let shared = Keychain()
    private let queue = DispatchQueue(label: "customercentricios.mibanco.com.co.keychain")

    subscript(key: String) -> String? {
        get {
            return load(withKey: key)
        } set {
            queue.sync {
                self.save(newValue, forKey: key)
            }
        }
    }

    private func save(_ string: String?, forKey key: String) {
        let query = keychainQuery(withKey: key)
        let objectData: Data? = string?.data(using: .utf8)

        if SecItemCopyMatching(query, nil) == noErr {
            if let dictData = objectData {
                let attributesToUpdate: [String: Any] = [kSecValueData as String: dictData]
                SecItemUpdate(query, attributesToUpdate as CFDictionary)
            } else {
                SecItemDelete(query)
            }
        } else {
            if let dictData = objectData {
                query.setValue(dictData, forKey: kSecValueData as String)
                SecItemAdd(query, nil)
            }
        }
    }

    private func load(withKey key: String) -> String? {
        let query = keychainQuery(withKey: key)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)

        var result: CFTypeRef?
        if SecItemCopyMatching(query, &result) == noErr,
           let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }

    private func keychainQuery(withKey key: String) -> NSMutableDictionary {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        return NSMutableDictionary(dictionary: query)
    }
}
