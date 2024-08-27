//
//  AddressonMapViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GoogleMapsBase
import GooglePlaces

class AddressonMapViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var enterAddressButton: CalloutBackgroundButton!
    @IBOutlet var gmsmapview: GMSMapView!

    @IBOutlet var addressView: UIView!
    @IBOutlet var addressTitleLabel: CalloutFontLabel!
    @IBOutlet var addressLabel: Caption1FontLabel!
    @IBOutlet var currentLocationButton: FootnoteOutlineButton!
    @IBOutlet var changeButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var addressonMapViewModel = AddressonMapViewModel()

    var isFrom = ""
    var addressID = ""
    var isEdit = false

    var locationManager = CLLocationManager()
    var userlatitude: CLLocationDegrees = 0.0
    var userlongitude: CLLocationDegrees = 0.0

    var currentAddress = ""

    var id = ""
    var customerName = ""
    var mobile = ""
    var addressType = ""
    var address1 = "" // street
    var address2 = "" // area
    var address3 = ""
    var landmark = ""
    var city = "" // city
    var state = "" // state
    var zipcode = "" // pincode
    var lat = ""
    var lng = ""
    var isprimary = false
    var country = ""

    let marker = GMSMarker()
    let geocoder = GMSGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Set Initial View
    func setInitialView() {

        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.addressLabel.text = self.currentAddress
        self.setUserInteractionButton()
        self.showlocationpermissionAlert()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = self.isEdit == false ? AppLocalizationString.addAddress : AppLocalizationString.editAddress
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        if !(self.address2.isEmpty) {
            self.addressTitleLabel.text = self.address2
        } else if !(self.city.isEmpty) {
            self.addressTitleLabel.text = self.city
        } else {
            self.addressTitleLabel.text = AppLocalizationString.streetslashArea
        }
        self.enterAddressButton.setTitle(AppLocalizationString.enterCompleteAddress.uppercased(), for: .normal)
    }
    // MARK: - Reload

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func reverseGeocodeWithGoogleAPI(latitude: Double, longitude: Double) {
        let apiKey = BaseKey.googleAPIKey // Replace with your Google Maps API key
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            self.showToastAlert("Invalid URL", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                self.showToastAlert("\(error.localizedDescription)", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            guard let data = data else {
                self.showToastAlert("No data received", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            DispatchQueue.main.async {

                do {
                    let geocodeResponse = try JSONDecoder().decode(GoogleAPIModel.self, from: data)
                    guard geocodeResponse.status == "OK" else {
                        self.showToastAlert("Reverse geocoding failed with status: \(String(describing: geocodeResponse.status))", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                        return
                    }

                    if let firstResult = geocodeResponse.results?.first {
                        self.address1 = "" // thoroughfare
                        self.address2 = "" // subLocality
                        self.city = "" // locality
                        self.state = "" // administrativeArea
                        self.zipcode = "" // postalCode
                        self.country = "" // country
                        self.landmark = ""
                        self.address3 = ""
                        self.currentAddress = ""
                        self.lat = String(format: "%f", latitude)
                        self.lng = String(format: "%f", longitude)

                        var streetNumber = "" // 4&5
                        var route = "" //  Rajiv Gandhi IT Expressway
                        var sublocalityLevel2 = "" // Industrial Estate
                        //                    var sublocality_level_1 = "" //Perungudi
                        //                    var locality = "" // Chennai
                        //                    var administrative_area_level_1 = "" //tamilnadu

                        if firstResult.addressComponents != nil {
                            let addressComponents: [AddressComponent] = firstResult.addressComponents!
                            if addressComponents.count > 0 {
                                for item in addressComponents {
                                    var longName = ""
                                    var types = [String]()
                                    if !(item.longName.isNilOrEmpty) {
                                        longName = item.longName!
                                    }
                                    if item.types != nil {
                                        types = item.types!
                                        if types.count > 0 {
                                            if types.contains("street_number") {
                                                streetNumber = longName
                                            } else if types.contains("route") {
                                                route = longName
                                            } else if types.contains("sublocality_level_2") {
                                                sublocalityLevel2 = longName
                                            } else if types.contains("sublocality_level_1") {
                                                self.address2 = longName
                                            } else if types.contains("locality") {
                                                self.city = longName
                                            } else if types.contains("administrative_area_level_1") {
                                                self.state = longName
                                            } else if types.contains("postal_code") {
                                                self.zipcode = longName
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        // Address
                        if !(streetNumber.isEmpty) {
                            self.address1 = streetNumber
                        }
                        if !(route.isEmpty) && !(self.address1.isEmpty) {
                            self.address1 = "\(self.address1) \(route)"
                        } else if !(route.isEmpty) && (self.address1.isEmpty) {
                            self.address1 = route
                        }
                        if !(sublocalityLevel2.isEmpty) && !(self.address1.isEmpty) {
                            self.address1 = "\(self.address1) \(sublocalityLevel2)"
                        } else if !(sublocalityLevel2.isEmpty) && (self.address1.isEmpty) {
                            self.address1 = sublocalityLevel2
                        }

                        // Current Address
                        if !(self.address1.isEmpty) {
                            self.currentAddress = self.address1
                        }
                        if !(self.address2.isEmpty) && !(self.currentAddress.isEmpty) {
                            self.currentAddress = "\(self.currentAddress) \(self.address2)"
                        } else if !(self.address2.isEmpty) && (self.currentAddress.isEmpty) {
                            self.currentAddress = self.address2
                        }
                        if !(self.city.isEmpty) && !(self.currentAddress.isEmpty) {
                            self.currentAddress = "\(self.currentAddress) \(self.city)"
                        } else if !(self.city.isEmpty) && (self.currentAddress.isEmpty) {
                            self.currentAddress = self.city
                        }
                        if !(self.state.isEmpty) && !(self.currentAddress.isEmpty) {
                            self.currentAddress = "\(self.currentAddress) \(self.state)"
                        } else if !(self.state.isEmpty) && (self.currentAddress.isEmpty) {
                            self.currentAddress = self.state
                        }
                        if !(self.zipcode.isEmpty) && !(self.currentAddress.isEmpty) {
                            self.currentAddress = "\(self.currentAddress) \(self.zipcode)"
                        } else if !(self.zipcode.isEmpty) && (self.currentAddress.isEmpty) {
                            self.currentAddress = self.zipcode
                        }

                        self.changeLanguageFormat()
                        self.addressLabel.text = self.currentAddress
                        self.setUserInteractionButton()
                    } else {}
                } catch {
                    self.showToastAlert("Error parsing geocoding response: \(error)", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                }
            }
        }
        task.resume()
    }

    // MARK: - IBAction
    @IBAction func enterAddressButtonPressed(_ sender: UIButton) {
        self.navigateToEnterAddressViewController(isFrom: isFrom, isEdit: self.isEdit, id: self.id, customerName: self.customerName, mobile: self.mobile, addressType: self.addressType, address1: self.address1, address2: self.address2, address3: self.address3, landmark: self.landmark, city: self.city, state: self.state, zipcode: self.zipcode, lat: self.lat, lng: self.lng, isprimary: self.isprimary)
    }
    @IBAction func currentLocationButton(_ sender: UIButton) {
        self.loadCurrentLocation()
    }
    @IBAction func changeButtonPressed(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt64(UInt(GMSPlaceField.name.rawValue) |
                                                                   UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue) |  UInt(GMSPlaceField.formattedAddress.rawValue) |  UInt(GMSPlaceField.coordinate.rawValue)))
        autocompleteController.placeFields = fields

        //        // Specify a filter.
        //        let filter = GMSAutocompleteFilter()
        //        filter.type = .address
        //        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if !(self.addressLabel.text.isNilOrEmpty) {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.enterAddressButton.isUserInteractionEnabled = false
        self.enterAddressButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.enterAddressButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.enterAddressButton.setNeedsDisplay()
        self.enterAddressButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.enterAddressButton.isUserInteractionEnabled = true
        self.enterAddressButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.enterAddressButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.enterAddressButton.setNeedsDisplay()
        self.enterAddressButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func showPermissionAlert() {
        let alertController = UIAlertController(title: AppLocalizationString.allowLocation, message: AppLocalizationString.allowLocation, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: AppLocalizationString.settings, style: .default, handler: {(_) in
            // Redirect to Settings app
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: AppLocalizationString.cancel, style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //    func reverseGeocoding(latitude: Double, longitude: Double) {
    //        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    //        var currentAddress = ""
    //        geocoder.reverseGeocodeCoordinate(coordinate) { response, _ in
    //            if let address = response?.firstResult() {
    //                print(address)
    //                self.address1 = "" // thoroughfare
    //                self.address2 = "" // subLocality
    //                self.city = "" // locality
    //                self.state = "" // administrativeArea
    //                self.zipcode = "" // postalCode
    //                self.country = "" // country
    //                self.landmark = ""
    //                self.address3 = ""
    //                self.currentAddress = ""
    //                self.lat = ""
    //                self.lng = ""
    //                /*
    //                 GMSAddress {
    //                 coordinate: (12.927703, 80.230911)
    //                 lines: 347, Rajiv Gandhi Salai, OMR, Thoraipakkam, Tamil Nadu 600097, India
    //                 -
    //                 }
    //                 */
    //
    //                if address.coordinate.latitude != nil {
    //                    self.lat = String(format: "%f", address.coordinate.latitude)
    //                }
    //                if address.coordinate.longitude != nil {
    //                    self.lng = String(format: "%f", address.coordinate.longitude)
    //                }
    //                if !(address.subLocality.isNilOrEmpty) {
    //                    self.address2 = address.subLocality! as String
    //                }
    //                if !(address.thoroughfare.isNilOrEmpty) {
    //                    self.address1 = address.thoroughfare! as String
    //                }
    //                if !(address.locality.isNilOrEmpty) {
    //                    self.city = address.locality! as String
    //                }
    //                if !(address.administrativeArea.isNilOrEmpty) {
    //                    self.state = address.administrativeArea! as String
    //                }
    //                if !(address.country.isNilOrEmpty) {
    //                    self.country = address.country! as String
    //                }
    //                if !(address.postalCode.isNilOrEmpty) {
    //                    self.zipcode = address.postalCode! as String
    //                }
    //                if !(self.address1.isEmpty) {
    //                    currentAddress = self.address1
    //                }
    //                if !(self.address2.isEmpty) && !(currentAddress.isEmpty) {
    //                    currentAddress = "\(currentAddress) \(self.address2)"
    //                } else if !(self.address2.isEmpty) && (currentAddress.isEmpty) {
    //                    currentAddress = self.address2
    //                }
    //                if !(self.city.isEmpty) && !(currentAddress.isEmpty) {
    //                    currentAddress = "\(currentAddress) \(self.city)"
    //                } else if !(self.city.isEmpty) && (currentAddress.isEmpty) {
    //                    currentAddress = self.city
    //                }
    //                if !(self.state.isEmpty) && !(currentAddress.isEmpty) {
    //                    currentAddress = "\(currentAddress) \(self.state)"
    //                } else if !(self.state.isEmpty) && (currentAddress.isEmpty) {
    //                    currentAddress = self.state
    //                }
    //                if !(self.zipcode.isEmpty) && !(currentAddress.isEmpty) {
    //                    currentAddress = "\(currentAddress) \(self.zipcode)"
    //                } else if !(self.zipcode.isEmpty) && (currentAddress.isEmpty) {
    //                    currentAddress = self.zipcode
    //                }
    //        }
    //            self.changeLanguageFormat()
    //            self.addressLabel.text = currentAddress
    //            self.setUserInteractionButton()
    //        }
    //    }
}

extension AddressonMapViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.addresslist.rawValue {
            self.navigateBackToAddressListViewControllerUpdated()
        } else if self.isFrom == IsNavigateFrom.addressCheckOut.rawValue {
            self.navigateBackToCheckOutViewControllerFromAddress()
        } else if self.isFrom == IsNavigateFrom.addressBookAppointment.rawValue {
            self.navigateBackToBookAppointmentAddressViewControllerFromAddress()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
    func rightButtonPressed() {
    }
}
extension AddressonMapViewController: ProtocolNetworkRechabilityDelegate {
    // MARK: - InternetError
    func showInternetPopupScreen(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Common, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.NetworkRechabilityViewController) as! NetworkRechabilityViewController
            viewCon.retryAPIID = retryAPIID
            viewCon.protocolNetworkRechabilityDelegate = self
            viewCon.modalPresentationStyle = .fullScreen
            viewCon.modalTransitionStyle = .coverVertical
            self.present(viewCon, animated: true, completion: nil)
        }
    }
    // MARK: - NetworkRechabilityDelegate
    func tryAgainWithID(retryAPIID: Int) {
        self.commonAPICALL(retryAPIID: retryAPIID)
    }
}
extension AddressonMapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    // MARK: - CLLocationManager Delegate
    func loadCurrentLocation() {
        let camera = GMSCameraPosition.camera(withLatitude: self.userlatitude, longitude: self.userlongitude, zoom: 16)
        self.gmsmapview.delegate = self
        self.gmsmapview.camera = camera
        self.gmsmapview?.animate(to: camera)
        self.gmsmapview.settings.allowScrollGesturesDuringRotateOrZoom = true

        self.marker.position = camera.target
        self.marker.title = ""
        self.marker.snippet = ""
        self.marker.map = self.gmsmapview
        self.marker.icon = UIImage(named: Asset.locationmarkerredhint)// icon_current_location

        self.reverseGeocodeWithGoogleAPI(latitude: Double(camera.target.latitude), longitude: Double(camera.target.longitude))
    }
    func showlocationpermissionAlert() {
        DispatchQueue.main.async {
            self.locationManager = CLLocationManager()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.distanceFilter = 50
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            self.locationManager.stopUpdatingLocation()
            self.currentLocationButton.isHidden = true
            self.showPermissionAlert()
            // this will access location automatically if user granted access manually. and will not show apple's request alert twice. (Tested)
            break
        case .denied:
            self.locationManager.stopUpdatingLocation()
            self.currentLocationButton.isHidden = true
            self.showPermissionAlert()
            break
        case .restricted:
            self.locationManager.stopUpdatingLocation()
            self.currentLocationButton.isHidden = true
            self.showPermissionAlert()
            break
        case .authorizedWhenInUse:
            self.currentLocationButton.isHidden = false
            self.locationManager.startUpdatingLocation() // Will update location immediately
            break
        case .authorizedAlways:
            self.currentLocationButton.isHidden = false
            self.locationManager.startUpdatingLocation() // Will update location immediately
            break
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        self.userlatitude = (location?.coordinate.latitude)!
        self.userlongitude = (location?.coordinate.longitude)!
        self.locationManager.stopMonitoringSignificantLocationChanges()
        self.locationManager.stopUpdatingLocation()

        if self.isEdit == false {
            self.lat = String(format: "%f", (location?.coordinate.latitude)!)
            self.lng = String(format: "%f", (location?.coordinate.longitude)!)
            let camera = GMSCameraPosition.camera(withLatitude: self.userlatitude, longitude: self.userlongitude, zoom: 16)
            self.gmsmapview.delegate = self
            self.gmsmapview.camera = camera
            self.gmsmapview?.animate(to: camera)
            self.gmsmapview.settings.allowScrollGesturesDuringRotateOrZoom = true
            self.reverseGeocodeWithGoogleAPI(latitude: Double(camera.target.latitude), longitude: Double(camera.target.longitude))
        } else {
            if (self.lat.isEmpty) || (self.lng.isEmpty) {
                self.lat = String(format: "%f", (location?.coordinate.latitude)!)
                self.lng = String(format: "%f", (location?.coordinate.longitude)!)
                let camera = GMSCameraPosition.camera(withLatitude: self.userlatitude, longitude: self.userlongitude, zoom: 16)
                self.gmsmapview.delegate = self
                self.gmsmapview.camera = camera
                self.gmsmapview?.animate(to: camera)
                self.gmsmapview.settings.allowScrollGesturesDuringRotateOrZoom = true

                self.reverseGeocodeWithGoogleAPI(latitude: Double(camera.target.latitude), longitude: Double(camera.target.longitude))
            } else {
                let camera = GMSCameraPosition.camera(withLatitude: Double(self.lat)!, longitude: Double(self.lng)!, zoom: 16)
                self.gmsmapview.delegate = self
                self.gmsmapview.camera = camera
                self.gmsmapview?.animate(to: camera)
                self.gmsmapview.settings.allowScrollGesturesDuringRotateOrZoom = true

                //                self.reverseGeocodeWithGoogleAPI(latitude: Double(self.lat)!, longitude: Double(self.lng)!)
                //
            }
        }
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        // do something
        self.marker.position = position.target
        self.marker.title = ""
        self.marker.snippet = ""
        self.marker.map = self.gmsmapview
        self.marker.icon = UIImage(named: Asset.locationmarkerredhint)// icon_current_location

        self.reverseGeocodeWithGoogleAPI(latitude: Double(self.marker.position.latitude), longitude: Double(self.marker.position.longitude))
    }
}
extension AddressonMapViewController: GMSAutocompleteViewControllerDelegate {
    // MARK: - GMSAutocompleteViewController Delegate
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //        print("Place name: \(place.name)")
        //        print("Place ID: \(place.placeID)")
        //        print("Place attributions: \(place.attributions)")
        //        print("Place addressComponents: \(place.addressComponents)")
        //        print("Place formattedAddress: \(place.formattedAddress)")
        //        print("Place coordinate: \(place.coordinate)")

        self.lat = String(format: "%f", (place.coordinate.latitude))
        self.lng = String(format: "%f", (place.coordinate.longitude))

        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16)
        self.gmsmapview.delegate = self
        self.gmsmapview.camera = camera
        self.gmsmapview?.animate(to: camera)
        self.gmsmapview.settings.allowScrollGesturesDuringRotateOrZoom = true
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
