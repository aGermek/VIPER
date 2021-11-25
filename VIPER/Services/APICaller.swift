//
//  APIService.swift
//  VIPER
//
//  Created by iMac on 25.11.2021.
//

import Foundation

final class APICaller {
	//MARK: - Properties
	static let shared = APICaller()

	private struct Constants {
		static let baseURL = "https://thesimpsonsquoteapi.glitch.me"
		static let quotes = "/quotes"
		//https://thesimpsonsquoteapi.glitch.me/quotes?count=50
	}

	private enum HTTPMethod: String {
		case GET
		case POST
		case DELETE
		case PUT
	}

	private enum APICallerErrors: Error {
		case failedToGetData
	}

	//MARK: - Public func's
	public func getSimpsonQuotes(count: Int, completion: @escaping (Result<[Quote], Error>) -> Void) {
		guard let url = URL(string: Constants.baseURL + Constants.quotes + "?count=\(count)") else {
			return
		}

		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(APICallerErrors.failedToGetData))
				return
			}

			do {
				let response = try JSONDecoder().decode(QuoteRequest.self, from: data)
				completion(.success(response.quotes))
			} catch {
				completion(.failure(error))
			}
		}

		task.resume()
	}
}
