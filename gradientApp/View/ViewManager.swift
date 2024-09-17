//
//  ViewManager.swift
//  gradientApp
//
//  Created by Рамазан Абайдулла on 24.05.2024.
//

import UIKit

class ViewManager {
    
    var controller: UIViewController
    var view: UIView
    private var headerStack = UIStackView()
    private let viewService = ViewService.shared
    private var cardsStack = UIStackView()
    
    private lazy var width: CGFloat = {
        return (view.frame.width / 2) - 40
    }()
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    func createAppHeader(title: String) {
         headerStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        
        let headerLabel = {
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .white
            label.numberOfLines = 0
            return label
        }()
        
        let headerButton = {
            let button = UIButton(primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 31).isActive = true
            button.heightAnchor.constraint(equalToConstant: 31).isActive = true
            button.layer.cornerRadius = 16
            button.tintColor = .white
            
            let gradient = viewService.gradientLayer(startColor: UIColor(hex: "#B2A1F7FF"), frame: CGRect(x: 0, y: 0, width: 31, height: 31))
            button.layer.addSublayer(gradient)
            
            button.clipsToBounds = true
            
            let buttonImage: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "magnifyingglass")
                image.translatesAutoresizingMaskIntoConstraints = false
                image.widthAnchor.constraint(equalToConstant: 18).isActive = true
                image.heightAnchor.constraint(equalToConstant: 18).isActive = true
                
                return image
            }()
            
            button.addSubview(buttonImage)
            buttonImage.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
            buttonImage.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            
            return button
        }()
        
        
        
        headerStack.addArrangedSubview(headerLabel)
        headerStack.addArrangedSubview(headerButton)
        
        view.addSubview(headerStack)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            headerStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
     
        
    }
    
    func createCards() {
        
        let tikTokCard = createLongCardContent(for: viewService.createCardView( gradientColor: "#58cfefff",
            width: width), image: .tiktok, title: "TikTok \nads", rate: 4.9, views: 41209)
        
        let clockCard = createShortCardContent(for: viewService.createCardView(gradientColor: "#58D6B9FF", width: width), image: .clock, title: "Art & Draw")
        
        let instaCard = createShortCardContent(for: viewService.createCardView(gradientColor: "E79DA7FF", width: width), image: .instagram, title: "Instagram")
        
        let youtubeCard = createLongCardContent(for: viewService.createCardView( gradientColor: "#B2A1F7ff",
            width: width), image: .youtube, title: "YouTube \nads", rate: 4.9, views: 125409)
        
        let lStack = viewService.getSideStack(items: [tikTokCard, clockCard])
        let rStack = viewService.getSideStack(items: [instaCard, youtubeCard])
        
        cardsStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(lStack)
            stack.addArrangedSubview(rStack)
            return stack
        }()
        
        view.addSubview(cardsStack)
        
        NSLayoutConstraint.activate([
            cardsStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 30),
            cardsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cardsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func createLongCardContent(for item: UIView, image: UIImage, title: String,
                                       rate: Float, views: Int) -> UIView {
        let cardImage = viewService.createCardImage(image: image)
        let cardTitle = viewService.createCardTitle(title: title)
        let rateStack = viewService.createRateStack(rate: rate)
        let viewsStack = viewService.getViewsLabel(views: views)
        
        lazy var topStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 12
            stack.alignment = .leading
            stack.addArrangedSubview(cardImage)
            stack.addArrangedSubview(cardTitle)
            return stack
        }()
        lazy var bottomStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 2
            stack.alignment = .leading
            stack.addArrangedSubview(rateStack)
            stack.addArrangedSubview(viewsStack)
            return stack
        }()
        
        let mainStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .leading
            stack.spacing = 21
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(topStack)
            stack.addArrangedSubview(bottomStack)
            
            return stack
        }()
        
        item.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: item.topAnchor, constant: 25),
            mainStack.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -27),
            mainStack.leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: -25),
        ])
        
        return item
    }
    
    private func createShortCardContent(for item: UIView, image: UIImage, title: String) -> UIView {
        let cardImage = viewService.createCardImage(image: image)
        let cardTitle = viewService.createCardTitle(title: title)
        
        let nextButton = {
            let btn = UIButton(primaryAction: nil)
            btn.setImage(UIImage(systemName: "arrow.right") , for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            
            btn.widthAnchor.constraint(equalToConstant: 14).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 14).isActive = true
            btn.tintColor = .white
            return btn
        }()
        
        let hStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.addArrangedSubview(cardImage)
            stack.addArrangedSubview(nextButton)
            
            return stack
        }()
        
        let vStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 13
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(hStack)
            stack.addArrangedSubview(cardTitle)
            
            return stack
        }()
        
        item.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: item.topAnchor, constant: 25),
            vStack.leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: 25),
            vStack.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -30),
            vStack.trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: -25),
        ])
        
        return item
    }
    
    func createService() {
        let headerLabel: UILabel = {
            let label = UILabel()
            label.text = "Лучшие сервисы"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .white
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(headerLabel)
        
        
        let serviceCard = {
            let serviceCard = UIView()
            serviceCard.translatesAutoresizingMaskIntoConstraints = false
            serviceCard.layer.cornerRadius = 25
            serviceCard.layer.cornerCurve = .continuous
            
            let gradient = viewService.gradientLayer(startColor: UIColor(hex: "949Ac5FF"),
            frame: CGRect(x: 0, y: 0, width: 400, height: 200))
            serviceCard.layer.addSublayer(gradient)
            serviceCard.clipsToBounds = true
            
            return serviceCard
        }()
        
        view.addSubview(serviceCard)
        
        let serviceImage = {
           let img = UIImageView()
            img.image = .baner
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            
            return img
        }()
        
        let serviceCardTitle = viewService.createCardTitle(title: "Design & \nDevelopment")
        let rate = viewService.createRateStack(rate: 4.9)
        
        let infoImage = {
            let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.image = .comp
            img.widthAnchor.constraint(equalToConstant: 15).isActive = true
            img.heightAnchor.constraint(equalToConstant: 15).isActive = true
            return img
        }()
        
        let infoTitle = {
            let title = UILabel()
            title.text = "Complete Design"
            title.font = UIFont.systemFont(ofSize: 12, weight: .light)
            title.textColor = .white
                
            return title
        }()
        
        let infoStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .leading
            stack.spacing = 5
            stack.addArrangedSubview(infoImage)
            stack.addArrangedSubview(infoTitle)
            
            return stack
        }()
        
        let priceLabel = {
            let label = UILabel()
            label.text = "$4122"
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textColor = .white
            
            return label
        }()
        
        let vStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .leading
            stack.spacing = 5
            
            stack.addArrangedSubview(serviceCardTitle)
            stack.addArrangedSubview(rate)
            stack.addArrangedSubview(infoStack)
            stack.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5)))
            stack.addArrangedSubview(priceLabel)
            return stack
        }()
        
        let hStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(serviceImage)
            stack.addArrangedSubview(vStack)
            return stack
        }()
        
        view.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: cardsStack.bottomAnchor, constant: 40),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            serviceCard.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            serviceCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            serviceCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            hStack.topAnchor.constraint(equalTo: serviceCard.topAnchor, constant: 25),
            hStack.leadingAnchor.constraint(equalTo: serviceCard.leadingAnchor, constant: 25),
            hStack.trailingAnchor.constraint(equalTo: serviceCard.trailingAnchor, constant: -25),
            hStack.bottomAnchor.constraint(equalTo: serviceCard.bottomAnchor, constant: -25),
        ])
    }
    
}
