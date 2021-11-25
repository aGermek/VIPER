//
//  QuotesViewController.swift
//  VIPER
//
//  Created by iMac on 18.11.2021.
//

import UIKit
import EasyPeasy
import PKHUD

class QuotesViewController: UIViewController {
	//MARK: - Properties
	var presenter: ViewToPresenterQuotesProtocol?

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()

	private lazy var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
		refreshControl.addTarget(self, action: #selector(refreshQuotes), for: .valueChanged)
		return refreshControl
	}()

	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		presenter?.viewDidLoad()
	}

	private func configureUI() {
		view.addSubview(tableView)
		tableView.addSubview(refreshControl)
		tableView.easy.layout(Edges())
		tableView.backgroundColor = .systemBackground
		title = "Simpson Quotes"
	}

	//MARK: - Actions
	@objc private func refreshQuotes() {
		presenter?.refreshQuotes()
	}

	//MARK: - Private func's
	private func showFetchQuotesError(text: String) {
		print(text)
	}
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension QuotesViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.numberOfRowsInSection() ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = presenter?.quoteText(indexPath: indexPath)
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.didSelectRowAt(index: indexPath.row)
		presenter?.deselectRowAt(index: indexPath.row)
	}
}

//MARK: - Quotes
extension QuotesViewController: PresenterToViewQuotesProtocol {

	func onFetchQuotesSuccess() {
		self.tableView.reloadData()
		self.refreshControl.endRefreshing()
	}

	func onFetchQuotesFailure(error: String) {
		self.refreshControl.endRefreshing()
		showFetchQuotesError(text: error)
	}

	func showHUD() {
		HUD.show(.progress, onView: self.view)
	}

	func hideHUD() {
		HUD.hide()
	}

	func deselectRow(index: Int) {
		self.tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
	}
}
