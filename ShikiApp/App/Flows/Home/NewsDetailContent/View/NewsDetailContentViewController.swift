//
//  NewsDetailContentViewController.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 07.02.2023.
//

import UIKit

final class NewsDetailContentViewController: UIViewController, NewsDetailContentViewInput {

    // MARK: - Private properties
    
    private let presenter: NewsDetailContentViewOutput
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.contentMode = .center
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let imageView = UIImageViewAsync()

    // MARK: - Construction
    
    init(presenter: NewsDetailContentViewOutput, imageURLString: String) {
        self.imageView.downloadedImage(from: imageURLString, contentMode: .scaleAspectFit)
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }

    // MARK: - Private functions
    
    private func configureUI() {
        // TODO: - подумать какой должен быть заголовок
        title = "@@ Тут должен быть какой-то заголовок? или нет?"
        view.backgroundColor = AppColor.backgroundMain
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    private func configureLeftBarItem() {
        let backItem = UIBarButtonItem(
            image: AppImage.NavigationsBarIcons.back,
            style: .plain,
            target: nil,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        backItem.tintColor = AppColor.textMain
        navigationItem.leftBarButtonItem = backItem
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
        configureLeftBarItem()
    }
    
    private func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        guard let imageSize = imageView.image?.size else { return }
        let newSize = countScalingSize(originSize: imageSize, targetSize: scrollView.frame.size)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: newSize.width),
            imageView.heightAnchor.constraint(equalToConstant: newSize.height),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // TODO: - вынести в презентер?
    private func countScalingSize(originSize: CGSize, targetSize: CGSize) -> CGSize {
        let widthRatio = targetSize.width / originSize.width
        let heightRatio = targetSize.height / originSize.height
        // проверяем по какой стороне ужимать картинку
        let newSize = widthRatio > heightRatio
        ? CGSize(width: originSize.width * heightRatio, height: originSize.height * heightRatio)
        : CGSize(width: originSize.width * widthRatio, height: originSize.height * widthRatio)
        return newSize
    }
    
    private func makeYoutubeID(link: String) -> String {
        
    }
}

// MARK: - UIScrollViewDelegate

extension NewsDetailContentViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
