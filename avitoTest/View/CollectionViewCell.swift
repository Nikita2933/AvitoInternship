

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .max
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .max
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var selectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "checmark")
        return imageView
    }()
    
    var imageCell = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        contentView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func iSelected() {
        if (!isSelected) {
            self.selectImage.isHidden = true
        } else {
            self.selectImage.isHidden = false
        }
    }
    
    private func setupCell() {
        setupImageView()
        setupSelectView()
        setupTitleLabel()
        setupDescriptionTitile()
        setupPriceLabel()
        self.backgroundColor = #colorLiteral(red: 0.972464025, green: 0.9726034999, blue: 0.9724335074, alpha: 1)
    }
    
    func setupCell(withData: List) {
        titleLabel.text = withData.title
        descriptionTitleLabel.text = withData.listDescription
        priceLabel.text = withData.price
        iSelected()
        
        LoadImage.loadImage(imgString: withData.icon.icon) { [self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    imageCell.image = UIImage(data: image)
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    imageCell.image = UIImage(named: "cancel" )
                }
            }
        }
    }
    
    private func setupImageView() {
        contentView.addSubview(imageCell)
        
        imageCell.translatesAutoresizingMaskIntoConstraints = false
        
        imageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imageCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        imageCell.widthAnchor.constraint(equalToConstant: 55).isActive = true
        imageCell.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func setupSelectView() {
        contentView.addSubview(selectImage)
        
        selectImage.translatesAutoresizingMaskIntoConstraints = false
        
        selectImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        selectImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        selectImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        selectImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.imageCell.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.selectImage.leftAnchor, constant: -10).isActive = true
        
    }
    
    private func setupDescriptionTitile() {
        contentView.addSubview(descriptionTitleLabel)
        
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
        descriptionTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionTitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor, constant: 0).isActive = true
        descriptionTitleLabel.rightAnchor.constraint(equalTo: self.selectImage.leftAnchor, constant: 0).isActive = true
    }
    
    private func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.topAnchor.constraint(equalTo: self.descriptionTitleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: self.descriptionTitleLabel.leftAnchor, constant: 0).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.selectImage.leftAnchor, constant: 0).isActive = true
    }
}
