//
//  QuoteRequest.swift
//  VIPER
//
//  Created by iMac on 25.11.2021.
//

import Foundation

struct QuoteRequest: Decodable {
	let quotes: [Quote]
}

struct Quote: Decodable {
	let quote: String
	let character: String
	let image: String
}
