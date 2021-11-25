//
//  QuotesContract.swift
//  VIPER
//
//  Created by iMac on 25.11.2021.
//

import UIKit

//MARK: Presenter Input (View -> Presenter)
protocol ViewToPresenterQuotesProtocol {
	var view: PresenterToViewQuotesProtocol? { get set }
	var interactor: PresenterToInteractorQuotesProtocol? { get set }
	var router: PresenterToRouterQuotesProtocol? { get set }
	var quotesStrings: [String]? { get set }

	func viewDidLoad()
	func refreshQuotes()
	func numberOfRowsInSection() -> Int
	func quoteText(indexPath: IndexPath) -> String?
	func didSelectRowAt(index: Int)
	func deselectRowAt(index: Int)

}

//MARK: Presenter Output (Presenter -> View)
protocol PresenterToViewQuotesProtocol: class {
	func onFetchQuotesSuccess()
	func onFetchQuotesFailure(error: String)
	func showHUD()
	func hideHUD()
	func deselectRow(index: Int)
}



//MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorQuotesProtocol {
	var presenter: InteractorToPresenterQuotesProtocol? { get set }
	func loadQuotes()
	func retrieveQuote(at index: Int)
}

//MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterQuotesProtocol: class {
	func fetchQuotesSuccess(quotes: [Quote])
	func fetchQuotesFailure(withError: String)
	func getQuotesSuccess(_ quote: Quote)
	func getQuoteFailure()
}



//MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterQuotesProtocol: class {
	static func createModule() -> UINavigationController
	func pushToQuoteDetailController(on view: PresenterToViewQuotesProtocol, with quote: Quote)
}
