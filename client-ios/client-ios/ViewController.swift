//
//  ViewController.swift
//  client-ios
//
import UIKit

class ViewController: UIViewController, MainView {

  @IBOutlet var editTextSearch: UITextField!
  @IBOutlet var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet var labelResult: UILabel!

  static let baseUrl = "http://ENTER_YOUR_HOST_HERE:4000"

  private lazy var mainPresenter = MainPresenter(view: self)
  private lazy var apolloPresenter = ApolloPresenter(view: self)

  @IBAction func onGetWikiHitApollo(_ sender: Any) {
    guard let searchText = editTextSearch.text, !searchText.isEmpty else {
      return
    }

    labelResult.text = ""
    loadingIndicator.startAnimating()
    self.apolloPresenter.fetchData(searchText: searchText)
  }
  
  @IBAction func onGetWikiHit(_ sender: Any) {
    guard let searchText = editTextSearch.text, !searchText.isEmpty else {
      return
    }

    labelResult.text = ""
    loadingIndicator.startAnimating()
    self.mainPresenter.fetchData(searchText: searchText)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadingIndicator.hidesWhenStopped = true
  }

  override func viewDidDisappear(_ animated: Bool) {
    self.mainPresenter.cancelFetch()
  }

  func showResult(data: String) {
    labelResult.text = data
  }

  func stopLoading() {
    loadingIndicator.stopAnimating()
  }
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
