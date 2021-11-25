//
//  QuotesPresenter.swift
//  VIPER
//
//  Created by iMac on 25.11.2021.
//

import Foundation

class QuotesPresenter {
	//MARK: Properties
	weak var view: PresenterToViewQuotesProtocol?
	var interactor: PresenterToInteractorQuotesProtocol?
	var router: PresenterToRouterQuotesProtocol?

	var quotesStrings: [String]?

	//MARK: - Lifecycle
	func viewDidLoad() {
		view?.showHUD()
		interactor?.loadQuotes()
	}
}

extension QuotesPresenter: ViewToPresenterQuotesProtocol {
	func refreshQuotes() {
		interactor?.loadQuotes()
	}

	func numberOfRowsInSection() -> Int {
		guard let quotesStrings = self.quotesStrings else {
			return 0
		}
		return quotesStrings.count
	}

	func quoteText(indexPath: IndexPath) -> String? {
		guard let quotesStrings = self.quotesStrings else {
			return nil
		}
		return quotesStrings[indexPath.row]
	}

	func didSelectRowAt(index: Int) {
		interactor?.retrieveQuote(at: index)
	}

	func deselectRowAt(index: Int) {
		view?.deselectRow(index: index)
	}
}

//MARK: InteractorToPresenterQuotesProtocol: Presenter Output
extension QuotesPresenter: InteractorToPresenterQuotesProtocol {
	func fetchQuotesSuccess(quotes: [Quote]) {
		print("Presenter receives the result from Interactor after it's done its job.")
		self.quotesStrings = quotes.compactMap { $0.quote }
		view?.hideHUD()
		view?.onFetchQuotesSuccess()
	}

	func fetchQuotesFailure(withError: String) {
		print("Presenter receives the result from Interactor after it's done its job.")
		view?.hideHUD()
		view?.onFetchQuotesFailure(error: "Couldn't fetch quotes: \(withError)")
	}

	func getQuotesSuccess(_ quote: Quote) {
		guard let view = view else { return }
		router?.pushToQuoteDetailController(on: view, with: quote)
	}

	func getQuoteFailure() {
		print("Couldn't retrieve quote by index")
		view?.hideHUD()
	}
}
