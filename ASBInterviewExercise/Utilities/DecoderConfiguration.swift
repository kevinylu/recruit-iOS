//
//  DecoderConfiguration.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import Foundation

struct DecoderConfiguration {
    static func createDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()

        // Configure date decoding strategy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // ISO8601-like format
        dateFormatter.locale = Locale(identifier: "en_NZ") // New Zealand locale
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }
}
