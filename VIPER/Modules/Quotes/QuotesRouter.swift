//
//  QuotesRouter.swift
//  VIPER
//
//  Created by iMac on 25.11.2021.
//

import UIKit

final class QuotesRouter: PresenterToRouterQuotesProtocol {
	//MARK: - Starter module
	static func createModule() -> UINavigationController {
		let quotesVC = QuotesViewController()
		let navigationController = UINavigationController(rootViewController: quotesVC)

		let presenter: ViewToPresenterQuotesProtocol
			& InteractorToPresenterQuotesProtocol = QuotesPresenter()

		quotesVC.presenter = presenter
		quotesVC.presenter?.router = QuotesRouter()
		quotesVC.presenter?.view = quotesVC
		quotesVC.presenter?.interactor = QuotesInteractor()
		quotesVC.presenter?.interactor?.presenter = presenter

		return navigationController
	}

	//MARK: - Navigation
	func pushToQuoteDetailController(on view: PresenterToViewQuotesProtocol, with quote: Quote) {
		//todo
	}
}
