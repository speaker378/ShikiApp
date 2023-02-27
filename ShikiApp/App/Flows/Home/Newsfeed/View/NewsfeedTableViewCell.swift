//
//  NewsfeedTableViewCell.swift
//  ShikiApp
//
//  Created by Сергей Черных on 20.01.2023.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {

    // MARK: - Private properties
    
    private let lineWidth: CGFloat = 1
    private let imageWidth: CGFloat = 88
    private let trailing = -16.0
    private let leading = 8.0
    private let topInset = 12.0
    private let bottom = -12.0
    private let verticalSpacing = 2.0
    
    private var newsImageView: UIImageViewAsync = {
        let imageView = UIImageViewAsync()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var dateLabel: UILabel = {
        let label = AppLabel(
            alignment: .left,
            fontSize: AppFont.openSansFont(ofSize: 12, weight: .regular),
            fontСolor: AppColor.textMinor
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .bold))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = AppLabel(alignment: .left, fontSize: AppFont.openSansFont(ofSize: 16, weight: .regular))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var strokeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.line
        return view
    }()
    
    private var accentBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundMinor
        return view
    }()

    // MARK: - Construction
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        [dateLabel, titleLabel, subtitleLabel].forEach { $0.text = nil }
    }

    // MARK: - Private functions
    
    private func configureUI() {
        self.selectedBackgroundView = accentBackgroundView
        self.contentView.backgroundColor = AppColor.backgroundMain
        self.addSubviews([newsImageView, dateLabel, titleLabel, subtitleLabel, strokeView])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: leading),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topInset),
            
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: leading),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: verticalSpacing),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: leading),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom),
            
            strokeView.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: leading),
            strokeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing),
            strokeView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            strokeView.heightAnchor.constraint(equalToConstant: lineWidth)
        ])
    }
    
    private func textIsShort(_ text: String?) -> Bool {
        let widthTitle = contentView.bounds.width - imageWidth - leading + trailing
        let titleHeight = text?.getTextHeight(width: widthTitle, font: titleLabel.font) ?? 0
        let oneLineTitleHeight = "".getTextHeight(width: widthTitle, font: titleLabel.font)
        if titleHeight < (oneLineTitleHeight * 2) {
            return true
        }
        return false
    }

    // MARK: - Functions
    
    func configure(with cellModel: NewsModel) {
        newsImageView.downloadedImage(from: cellModel.imageUrls[.preview] ?? "", contentMode: .scaleAspectFill)
        dateLabel.text = cellModel.date
        titleLabel.text = cellModel.title
        subtitleLabel.text = cellModel.subtitle
        
        if textIsShort(titleLabel.text) {
            titleLabel.numberOfLines = 1
            subtitleLabel.numberOfLines = 2
        }
    }
}
