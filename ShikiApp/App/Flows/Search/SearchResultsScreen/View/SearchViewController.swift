//
//  SearchViewController.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import UIKit

// MARK: - SearchViewController

final class SearchViewController: UIViewController, SearchViewInput {

    // MARK: - Properties

    let keyboardDelay: TimeInterval = 1
    let presenter: SearchViewOutput
    let searchView = SearchView()
    var timerSearch = Timer()
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
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
        presenter.loadFilters()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: - Functions

    func showError(errorString: String?, errorImage: UIImage) {
        guard let errorString else { return }
        searchView.resultsTitle.isHidden = true
        searchView.backgroundImageView.image = errorImage
        searchView.backgroundLabel.text = errorString
        searchView.backgroundImageView.isHidden = false
        searchView.backgroundLabel.isHidden = false
    }

    func hideError() {
        searchView.resultsTitle.isHidden = false
        searchView.backgroundImageView.isHidden = true
        searchView.backgroundLabel.isHidden = true
    }

    func setFiltersCounter(count: Int) {
        _ = searchView.button.setCounter(counter: count)
    }

    // MARK: - Private functions

    private func configureOnViewDidLoad() {
        searchView.searchTextField.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.prefetchDataSource = self
        searchView.delegate = self
        applySearch()
        addTapGestureToHideKeyboard()
        searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: searchView, action: #selector(searchView.endEditing))
        tapGesture.cancelsTouchesInView = false
        searchView.addGestureRecognizer(tapGesture)
    }

    private func applySearch(_ text: String? = nil) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.presenter.setSearchString(searchString: text)
        }
    }

    @objc private func textFieldDidChange(textField: UITextField) {
        timerSearch.invalidate()
        timerSearch = Timer.scheduledTimer(withTimeInterval: keyboardDelay, repeats: false) { [weak self] _ in
            self?.applySearch(textField.text)
        }
    }
}
