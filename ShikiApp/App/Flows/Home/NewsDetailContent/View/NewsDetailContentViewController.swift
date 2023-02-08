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
    
    init(presenter: NewsDetailContentViewOutput, URLString: String) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        configure(with: URLString)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
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
    
    private func configure(with URLString: String) {
        if URLString.contains("youtube") {
            guard
                let youtubeID = presenter.makeYoutubeID(link: URLString),
                let url = URL(string: "http://www.youtube.com/watch?v=\(youtubeID)")
            else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            imageView.downloadedImage(from: URLString, contentMode: .scaleAspectFit)
        }
        
        configureUI(with: URLString)
    }
    
    private func configureUI(with URLString: String) {
        // TODO: - подумать какой должен быть заголовок
        // title = "@@ Тут должен быть какой-то заголовок? или нет?"
        view.backgroundColor = AppColor.backgroundMain
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        if URLString.contains("youtube") {
            //
        } else {
//            view.addSubview(scrollView)
//            scrollView.addSubview(imageView)
        }
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
        
        // TODO: - сделать это только после того как изображ. скачается!
        guard let imageSize = imageView.image?.size else { return }
        let newSize = countScalingSize(originSize: imageSize, targetSize: scrollView.frame.size)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: newSize.width),
            imageView.heightAnchor.constraint(equalToConstant: newSize.height)
        ])
    }
    
    // TODO: - вынести в презентер?
    private func countScalingSize(originSize: CGSize, targetSize: CGSize) -> CGSize {
        let widthRatio = targetSize.width / originSize.width
        let heightRatio = targetSize.height / originSize.height
        
        let newSize = widthRatio > heightRatio
        ? CGSize(width: originSize.width * heightRatio, height: originSize.height * heightRatio)
        : CGSize(width: originSize.width * widthRatio, height: originSize.height * widthRatio)
        return newSize
    }
}

// MARK: - UIScrollViewDelegate

extension NewsDetailContentViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
