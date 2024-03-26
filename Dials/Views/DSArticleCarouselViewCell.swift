//
//  DSArticleCarouselViewCell.swift
//  Dials
//
//  Created by Rohan Prashanth on 22/03/24.
//

import UIKit

class DSArticleCarouselViewCell: UICollectionViewCell {
    static let cellIdentifier = "DSArticleCarouselViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, titleLabel, authorLabel, categoryLabel)
        addConstraints()
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -3, height: 3)
        contentView.layer.shadowOpacity = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
          //  titleLabel.heightAnchor.constraint(equalToConstant: 60),
            authorLabel.heightAnchor.constraint(equalToConstant: 30),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            authorLabel.widthAnchor.constraint(equalToConstant: 140),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            categoryLabel.rightAnchor.constraint(equalTo: authorLabel.leftAnchor, constant: -40),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            categoryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 7),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -3),
            
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 360),

           /*
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),

            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -3),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            */
        ])
        
        /*
         | Image      Title
         | Image            by Author
         */
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        authorLabel.text = nil
        categoryLabel.text = nil
    }
    
    public func configure(with viewModel: DSArticleCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.authorText
        categoryLabel.text = viewModel.categories[0].name.uppercased()
        let colorString = viewModel.categories[0].color
        categoryLabel.backgroundColor = colorFromString(colorString)

        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    private func colorFromString(_ colorString: String) -> UIColor {
        if colorString.starts(with: "rgba") {
            // Removing the rgba prefix and the surrounding parentheses
            let cleanedString = colorString
                .replacingOccurrences(of: "rgba(", with: "")
                .replacingOccurrences(of: ")", with: "")
            
            let components = cleanedString.split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespaces) }
                        .compactMap { Double($0) } // Parse each component as Double
                        .map { CGFloat($0) } // Explicitly convert Double to CGFloat here
            
            if components.count == 4 {
                // Ensure components are within 0...1 for colors
                let red = components[0] / 255
                let green = components[1] / 255
                let blue = components[2] / 255
                let alpha = components[3] // Alpha is already 0...1
                return UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }
        } else if let namedColor = UIColor(named: colorString) {
            // Directly using named UIColor initializer
            return namedColor
        } else {
            // Fallback for unrecognized strings (Consider logging this case)
            return .black // Or any default color
        }

        // If none of the conditions are met, return a default color
        return .black
    }

}
