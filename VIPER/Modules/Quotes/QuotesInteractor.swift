//
//  QuotesInteractor.swift
//  VIPER
//
//  Created by iMac on 25.11.2021.
//

import Foundation

final class QuotesInteractor: PresenterToInteractorQuotesProtocol {
	//MARK: - Properties
	weak var presenter: InteractorToPresenterQuotesProtocol?
	var quotes: [Quote]?

	//MARK: - Functions
	func loadQuotes() {
		print("Interactor receives the request from Presenter to load quotes from the server.")

		let randomCount = Int.random(in: 20...50)
		APICaller.shared.getSimpsonQuotes(count: randomCount) { result in
			switch result {
			case .success(let quotes):
				self.quotes = quotes
				DispatchQueue.main.async {
					self.presenter?.fetchQuotesSuccess(quotes: quotes)
				}
			case .failure(let error):
				DispatchQueue.main.async {
					self.presenter?.fetchQuotesFailure(withError: error.localizedDescription)
				}
			}
		}
	}

	func retrieveQuote(at index: Int) {
		guard let quotes = self.quotes, quotes.indices.contains(index) else {
			self.presenter?.getQuoteFailure()
			return
		}
		self.presenter?.getQuotesSuccess(quotes[index])
	}

}
