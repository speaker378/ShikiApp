//
//  ChipsView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

enum ChipsStyle {
    case gray, lightGray, blue, green, yellow, red
    
    var backgroundColor: UIColor {
        switch self {
        case .blue:
            return AppColor.backgroundBlue
        case .green:
            return AppColor.backgroundGreen
        case .yellow:
            return AppColor.backgroundYellow
        case .red:
            return AppColor.backgroundRed
        case .gray,
             .lightGray:
            return AppColor.backgroundMinor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .blue:
            return AppColor.accent
        case .green:
            return AppColor.green
        case .yellow:
            return AppColor.orange
        case .red:
            return AppColor.red
        case .gray:
            return AppColor.textMain
        case .lightGray:
            return AppColor.textMinor
        }
    }
    
    static func makeStatusStyle(_ status: String) -> ChipsStyle {
        switch status {
        case "Анонсировано":
            return .yellow
        case "Издано", "Вышло":
            return .green
        case "Выходит", "Онгоинг":
            return .blue
        case "Прекращено", "Приостановлено":
            return .red
        default:
            return .lightGray
        }

    }
}

final class ChipsView: UIView {

    // MARK: - Private properties
    
    private let horizontalInset: CGFloat = 4.0
    private let verticalInset: CGFloat = 2.0
    private let contentView = UIView()
    private let titleLabel: AppLabel = {
        let label = AppLabel(alignment: .center, fontSize: AppFont.Style.subtitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, style: ChipsStyle) {
    super.init(frame: .zero)
    configurate(title: title, style: style)
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Functions

    func configurate(title: String, style: ChipsStyle) {
        titleLabel.text = title
        configureUI(with: style)
    }

    // MARK: - Private functions

    private func configureUI(with style: ChipsStyle) {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = style.backgroundColor
        contentView.layer.cornerRadius = Constants.CornerRadius.xSmall
        titleLabel.textColor = style.textColor
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalInset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalInset)
        ])
    }
}
