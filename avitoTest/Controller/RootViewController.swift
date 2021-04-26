

import UIKit

class RootViewController: UIViewController {
    
    var inputData: AvitoJson!
    
    private var closedButton = UIButton()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .max
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var selectedActionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonCliked), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.backgroundColor = #colorLiteral(red: 0.0057789688, green: 0.6729405522, blue: 0.9988098741, alpha: 1)
        return button
    }()
    
    private var collectionView : UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CVCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        if let data = getJson() {
            inputData = data
        }
        
        setupView()
    }
    
    private func getJson() -> AvitoJson?  {
        var json: AvitoJson?
        JsonController.loadFile { (result) in
            switch result {
            case .success(let data):
                json = JsonController.jsonParse(data: data)
            case .failure(let errString):
                print(errString)
            }
        }
        return json
    }
    
    @objc func buttonCliked() {
        let listed = inputData.result.list
        for list in listed {
            if list.isSelected == true {
                alertButtonCliked(message: list.title)
            }
        }
    }
    
    private func setupView() {
        setupClosedButton()
        setupTitleLabel()
        setupActionButton()
        setupCollectionController()
        collectionView.layoutIfNeeded()
    }
    
    private func setupClosedButton() {
        self.view.addSubview(closedButton)
        
        closedButton.translatesAutoresizingMaskIntoConstraints = false
        closedButton.isEnabled = false
        
        closedButton.setImage(UIImage(named: "cancel"), for: .normal)
        
        let safeArea = self.view.safeAreaLayoutGuide
        closedButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        closedButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive = true
        closedButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupTitleLabel() {
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = inputData.result.title
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        label.topAnchor.constraint(equalTo: self.closedButton.bottomAnchor, constant: 15).isActive = true
        label.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15).isActive = true
    }
    
    private func setupActionButton() {
        self.view.addSubview(selectedActionButton)
        
        selectedActionButton.setTitle(inputData.result.selectedActionTitle, for: .normal)
        selectedActionButton.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        selectedActionButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 5).isActive = true
        selectedActionButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive  = true
        selectedActionButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15).isActive = true
        selectedActionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setupCollectionController() {
        self.view.addSubview(collectionView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.collectionViewLayout = layout
        
        collectionView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.selectedActionButton.topAnchor, constant: -20).isActive = true
        collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15).isActive = true
        
    }
}

extension RootViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        
        if inputData.result.list[indexPath.row].isSelected == false {
            cell?.isSelected = true
            inputData.result.list[indexPath.row].isSelected = true
        } else {
            cell?.isSelected = false
            inputData.result.list[indexPath.row].isSelected = false
            
        }
        cell?.iSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.isSelected = false
        inputData.result.list[indexPath.row].isSelected = false
        cell?.iSelected()
    }
}

extension RootViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        inputData.result.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CollectionViewCell
        cell.setupCell(withData: inputData.result.list[indexPath.row])
        
        return cell
    }
}

