//
//  DetailViewController.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var viewModel: CardViewModel!
    
    let mailManager = MailComposerManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        centerMap(coordinates: viewModel.coordinates)
        annotate(coordinates: viewModel.coordinates)
        view.configureBackgroundGradient()
    }
    
    //MARK: - IBActions
    
    @IBAction func emailButtonDidTap(_ sender: Any) {
        if mailManager.canSendMail {
            mailManager.composeMail(viewController: self,
                                    recipients: [viewModel.email])
        } else {
            simpleAlert(title: "We're sorry",
                        message: "Seems like this device is unable to send mail")
        }
    }
    
    @IBAction func phoneButtonDidTap(_ sender: Any) {
        dial(phoneNumber: viewModel.phone)
    }
    
    @IBAction func cellButtonDidTap(_ sender: Any) {
        dial(phoneNumber: viewModel.cell)
    }
    
    //MARK: - Private
    
    private func setupUI() {
        title = viewModel.username.uppercased()
        nameLabel.text = "\(viewModel.name), \(viewModel.age) \(viewModel.flag)"
        
        emailButton.setTitle(viewModel.email,
                             for: .normal)
        phoneButton.setTitle(viewModel.phone,
                             for: .normal)
        cellButton.setTitle(viewModel.cell,
                             for: .normal)
        dobButton.setTitle(viewModel.formattedDOB,
                           for: .normal)
        
        cityLabel.text = viewModel.city
        stateLabel.text = viewModel.state
        countryLabel.text = viewModel.country
        
        imageView.downloaded(from: viewModel.picture,
                             contentMode: .scaleAspectFill)
    }
    
    private func centerMap(coordinates: CLLocationCoordinate2D) {
        mapView.setCenter(coordinates, animated: true)
    }
    
    private func annotate(coordinates: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
    }
    
    private func dial(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            simpleAlert(title: "We're sorry",
                        message: "Seems like this device is unable to dial a number")
        }
    }
}
