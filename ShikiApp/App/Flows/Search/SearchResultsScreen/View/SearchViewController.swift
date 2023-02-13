//
//  SearchViewController.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import Combine
import UIKit

// MARK: - SearchViewController

final class SearchViewController: UIViewController, SearchViewInput {

    // MARK: - Properties

    let presenter: SearchViewOutput
    let searchView = SearchView()
    var cancelable = [AnyCancellable]()
    var tableHeader: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.searchView.resultsTitle.text = self.tableHeader
            }
        }
    }
    var models: [SearchModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }
    }

    // MARK: - Constructions

    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        searchView.searchTextField.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        applySearch()
        addTapGestureToHideKeyboard()
        presenter.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Functions
    
    func showError(errorString: String?) {
        searchView.backgroundImageView.isHidden = false
        searchView.backgroundLabel.isHidden = false
        searchView.backgroundLabel.text = errorString ?? Texts.ErrorMessage.noResults
    }
    
    func hideError() {
        searchView.backgroundImageView.isHidden = true
        searchView.backgroundLabel.isHidden = true
    }
    
    func setFiltersCounter(count: Int) {
        _ = searchView.button.setCounter(counter: count)
    }

    // MARK: - Private functions

    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: searchView, action: #selector(searchView.endEditing))
        searchView.addGestureRecognizer(tapGesture)
    }
    
    private func applySearch() {
        let publisher = NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: searchView.searchTextField)
        publisher
            .map {
                ($0.object as? UITextField)?.text
            }
            .debounce(for: .milliseconds(SearchConstants.keyboardDelay), scheduler: RunLoop.main)
            .sink(receiveValue: { text in
                DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                    self?.presenter.setSearchString(searchString: text)
                }
            })
            .store(in: &cancelable)
    }
}
