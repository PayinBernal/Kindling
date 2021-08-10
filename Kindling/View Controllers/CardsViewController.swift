//
//  ViewController.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import UIKit
import Shuffle

class CardsViewController: UIViewController {
    
    var viewModels: [CardViewModel] = []
    let cardStack = SwipeCardStack()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardStack)
        view.configureBackgroundGradient()
        
        cardStack.dataSource = self
        cardStack.delegate = self
        
        layoutCardStackView()
        fetchUser()
        welcome()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? UINavigationController,
           let detailVC = nvc.viewControllers.first as? DetailViewController,
           let index = sender as? Int {
            detailVC.viewModel = viewModels[index]
        }
    }
    
    //MARK: - Private
    
    private func welcome() {
        let title = Constants.Text.welcomeTitle
        let message = Constants.Text.welcomeMessage
        
        simpleAlert(title: title, message: message)
    }
    
    private func layoutCardStackView() {
        view.addSubview(cardStack)
        
        cardStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    private func fetchUser() {
        view.showLoadingView()
        RequestsManager.request(RandomUserRequests.getUser) { [unowned self](result: Result<UserResults, APIError>) in
            self.view.removeLoadingView()
            switch result {
            case .success(let response):
                if let randomUser = response.results.first {
                    let oldModelsCount = viewModels.count
                    let newModelsCount = oldModelsCount + 1
                    viewModels.append(CardViewModel(user: randomUser))
                    
                    let newIndices = Array(oldModelsCount..<newModelsCount)
                    cardStack.appendCards(atIndices: newIndices)
                }
            case .failure:
                simpleAlert(title: "We're sorry", message: "Please check your internet connection")
            }
        }
    }

}

extension CardsViewController: SwipeCardStackDelegate {
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        performSegue(withIdentifier: "DETAIL_SEGUE", sender: index)
    }
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        fetchUser()
    }
}

extension CardsViewController: SwipeCardStackDataSource {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        let viewModel = viewModels[index]
        
        card.footerHeight = 80
        card.swipeDirections = [.left, .up, .right]
        
        card.content = KindlingCardContentView(withImageURL: URL(string: viewModel.picture))
        card.footer = KindlingCardFooterView(viewModel: viewModel)
        
        return card
    }

    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return viewModels.count
    }
}
