//
//  SafeDecoding.swift
//  MobiquityTask
//
//  Created by Elwan on 11/2/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

struct FailableDecodable<T: Swift.Decodable>: Swift.Decodable {
    let value: T?
    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try? container.decode(T.self)
    }
}

public struct Safe<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}

extension KeyedDecodingContainer {
    
    public func decodeSafelyArray<T: Decodable>(of type: T.Type, forKey key: KeyedDecodingContainer.Key) -> [T] {
        let array = decodeSafely(key, as: [Safe<T>].self)
        return array?.compactMap{ $0.value } ?? []
    }
    
    public func decodeSafely<T: Decodable>(_ key: Key, as type: T.Type = T.self) -> T? {
        guard let decoded = try? decode(T.self, forKey: key) else { return nil }
        return decoded
    }

    public func decodeSafelyIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
        guard let decoded = try? decodeIfPresent(T.self, forKey: key) else { return nil }
        return decoded
    }
}
