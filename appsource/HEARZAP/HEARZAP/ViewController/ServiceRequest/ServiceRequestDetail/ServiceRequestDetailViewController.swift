//
//  ServiceRequestDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 05/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ServiceRequestDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var bookingDetailsTitleLabel: HeadlineFontLabel!

    @IBOutlet var AddressInfoStackView: UIStackView!

    @IBOutlet var serviceTypeLabel: CalloutFontLabel!
    @IBOutlet var serviceDateStatusLabel: Caption1FontLabel!

    @IBOutlet var serviceVisitTypeLabel: Caption1FontLabel!
    @IBOutlet var AddressInfoLabel: Caption1FontLabel!
    @IBOutlet var serviceLocationTypeLabel: Caption1FontLabel!

    @IBOutlet var shareOtpLabel: Caption1FontLabel!
    @IBOutlet var otpButton: FootnoteBackgroundButton!

    @IBOutlet var meetingStackView: UIStackView!

    @IBOutlet var meetingLinkTitleLabel: Caption1FontLabel!
    @IBOutlet var meetinglinkLabel: Caption1FontLabel!

    @IBOutlet var joinNowButton: CalloutBackgroundButton!

    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var cancelButton: FootnoteOutlineButton!
    @IBOutlet var needHelpButton: FootnoteOutlineButton!

    @IBOutlet var informationStackView: UIStackView!
    @IBOutlet var bookingInformationStackView: UIStackView!
    @IBOutlet var bookinginformationTitleLabel: CalloutFontLabel!

    @IBOutlet var bookingIDTitleLabel: Caption1FontLabel!
    @IBOutlet var bookingIDLabel: Caption1FontLabel!

    @IBOutlet var appointmentDateTimeTitleLabel: Caption1FontLabel!
    @IBOutlet var appointmentDateTimeLabel: Caption1FontLabel!

    @IBOutlet var bookingDateTitleLabel: Caption1FontLabel!
    @IBOutlet var bookingDateLabel: Caption1FontLabel!

    @IBOutlet var bookingAmountTitleLabel: Caption1FontLabel!
    @IBOutlet var bookingAmountLabel: Caption1FontLabel!

    @IBOutlet var bookingStatusTitleLabel: Caption1FontLabel!
    @IBOutlet var bookingStatusLabel: Caption1FontLabel!

    @IBOutlet var cancellationDateTitleLabel: Caption1FontLabel!
    @IBOutlet var cancellationDateLabel: Caption1FontLabel!

    @IBOutlet var cancellationReasonTitleLabel: Caption1FontLabel!
    @IBOutlet var cancellationReasonLabel: Caption1FontLabel!
    
    @IBOutlet var cancellationCommentTitleLabel: Caption1FontLabel!
    @IBOutlet var cancellationCommentLabel: Caption1FontLabel!

    @IBOutlet var refundStatusTitleLabel: Caption1FontLabel!
    @IBOutlet var refundStatusLabel: Caption1FontLabel!

    @IBOutlet var refundAmountTitleLabel: Caption1FontLabel!
    @IBOutlet var refundAmountLabel: Caption1FontLabel!

    //    @IBOutlet var bookingSepartorView: UIView!

    @IBOutlet var serviceQuantityStackView: UIStackView!
    @IBOutlet var serviceQuantityTitleLabel: CalloutFontLabel!

    @IBOutlet var serviceQuantityTableView: UITableView!
    @IBOutlet var serviceQuantityTableViewHeight: NSLayoutConstraint!
    @IBOutlet var serviceQuantitySepartorView: UIView!

    @IBOutlet var patientStackView: UIStackView!
    @IBOutlet var patientInformationTitleLabel: CalloutFontLabel!

    @IBOutlet var patientNameTitleLabel: Caption1FontLabel!
    @IBOutlet var patientNameLabel: Caption1FontLabel!

    @IBOutlet var patientAgeTitleLabel: Caption1FontLabel!
    @IBOutlet var patientAgeLabel: Caption1FontLabel!

    @IBOutlet var patientGenderTitleLabel: Caption1FontLabel!
    @IBOutlet var patientGenderLabel: Caption1FontLabel!

    @IBOutlet var patientRelationshipTitleLabel: Caption1FontLabel!
    @IBOutlet var patientRelationshipLabel: Caption1FontLabel!

    @IBOutlet var staffDetailsTitleLabel: HeadlineFontLabel!

    @IBOutlet var staffDetailsStackView: UIStackView!

    @IBOutlet var executiveStackView: UIStackView!
    @IBOutlet var executiveTitleLabel: CalloutFontLabel!

    @IBOutlet var executiveImageView: UIImageView!
    @IBOutlet var executiveNameLabel: CalloutFontLabel!
    @IBOutlet var executiveExperienceLabel: Caption1FontLabel!
    @IBOutlet var executiveSpecialisationLabel: Caption1FontLabel!

    @IBOutlet var executiveContentLabel: Caption1FontLabel!

    @IBOutlet var executiveinfoStackview: UIStackView!
    @IBOutlet var executiveRatingLabel: Caption1FontLabel!
    @IBOutlet var executiveVaccinatedLabel: Caption1FontLabel!

    @IBOutlet var executiveTagView: UIView!
    @IBOutlet var executiveTagCollectionView: UICollectionView!
    @IBOutlet var executiveTagCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var executiveCallButton: FootnoteOutlineButton!
    @IBOutlet var executiveTrackButton: FootnoteOutlineButton!
    @IBOutlet var executiveRateButton: FootnoteOutlineButton!

    @IBOutlet var audiologistStackView: UIStackView!
    @IBOutlet var audiologistTitleLabel: CalloutFontLabel!

    @IBOutlet var audiologistImageView: UIImageView!
    @IBOutlet var audiologistNameLabel: CalloutFontLabel!
    @IBOutlet var audiologistExperienceLabel: Caption1FontLabel!
    @IBOutlet var audiologistSpecialisationLabel: Caption1FontLabel!

    @IBOutlet var audiologistContentLabel: Caption1FontLabel!

    @IBOutlet var audiologistInfoStackview: UIStackView!
    @IBOutlet var audiologistRatingLabel: Caption1FontLabel!
    @IBOutlet var audiologistVaccinatedLabel: Caption1FontLabel!

    @IBOutlet var audiologistTagView: UIView!
    @IBOutlet var audiologistTagCollectionView: UICollectionView!
    @IBOutlet var audiologistTagCollectionViewHeight: NSLayoutConstraint!

    //     @IBOutlet var audiologistCallButton: CalloutOutlineButton!
    //     @IBOutlet var audiologistTrackButton: CalloutOutlineButton!
    @IBOutlet var audiologistRateButton: FootnoteOutlineButton!

    @IBOutlet var serviceRequestTitleLabel: HeadlineFontLabel!

    @IBOutlet var SRStackView: UIStackView!

    @IBOutlet var audiogramStackView: UIStackView!
    @IBOutlet var audiogramTitleLabel: CalloutFontLabel!
    @IBOutlet var audiogramStatus: FootnoteBackgroundButton!

    @IBOutlet var audiogramTimelineLabel: FootnoteFontLabel!

    @IBOutlet var audiogramTimelineTableView: UITableView!
    @IBOutlet var audiogramTimelineTableViewHeight: NSLayoutConstraint!

    @IBOutlet var downloadReportButton: FootnoteOutlineButton!
    @IBOutlet var trialStackView: UIStackView!
    @IBOutlet var trialTitleLabel: CalloutFontLabel!
    @IBOutlet var trialStatus: FootnoteBackgroundButton!
    @IBOutlet var trialDeviceStackView: UIStackView!

    @IBOutlet var trialLeftDeviceTitleLabel: Caption1FontLabel!
    @IBOutlet var trialLeftDeviceLabel: Caption1FontLabel!

    @IBOutlet var trialRightDeviceTitleLabel: Caption1FontLabel!
    @IBOutlet var trialRightDeviceLabel: Caption1FontLabel!

    @IBOutlet var trialEndDateTitleLabel: Caption1FontLabel!
    @IBOutlet var trialEndDateLabel: Caption1FontLabel!

    @IBOutlet var trialSecurityDepositTitleLabel: Caption1FontLabel!
    @IBOutlet var trialSecurityDepositLabel: Caption1FontLabel!

    @IBOutlet var trialDepositMessageLabel: Caption1FontLabel!

    @IBOutlet var trialTimelineLabel: FootnoteFontLabel!

    @IBOutlet var trialTimelineTableView: UITableView!
    @IBOutlet var trialTimelineTableViewHeight: NSLayoutConstraint!

    @IBOutlet var trialContactButton: FootnoteOutlineButton!

    @IBOutlet var trialPickStackView: UIStackView!
    @IBOutlet var trialPickTitleLabel: CalloutFontLabel!
    @IBOutlet var trialPickStatus: FootnoteBackgroundButton!

    @IBOutlet var trialPickDeviceStackView: UIStackView!

    @IBOutlet var trialPickLeftDeviceTitleLabel: Caption1FontLabel!
    @IBOutlet var trialPickLeftDeviceLabel: Caption1FontLabel!

    @IBOutlet var trialPickRightDeviceTitleLabel: Caption1FontLabel!
    @IBOutlet var trialPickRightDeviceLabel: Caption1FontLabel!

    @IBOutlet var trialPickEndDateTitleLabel: Caption1FontLabel!
    @IBOutlet var trialPickEndDateLabel: Caption1FontLabel!

    @IBOutlet var trialPickSecurityDepositTitleLabel: Caption1FontLabel!
    @IBOutlet var trialPickSecurityDepositLabel: Caption1FontLabel!

    @IBOutlet var trialPickDepositMessageLabel: Caption1FontLabel!

    @IBOutlet var trialPickTimelineLabel: FootnoteFontLabel!

    @IBOutlet var trialPickTimelineTableView: UITableView!
    @IBOutlet var trialPickTimelineTableViewHeight: NSLayoutConstraint!

    @IBOutlet var trialPickContactButton: FootnoteOutlineButton!

    @IBOutlet var tuningStackView: UIStackView!
    @IBOutlet var tuningTitleLabel: CalloutFontLabel!
    @IBOutlet var tuningStatus: FootnoteBackgroundButton!

    @IBOutlet var tuningDeviceListTableView: UITableView!
    @IBOutlet var tuningDeviceListTableViewHeight: NSLayoutConstraint!

    @IBOutlet var tuningSummaryLabel: FootnoteFontLabel!
    @IBOutlet var tuningSummaryTableView: UITableView!
    @IBOutlet var tuningSummaryTableViewHeight: NSLayoutConstraint!

    @IBOutlet var tuningTimelineLabel: FootnoteFontLabel!

    @IBOutlet var tuningTimelineTableView: UITableView!
    @IBOutlet var tuningTimelineTableViewHeight: NSLayoutConstraint!

    @IBOutlet var serviceStackView: UIStackView!
    @IBOutlet var serviceTitleLabel: CalloutFontLabel!
    @IBOutlet var serviceStatus: FootnoteBackgroundButton!

    @IBOutlet var serviceDeviceListTableView: UITableView!
    @IBOutlet var serviceDeviceListTableViewHeight: NSLayoutConstraint!

    @IBOutlet var serviceSummaryTitleLabel: FootnoteFontLabel!

    @IBOutlet var servicePhotoCollectionView: UICollectionView!
    @IBOutlet var servicePhotoCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var intialQuoteTitleLabel: Caption1FontLabel!
    @IBOutlet var intialQuoteLabel: Caption1FontLabel!

    @IBOutlet var revisedQuoteTitleLabel: Caption1FontLabel!
    @IBOutlet var revisedQuoteLabel: Caption1FontLabel!

    @IBOutlet var serviceDeviceQuoteTableView: UITableView!
    @IBOutlet var serviceDeviceQuoteTableViewHeight: NSLayoutConstraint!

    @IBOutlet var serviceChargeTitleLabel: Caption1FontLabel!
    @IBOutlet var serviceChargeLabel: Caption1FontLabel!

    @IBOutlet var remarkTitleLabel: Caption1FontLabel!
    @IBOutlet var remarkLabel: Caption1FontLabel!

    @IBOutlet var servicePolicyCheckButton: FootnoteOutlineButton!
    @IBOutlet var servicePolicyLabel: Caption1FontLabel!

    @IBOutlet var serviceButtonStackView: UIStackView!
    @IBOutlet var approveButton: FootnoteBackgroundButton!
    @IBOutlet var serviceContactButton: FootnoteOutlineButton!

    @IBOutlet var serviceTimelineLabel: FootnoteFontLabel!

    @IBOutlet var serviceTimelineTableView: UITableView!
    @IBOutlet var serviceTimelineTableViewHeight: NSLayoutConstraint!

    @IBOutlet var serviceReturnStackView: UIStackView!
    @IBOutlet var serviceReturnTitleLabel: CalloutFontLabel!
    @IBOutlet var serviceReturnStatus: FootnoteBackgroundButton!

    @IBOutlet var serviceReturnDeviceListTableView: UITableView!
    @IBOutlet var serviceReturnDeviceListTableViewHeight: NSLayoutConstraint!

    @IBOutlet var serviceReturnSummaryTitleLabel: FootnoteFontLabel!

    @IBOutlet var serviceReturnPhotoCollectionView: UICollectionView!
    @IBOutlet var serviceReturnPhotoCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var intialQuoteReturnTitleLabel: Caption1FontLabel!
    @IBOutlet var intialQuoteReturnLabel: Caption1FontLabel!

    @IBOutlet var revisedQuoteReturnTitleLabel: Caption1FontLabel!
    @IBOutlet var revisedQuoteReturnLabel: Caption1FontLabel!

    @IBOutlet var serviceReturnDeviceQuoteTableView: UITableView!
    @IBOutlet var serviceReturnDeviceQuoteTableViewHeight: NSLayoutConstraint!

    @IBOutlet var serviceChargeReturnTitleLabel: Caption1FontLabel!
    @IBOutlet var serviceChargeReturnLabel: Caption1FontLabel!

    @IBOutlet var remarkReturnTitleLabel: Caption1FontLabel!
    @IBOutlet var remarkReturnLabel: Caption1FontLabel!

    @IBOutlet var serviceReturnTimelineLabel: FootnoteFontLabel!

    @IBOutlet var serviceReturnTimelineTableView: UITableView!
    @IBOutlet var serviceReturnTimelineTableViewHeight: NSLayoutConstraint!

    @IBOutlet var onlineConsultationStackView: UIStackView!
    @IBOutlet var onlineConsultationTitleLabel: CalloutFontLabel!
    @IBOutlet var onlineConsultationStatus: FootnoteBackgroundButton!

    @IBOutlet var onlineConsultationConcersLabel: FootnoteFontLabel!

    @IBOutlet var onlineConsultationConcersTableView: UITableView!
    @IBOutlet var onlineConsultationConcersTableViewHeight: NSLayoutConstraint!

    @IBOutlet var onlineConsultationInfoStackView: UIStackView!
    @IBOutlet var onlineConsultationInfoLabel: FootnoteFontLabel!
    @IBOutlet var ocjoinNowButton: FootnoteOutlineButton!

    @IBOutlet var linkView: UIView!
    @IBOutlet var linkLabel: Caption1FontLabel!

    @IBOutlet var onlineConsultationSummaryTitleLabel: FootnoteFontLabel!
    @IBOutlet var onlineConsultationSummaryMessagelabel: Caption1FontLabel!
    @IBOutlet var onlineConsultationSummarydatelabel: Caption1FontLabel!

    @IBOutlet var onlineConsultationTimelineLabel: FootnoteFontLabel!

    @IBOutlet var onlineConsultationTimelineTableView: UITableView!
    @IBOutlet var onlineConsultationTimelineTableViewHeight: NSLayoutConstraint!

    @IBOutlet var paymentStackView: UIStackView!

    @IBOutlet var paymentDetailsTilteLabel: CalloutFontLabel!

    @IBOutlet var paymentAmountTitlelineLabel: Caption1FontLabel!
    @IBOutlet var paymentAmountLabel: Caption1FontLabel!

    @IBOutlet var paymentModeTitlelineLabel: Caption1FontLabel!
    @IBOutlet var paymentModeLabel: Caption1FontLabel!

    @IBOutlet var paymentIdTitlelineLabel: Caption1FontLabel!
    @IBOutlet var paymentIdLabel: Caption1FontLabel!

    @IBOutlet var paymentDateTitlelineLabel: Caption1FontLabel!
    @IBOutlet var paymentDateLabel: Caption1FontLabel!

    @IBOutlet var downloadButtonStackView: UIStackView!
    @IBOutlet var downloadReceiptButton: FootnoteOutlineButton!
    @IBOutlet var downloadInvoiceButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var serviceRequestDetailViewModel = ServiceRequestDetailViewModel()

    var bookingUid = ""
    var isFrom = ""
    var invoiceDocument = ""
    var paymentReceipt = ""

    var cancelReasonList = [SRDModelCancelReasonList]()
    var serviceRequestsList = [SRDModelServiceRequestsList]()

    var executiveLangPreferenceArray = [String]()
    let executiveTagCollectionViewMargin = CGFloat(0)
    let executiveTagCollectionViewItemSpacing = CGFloat(6)
    var executiveTagCollectionViewItemHeight = CGFloat(178)
    var executiveTagCollectionViewItemWidth = CGFloat(139)
    let executiveTagCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var trackLink = ""
    var callNumber = ""

    var audiologistLangPreferenceArray = [String]()
    let audiologistTagCollectionViewMargin = CGFloat(0)
    let audiologistTagCollectionViewItemSpacing = CGFloat(6)
    var audiologistTagCollectionViewItemHeight = CGFloat(178)
    var audiologistTagCollectionViewItemWidth = CGFloat(139)
    let audiologistTagCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var audiogramTimelineList = [SRDModelServiceTimeline]()
    var downloadReportLink = ""
    var trialTimelineList = [SRDModelServiceTimeline]()
    var trialPickTimelineList = [SRDModelServiceTimeline]()

    var trialPickupTimelineList = [SRDModelServiceTimeline]()

    var tuningTimelineList = [SRDModelServiceTimeline]()
    var tuningSummaryList = [SRDModelTuningComplaint]()
    var tuningDeviceList = [SRDModelTuningComplaint]()

    var hearingAidServiceTimelineList = [SRDModelServiceTimeline]()
    var hearingAidServiceSummaryList = [SRDModelServiceDevice]()
    var hearingAidServiceDeviceList = [SRDModelServiceDevice]()
    var hearingAidServicePhotoList = [String]()

    let servicePhotoCollectionViewMargin = CGFloat(0)
    let servicePhotoCollectionViewItemSpacing = CGFloat(6)
    var servicePhotoCollectionViewItemHeight = CGFloat(129)
    var servicePhotoCollectionViewItemWidth = CGFloat(307)
    let servicePhotoCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var hearingAidServiceReturnTimelineList = [SRDModelServiceTimeline]()
    var hearingAidServiceReturnSummaryList = [SRDModelServiceDevice]()
    var hearingAidServiceReturnDeviceList = [SRDModelServiceDevice]()
    var hearingAidServiceReturnPhotoList = [String]()

    let serviceReturnPhotoCollectionViewMargin = CGFloat(0)
    let serviceReturnPhotoCollectionViewItemSpacing =  CGFloat(16)
    var serviceReturnPhotoCollectionViewItemHeight = CGFloat(129)
    var serviceReturnPhotoCollectionViewItemWidth = CGFloat(307)
    let serviceReturnPhotoCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var isTermsSelected = false

    var onlineConsultationTimelineList = [SRDModelServiceTimeline]()
    var onlineConsultationConcernsList = [SRDModelQuestion]()

    var meetingLink = ""
    var ocmeetingLink = ""

    var staffname = ""
    var staffexperience = ""
    var staffspecialisation = ""
    var staffimage = ""
    var staffid = ""

    var audiologistname = ""
    var audiologistexperience = ""
    var audiologistspecialisation = ""
    var audiologistimage = ""
    var audiologistid = ""

    var serviceuid = ""

    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.executiveLangPreferenceArray.count > 0 {
            self.executiveTagCollectionViewHeight.constant = CGFloat(tagHeight)
        } else {
            self.executiveTagCollectionViewHeight.constant = 0
        }
        if self.audiologistLangPreferenceArray.count > 0 {
            self.audiologistTagCollectionViewHeight.constant = CGFloat(tagHeight)
        } else {
            self.audiologistTagCollectionViewHeight.constant = 0
        }

        if self.serviceRequestsList.count > 0 {
            self.serviceQuantityTableViewHeight.constant = serviceQuantityTableView.contentSize.height
        } else {
            self.serviceQuantityTableViewHeight.constant = 0
        }
        if self.audiogramTimelineList.count > 0 {
            self.audiogramTimelineTableViewHeight.constant = audiogramTimelineTableView.contentSize.height
        } else {
            self.audiogramTimelineTableViewHeight.constant = 0
        }
        if self.trialTimelineList.count > 0 {
            self.trialTimelineTableViewHeight.constant = trialTimelineTableView.contentSize.height
        } else {
            self.trialTimelineTableViewHeight.constant = 0
        }
        if self.trialPickTimelineList.count > 0 {
            self.trialPickTimelineTableViewHeight.constant = trialPickTimelineTableView.contentSize.height
        } else {
            self.trialPickTimelineTableViewHeight.constant = 0
        }
        if self.tuningTimelineList.count > 0 {
            self.tuningTimelineTableViewHeight.constant = tuningTimelineTableView.contentSize.height
        } else {
            self.tuningTimelineTableViewHeight.constant = 0
        }
        if self.tuningSummaryList.count > 0 {
            self.tuningSummaryTableViewHeight.constant = tuningSummaryTableView.contentSize.height
        } else {
            self.tuningSummaryTableViewHeight.constant = 0
        }
        if self.tuningDeviceList.count > 0 {
            self.tuningDeviceListTableViewHeight.constant = tuningDeviceListTableView.contentSize.height
        } else {
            self.tuningDeviceListTableViewHeight.constant = 0
        }
        if self.hearingAidServiceDeviceList.count > 0 {
            self.serviceDeviceListTableViewHeight.constant = serviceDeviceListTableView.contentSize.height
        } else {
            self.serviceDeviceListTableViewHeight.constant = 0
        }
        if self.hearingAidServiceSummaryList.count > 0 {
            self.serviceDeviceQuoteTableViewHeight.constant = serviceDeviceQuoteTableView.contentSize.height
        } else {
            self.serviceDeviceQuoteTableViewHeight.constant = 0
        }
        if self.hearingAidServiceTimelineList.count > 0 {
            self.serviceTimelineTableViewHeight.constant = serviceTimelineTableView.contentSize.height
        } else {
            self.serviceTimelineTableViewHeight.constant = 0
        }
        if self.hearingAidServiceReturnDeviceList.count > 0 {
            self.serviceReturnDeviceListTableViewHeight.constant = serviceReturnDeviceListTableView.contentSize.height
        } else {
            self.serviceReturnDeviceListTableViewHeight.constant = 0
        }
        if self.hearingAidServiceReturnSummaryList.count > 0 {
            self.serviceReturnDeviceQuoteTableViewHeight.constant = serviceReturnDeviceQuoteTableView.contentSize.height
        } else {
            self.serviceReturnDeviceQuoteTableViewHeight.constant = 0
        }
        if self.hearingAidServiceReturnTimelineList.count > 0 {
            self.serviceReturnTimelineTableViewHeight.constant = serviceReturnTimelineTableView.contentSize.height
        } else {
            self.serviceReturnTimelineTableViewHeight.constant = 0
        }
        if self.onlineConsultationTimelineList.count > 0 {
            self.onlineConsultationTimelineTableViewHeight.constant = onlineConsultationTimelineTableView.contentSize.height
        } else {
            self.onlineConsultationTimelineTableViewHeight.constant = 0
        }
        if self.onlineConsultationConcernsList.count > 0 {
            self.onlineConsultationConcersTableViewHeight.constant = onlineConsultationConcersTableView.contentSize.height
        } else {
            self.onlineConsultationConcersTableViewHeight.constant = 0
        }
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

        self.trialContactButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.trialContactButton.layer.borderWidth = 1.0

        self.trialPickContactButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.trialPickContactButton.layer.borderWidth = 1.0

        self.serviceContactButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.serviceContactButton.layer.borderWidth = 1.0

        self.serviceQuantityTableView.tableFooterView = UIView()
        self.serviceQuantityTableView.separatorColor = UIColor.clear
        self.serviceQuantityTableView.backgroundColor = UIColor.clear
        self.serviceQuantityTableView.rowHeight = UITableView.automaticDimension
        self.serviceQuantityTableView.estimatedRowHeight = UITableView.automaticDimension

        self.audiogramTimelineTableView.tableFooterView = UIView()
        self.audiogramTimelineTableView.separatorColor = UIColor.clear
        self.audiogramTimelineTableView.backgroundColor = UIColor.clear
        self.audiogramTimelineTableView.rowHeight = UITableView.automaticDimension
        self.audiogramTimelineTableView.estimatedRowHeight = UITableView.automaticDimension

        self.downloadReportButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.downloadReportButton.layer.borderWidth = 1.0
        self.downloadReportButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.downloadReportButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.downloadReportButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF

        self.trialTimelineTableView.tableFooterView = UIView()
        self.trialTimelineTableView.separatorColor = UIColor.clear
        self.trialTimelineTableView.backgroundColor = UIColor.clear
        self.trialTimelineTableView.rowHeight = UITableView.automaticDimension
        self.trialTimelineTableView.estimatedRowHeight = UITableView.automaticDimension

        self.trialPickTimelineTableView.tableFooterView = UIView()
        self.trialPickTimelineTableView.separatorColor = UIColor.clear
        self.trialPickTimelineTableView.backgroundColor = UIColor.clear
        self.trialPickTimelineTableView.rowHeight = UITableView.automaticDimension
        self.trialPickTimelineTableView.estimatedRowHeight = UITableView.automaticDimension

        self.tuningDeviceListTableView.tableFooterView = UIView()
        self.tuningDeviceListTableView.separatorColor = UIColor.clear
        self.tuningDeviceListTableView.backgroundColor = UIColor.clear
        self.tuningDeviceListTableView.rowHeight = UITableView.automaticDimension
        self.tuningDeviceListTableView.estimatedRowHeight = UITableView.automaticDimension

        self.tuningSummaryTableView.tableFooterView = UIView()
        self.tuningSummaryTableView.separatorColor = UIColor.clear
        self.tuningSummaryTableView.backgroundColor = UIColor.clear
        self.tuningSummaryTableView.rowHeight = UITableView.automaticDimension
        self.tuningSummaryTableView.estimatedRowHeight = UITableView.automaticDimension

        self.tuningTimelineTableView.tableFooterView = UIView()
        self.tuningTimelineTableView.separatorColor = UIColor.clear
        self.tuningTimelineTableView.backgroundColor = UIColor.clear
        self.tuningTimelineTableView.rowHeight = UITableView.automaticDimension
        self.tuningTimelineTableView.estimatedRowHeight = UITableView.automaticDimension

        self.serviceTimelineTableView.tableFooterView = UIView()
        self.serviceTimelineTableView.separatorColor = UIColor.clear
        self.serviceTimelineTableView.backgroundColor = UIColor.clear
        self.serviceTimelineTableView.rowHeight = UITableView.automaticDimension
        self.serviceTimelineTableView.estimatedRowHeight = UITableView.automaticDimension

        self.serviceDeviceListTableView.tableFooterView = UIView()
        self.serviceDeviceListTableView.separatorColor = UIColor.clear
        self.serviceDeviceListTableView.backgroundColor = UIColor.clear
        self.serviceDeviceListTableView.rowHeight = UITableView.automaticDimension
        self.serviceDeviceListTableView.estimatedRowHeight = UITableView.automaticDimension

        self.serviceDeviceQuoteTableView.tableFooterView = UIView()
        self.serviceDeviceQuoteTableView.separatorColor = UIColor.clear
        self.serviceDeviceQuoteTableView.backgroundColor = UIColor.clear
        self.serviceDeviceQuoteTableView.rowHeight = UITableView.automaticDimension
        self.serviceDeviceQuoteTableView.estimatedRowHeight = UITableView.automaticDimension

        self.serviceReturnTimelineTableView.tableFooterView = UIView()
        self.serviceReturnTimelineTableView.separatorColor = UIColor.clear
        self.serviceReturnTimelineTableView.backgroundColor = UIColor.clear
        self.serviceReturnTimelineTableView.rowHeight = UITableView.automaticDimension
        self.serviceReturnTimelineTableView.estimatedRowHeight = UITableView.automaticDimension

        self.serviceReturnDeviceListTableView.tableFooterView = UIView()
        self.serviceReturnDeviceListTableView.separatorColor = UIColor.clear
        self.serviceReturnDeviceListTableView.backgroundColor = UIColor.clear
        self.serviceReturnDeviceListTableView.rowHeight = UITableView.automaticDimension
        self.serviceReturnDeviceListTableView.estimatedRowHeight = UITableView.automaticDimension

        self.serviceReturnDeviceQuoteTableView.tableFooterView = UIView()
        self.serviceReturnDeviceQuoteTableView.separatorColor = UIColor.clear
        self.serviceReturnDeviceQuoteTableView.backgroundColor = UIColor.clear
        self.serviceReturnDeviceQuoteTableView.rowHeight = UITableView.automaticDimension
        self.serviceReturnDeviceQuoteTableView.estimatedRowHeight = UITableView.automaticDimension

        self.onlineConsultationConcersTableView.tableFooterView = UIView()
        self.onlineConsultationConcersTableView.separatorColor = UIColor.clear
        self.onlineConsultationConcersTableView.backgroundColor = UIColor.clear
        self.onlineConsultationConcersTableView.rowHeight = UITableView.automaticDimension
        self.onlineConsultationConcersTableView.estimatedRowHeight = UITableView.automaticDimension

        self.onlineConsultationTimelineTableView.tableFooterView = UIView()
        self.onlineConsultationTimelineTableView.separatorColor = UIColor.clear
        self.onlineConsultationTimelineTableView.backgroundColor = UIColor.clear
        self.onlineConsultationTimelineTableView.rowHeight = UITableView.automaticDimension
        self.onlineConsultationTimelineTableView.estimatedRowHeight = UITableView.automaticDimension

        self.audiogramStatus.titleLabel?.textAlignment = .center
        self.trialStatus.titleLabel?.textAlignment = .center
        self.trialPickStatus.titleLabel?.textAlignment = .center
        self.tuningStatus.titleLabel?.textAlignment = .center
        self.serviceStatus.titleLabel?.textAlignment = .center
        self.serviceReturnStatus.titleLabel?.textAlignment = .center
        self.onlineConsultationStatus.titleLabel?.textAlignment = .center

        self.isTermsSelected = false
        self.servicePolicyCheckButton.setImage(UIImage(named: Asset.checksquaregrey), for: .normal)
        self.setUserInteractionPostButton()
        self.serviceRequestDetailViewModel.setintialldata(viewCon: self)

        self.refreshControl.tintColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.refreshControl.attributedTitle = NSAttributedString(string: AppLocalizationString.pulltorefresh)
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.mainScrollView.isScrollEnabled = true
        self.mainScrollView.alwaysBounceVertical = true
        self.mainScrollView.addSubview(self.refreshControl)

        let view0 = self.mainStackView.arrangedSubviews[0] // title
        let view1 = self.mainStackView.arrangedSubviews[1] // address
        let view2 = self.mainStackView.arrangedSubviews[2] // info
        let view3 = self.mainStackView.arrangedSubviews[3] // stafftitle
        let view4 = self.mainStackView.arrangedSubviews[4] // staff
        let view5 = self.mainStackView.arrangedSubviews[5] // servicetitle
        let view6 = self.mainStackView.arrangedSubviews[6] // service
        let view7 = self.mainStackView.arrangedSubviews[7] // payment

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true

        self.commonAPICALL(retryAPIID: 1000)

    }

    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.myBookings
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.bookingDetailsTitleLabel.text = AppLocalizationString.bookingDetails.capitalized
        self.shareOtpLabel.text = AppLocalizationString.sharetheOTPwiththeexecutive
        self.meetingLinkTitleLabel.text = AppLocalizationString.meetingLink.capitalized
        self.joinNowButton.setTitle(AppLocalizationString.joinNow.uppercased(), for: .normal)
        self.cancelButton.setTitle(AppLocalizationString.cancelBooking.capitalized, for: .normal)
        self.needHelpButton.setTitle(AppLocalizationString.needHelp, for: .normal)
        self.bookinginformationTitleLabel.text = AppLocalizationString.bookingInformation.capitalized
        self.bookingIDTitleLabel.text = AppLocalizationString.bookingID
        self.appointmentDateTimeTitleLabel.text = AppLocalizationString.appointmentDateTime.capitalized
        self.bookingDateTitleLabel.text = AppLocalizationString.bookingDate.capitalized
        self.bookingAmountTitleLabel.text = AppLocalizationString.bookingAmount.capitalized
        self.bookingStatusTitleLabel.text = AppLocalizationString.bookingStatus.capitalized
        self.cancellationDateTitleLabel.text = AppLocalizationString.cancellationDate.capitalized
        self.cancellationReasonTitleLabel.text = AppLocalizationString.cancellationReason.capitalized
        self.cancellationCommentTitleLabel.text = AppLocalizationString.cancellationComment.capitalized
        self.refundStatusTitleLabel.text = AppLocalizationString.refundStatus.capitalized
        self.refundAmountTitleLabel.text = AppLocalizationString.refundAmount.capitalized
        self.serviceQuantityTitleLabel.text = AppLocalizationString.serviceRequests.capitalized
        self.patientInformationTitleLabel.text = AppLocalizationString.bookingFor.capitalized
        self.patientNameTitleLabel.text = AppLocalizationString.name.capitalized
        self.patientAgeTitleLabel.text = AppLocalizationString.age.capitalized
        self.patientGenderTitleLabel.text = AppLocalizationString.gender.capitalized
        self.patientRelationshipTitleLabel.text = AppLocalizationString.relationship.capitalized
        self.staffDetailsTitleLabel.text = AppLocalizationString.serviceStaffs.capitalized
        self.executiveTitleLabel.text = AppLocalizationString.hzExecutive.capitalized
        self.executiveVaccinatedLabel.text = AppLocalizationString.vaccinated.capitalized
        self.executiveCallButton.setTitle(AppLocalizationString.call.uppercased(), for: .normal)
        self.executiveTrackButton.setTitle(AppLocalizationString.track.uppercased(), for: .normal)
        self.executiveRateButton.setTitle(AppLocalizationString.rate.uppercased(), for: .normal)
        self.audiologistTitleLabel.text = AppLocalizationString.hzAudiologist.capitalized
        self.audiologistVaccinatedLabel.text = AppLocalizationString.vaccinated.capitalized
        //         self.audiologistCallButton.setTitle(AppLocalizationString.call.uppercased(), for: .normal)
        //         self.audiologistTrackButton.setTitle(AppLocalizationString.track.uppercased(), for: .normal)
        self.audiologistRateButton.setTitle(AppLocalizationString.rateAudiologist.uppercased(), for: .normal)
        self.serviceRequestTitleLabel.text = AppLocalizationString.serviceRequests.capitalized

        self.onlineConsultationTimelineLabel.text = AppLocalizationString.serviceTimelines

        self.tuningTimelineLabel.text = AppLocalizationString.serviceTimelines
        self.audiogramTimelineLabel.text = AppLocalizationString.serviceTimelines

        self.downloadReportButton.setTitle(AppLocalizationString.downloadReport, for: .normal)

        self.trialLeftDeviceTitleLabel.text = AppLocalizationString.trialLeftDevice
        self.trialRightDeviceTitleLabel.text = AppLocalizationString.trialRightDevice
        self.trialEndDateTitleLabel.text = AppLocalizationString.trialPeriod
        self.trialSecurityDepositTitleLabel.text = AppLocalizationString.securitydepositAmount
        self.trialTimelineLabel.text = AppLocalizationString.serviceTimelines
        self.trialContactButton.setTitle(AppLocalizationString.contactUs.uppercased(), for: .normal)

        self.trialPickLeftDeviceTitleLabel.text = AppLocalizationString.trialLeftDevice
        self.trialPickRightDeviceTitleLabel.text = AppLocalizationString.trialRightDevice
        self.trialPickEndDateTitleLabel.text = AppLocalizationString.trialPeriod
        self.trialPickSecurityDepositTitleLabel.text = AppLocalizationString.securitydepositAmount
        self.trialPickTimelineLabel.text = AppLocalizationString.serviceTimelines
        self.trialPickContactButton.setTitle(AppLocalizationString.contactUs.uppercased(), for: .normal)

        self.intialQuoteTitleLabel.text = AppLocalizationString.initialQuote
        self.revisedQuoteTitleLabel.text = AppLocalizationString.revisedQuote
        self.remarkTitleLabel.text = AppLocalizationString.remarks
        self.serviceChargeTitleLabel.text = AppLocalizationString.serviceCharge

        self.serviceContactButton.setTitle(AppLocalizationString.contactUs.uppercased(), for: .normal)
        self.approveButton.setTitle(AppLocalizationString.approve.uppercased(), for: .normal)

        self.serviceTimelineLabel.text = AppLocalizationString.serviceTimelines
        self.intialQuoteReturnTitleLabel.text = AppLocalizationString.initialQuote
        self.revisedQuoteReturnTitleLabel.text = AppLocalizationString.revisedQuote
        self.remarkReturnTitleLabel.text = AppLocalizationString.remarks
        self.serviceReturnTimelineLabel.text = AppLocalizationString.serviceTimelines
        self.serviceChargeReturnTitleLabel.text = AppLocalizationString.serviceCharge

        let strText1 = AppLocalizationString.iagreeingtothe
        let strText2 = AppLocalizationString.termsamberConditions
        let regularFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let regularUndelineFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_112F70, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.colorLiteral.theme_blue_112F70] as [NSAttributedString.Key: Any]

        let part1 = NSMutableAttributedString(string: String(format: "%@ ", strText1), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let part2 = NSMutableAttributedString(string: String(format: "%@", strText2), attributes: regularUndelineFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(part1)
        combination.append(part2)
        self.servicePolicyLabel.attributedText = combination
        self.servicePolicyLabel.isUserInteractionEnabled = true
        self.servicePolicyLabel.lineBreakMode = .byWordWrapping
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.servicePolicyLabel.addGestureRecognizer(tapgesture)

        self.onlineConsultationConcersLabel.text = AppLocalizationString.customerInfoConcerns
        self.onlineConsultationInfoLabel.text = AppLocalizationString.onlineMeetingInfo

    }

    // MARK: - Reload
    func reloadServiceQuantityTableView() {
        self.serviceQuantityTableView.delegate = self
        self.serviceQuantityTableView.dataSource = self
        self.serviceQuantityTableView.reloadData()
    }
    func reloadAudiogramTimelineTableView() {
        self.audiogramTimelineTableView.delegate = self
        self.audiogramTimelineTableView.dataSource = self
        self.audiogramTimelineTableView.reloadData()
    }
    func reloadTrialTimelineTableView() {
        self.trialTimelineTableView.delegate = self
        self.trialTimelineTableView.dataSource = self
        self.trialTimelineTableView.reloadData()
    }
    func reloadTrialPickTimelineTableView() {
        self.trialPickTimelineTableView.delegate = self
        self.trialPickTimelineTableView.dataSource = self
        self.trialPickTimelineTableView.reloadData()
    }
    func reloadTuningDeviceListTableView() {
        self.tuningDeviceListTableView.delegate = self
        self.tuningDeviceListTableView.dataSource = self
        self.tuningDeviceListTableView.reloadData()
    }
    func reloadTuningSummaryTableView() {
        self.tuningSummaryTableView.delegate = self
        self.tuningSummaryTableView.dataSource = self
        self.tuningSummaryTableView.reloadData()
    }
    func reloadtuningTimelineTableView() {
        self.tuningTimelineTableView.delegate = self
        self.tuningTimelineTableView.dataSource = self
        self.tuningTimelineTableView.reloadData()
    }
    func reloadServiceDeviceQuoteTableView() {
        self.serviceDeviceQuoteTableView.delegate = self
        self.serviceDeviceQuoteTableView.dataSource = self
        self.serviceDeviceQuoteTableView.reloadData()
    }
    func reloadServiceTimelineTableView() {
        self.serviceTimelineTableView.delegate = self
        self.serviceTimelineTableView.dataSource = self
        self.serviceTimelineTableView.reloadData()
    }
    func reloadServiceDeviceListTableView() {
        self.serviceDeviceListTableView.delegate = self
        self.serviceDeviceListTableView.dataSource = self
        self.serviceDeviceListTableView.reloadData()
    }
    func reloadServiceReturnDeviceQuoteTableView() {
        self.serviceReturnDeviceQuoteTableView.delegate = self
        self.serviceReturnDeviceQuoteTableView.dataSource = self
        self.serviceReturnDeviceQuoteTableView.reloadData()
    }
    func reloadServiceReturnTimelineTableView() {
        self.serviceReturnTimelineTableView.delegate = self
        self.serviceReturnTimelineTableView.dataSource = self
        self.serviceReturnTimelineTableView.reloadData()
    }
    func reloadServiceReturnDeviceListTableView() {
        self.serviceReturnDeviceListTableView.delegate = self
        self.serviceReturnDeviceListTableView.dataSource = self
        self.serviceReturnDeviceListTableView.reloadData()
    }
    func reloadOnlineConsultationConcersTableView() {
        self.onlineConsultationConcersTableView.delegate = self
        self.onlineConsultationConcersTableView.dataSource = self
        self.onlineConsultationConcersTableView.reloadData()
    }
    func reloadOnlineConsultationTimelineTableView() {
        self.onlineConsultationTimelineTableView.delegate = self
        self.onlineConsultationTimelineTableView.dataSource = self
        self.onlineConsultationTimelineTableView.reloadData()
    }
    func reloadExecutiveTagCollectionView() {
        DispatchQueue.main.async {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.scrollDirection = .horizontal
            self.executiveTagCollectionView.delegate = self
            self.executiveTagCollectionView.dataSource = self
            self.executiveTagCollectionView.collectionViewLayout = layout
            self.executiveTagCollectionView.reloadData()
            self.executiveTagCollectionView.collectionViewLayout.invalidateLayout()
            self.executiveTagCollectionView!.layoutSubviews()
            self.executiveTagCollectionViewHeight.constant = tagHeight
            self.viewWillLayoutSubviews()
        }
    }
    func reloadAudiologistTagCollectionView() {
        DispatchQueue.main.async {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.scrollDirection = .horizontal
            self.audiologistTagCollectionView.delegate = self
            self.audiologistTagCollectionView.dataSource = self
            self.audiologistTagCollectionView.collectionViewLayout = layout
            self.audiologistTagCollectionView.reloadData()
            self.audiologistTagCollectionView.collectionViewLayout.invalidateLayout()
            self.audiologistTagCollectionView!.layoutSubviews()
            self.audiologistTagCollectionViewHeight.constant = tagHeight
            self.viewWillLayoutSubviews()
        }
    }
    func reloadServicePhotoCollectionView() {
        self.servicePhotoCollectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32 - ((6 * 2) /*Spacing*/+ 32/*right and left*/)) / 3
        self.servicePhotoCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32 - ((6 * 2) /*Spacing*/+ 32/*right and left*/)) / 3

        self.servicePhotoCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.servicePhotoCollectionViewlayout.itemSize = CGSize(width: self.servicePhotoCollectionViewItemWidth, height: self.servicePhotoCollectionViewItemHeight)
        self.servicePhotoCollectionViewlayout.minimumLineSpacing = self.servicePhotoCollectionViewItemSpacing
        self.servicePhotoCollectionViewlayout.minimumInteritemSpacing = self.servicePhotoCollectionViewItemSpacing
        self.servicePhotoCollectionViewlayout.scrollDirection = .vertical
        self.servicePhotoCollectionView!.collectionViewLayout = self.servicePhotoCollectionViewlayout
        self.servicePhotoCollectionView.dataSource = self
        self.servicePhotoCollectionView.delegate = self
        self.servicePhotoCollectionView.reloadData()

        if self.hearingAidServicePhotoList.count > 0 {
            if self.hearingAidServicePhotoList.count % 3 == 0 {
                if self.hearingAidServicePhotoList.count > 6 {
                    self.servicePhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServicePhotoList.count / 3) * servicePhotoCollectionViewItemHeight) + (CGFloat((self.hearingAidServicePhotoList.count / 3) - 1) * CGFloat(6))

                } else {
                    self.servicePhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServicePhotoList.count / 3) * servicePhotoCollectionViewItemHeight) + CGFloat(6)
                }
            } else {
                if self.hearingAidServicePhotoList.count > 3 {
                    self.servicePhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServicePhotoList.count / 3) * servicePhotoCollectionViewItemHeight) + (CGFloat((self.hearingAidServicePhotoList.count / 3) - 1) * CGFloat(6)) + servicePhotoCollectionViewItemHeight + CGFloat(6)
                } else {
                    self.servicePhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServicePhotoList.count / 3) * servicePhotoCollectionViewItemHeight) + servicePhotoCollectionViewItemHeight + CGFloat(6)
                }
            }
        } else {
            self.servicePhotoCollectionViewHeight.constant = 0
        }
        self.view.layoutIfNeeded()
    }

    func reloadServiceReturnPhotoCollectionView() {
        self.serviceReturnPhotoCollectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32 - ((6 * 2) /*Spacing*/+ 32/*right and left*/)) / 3
        self.serviceReturnPhotoCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32 - ((6 * 2) /*Spacing*/+ 32/*right and left*/)) / 3

        self.serviceReturnPhotoCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.serviceReturnPhotoCollectionViewlayout.itemSize = CGSize(width: self.serviceReturnPhotoCollectionViewItemWidth, height: self.serviceReturnPhotoCollectionViewItemHeight)
        self.serviceReturnPhotoCollectionViewlayout.minimumLineSpacing = self.serviceReturnPhotoCollectionViewItemSpacing
        self.serviceReturnPhotoCollectionViewlayout.minimumInteritemSpacing = self.serviceReturnPhotoCollectionViewItemSpacing
        self.serviceReturnPhotoCollectionViewlayout.scrollDirection = .vertical
        self.serviceReturnPhotoCollectionView!.collectionViewLayout = self.serviceReturnPhotoCollectionViewlayout
        self.serviceReturnPhotoCollectionView.dataSource = self
        self.serviceReturnPhotoCollectionView.delegate = self
        self.serviceReturnPhotoCollectionView.reloadData()

        if self.hearingAidServiceReturnPhotoList.count > 0 {
            if self.hearingAidServiceReturnPhotoList.count % 3 == 0 {
                if self.hearingAidServiceReturnPhotoList.count > 6 {
                    self.serviceReturnPhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServiceReturnPhotoList.count / 3) * serviceReturnPhotoCollectionViewItemHeight) + (CGFloat((self.hearingAidServiceReturnPhotoList.count / 3) - 1) * CGFloat(6))
                } else {
                    self.serviceReturnPhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServiceReturnPhotoList.count / 3) * serviceReturnPhotoCollectionViewItemHeight) + CGFloat(6)
                }
            } else {
                if self.hearingAidServiceReturnPhotoList.count > 3 {
                    self.serviceReturnPhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServiceReturnPhotoList.count / 3) * serviceReturnPhotoCollectionViewItemHeight) + (CGFloat((self.hearingAidServiceReturnPhotoList.count / 3) - 1) * CGFloat(6)) + serviceReturnPhotoCollectionViewItemHeight + CGFloat(6)
                } else {
                    self.serviceReturnPhotoCollectionViewHeight.constant = (CGFloat(self.hearingAidServiceReturnPhotoList.count / 3) * serviceReturnPhotoCollectionViewItemHeight) + serviceReturnPhotoCollectionViewItemHeight + CGFloat(6)
                }
            }
        } else {
            self.serviceReturnPhotoCollectionViewHeight.constant = 0
        }
        self.view.layoutIfNeeded()
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 || retryAPIID == 2001 {
                    self.getServiceRequestDetail(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getHAServiceRequestApprove(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getServiceRequestDetail(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func getServiceRequestDetail(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getServiceRequestDetail)\(bookingUid)/"
        self.serviceRequestDetailViewModel.getServiceRequestDetail(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getHAServiceRequestApprove(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getHAServiceRequestApprove)\(bookingUid)/\(serviceuid)/"
        self.serviceRequestDetailViewModel.getHAServiceRequestApprove(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction

    @IBAction func ocjoinNowButtonPressed(_ sender: UIButton) {
        if !(self.ocmeetingLink.isEmpty) {
            guard let appURL = URL(string: self.ocmeetingLink.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func linkButtonPressed(_ sender: UIButton) {
        if !(self.ocmeetingLink.isEmpty) {
            guard let appURL = URL(string: self.ocmeetingLink.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func joinNowButtonPressed(_ sender: UIButton) {
        if !(self.trackLink.isEmpty) {
            guard let appURL = URL(string: self.trackLink.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigateToCancelServiceRequestViewController(cancelReasonList: self.cancelReasonList, bookingUid: self.bookingUid)
    }
    @IBAction func needHelpButtonPressed(_ sender: UIButton) {
        self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportSRD.rawValue)
    }
    @IBAction func executiveCallButtonPressed(_ sender: UIButton) {
        // callnumber
        if !(callNumber.isEmpty) {
            let phoneNumberString = callNumber.removeEnclosedWhiteSpace()
            guard let number = URL(string: "tel://\(phoneNumberString)") else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(number)
            }
        }
    }
    @IBAction func executiveTrackButtonPressed(_ sender: UIButton) {
        if !(self.trackLink.isEmpty) {
            guard let appURL = URL(string: self.trackLink.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func executiveRateButtonPressed(_ sender: UIButton) {
        self.navigateToServiceRequestStaffRatingViewController(bookingUid: self.bookingUid, staffExperience: self.staffexperience, staffName: self.staffname, staffSpecialization: self.staffspecialisation, imageurl: self.staffimage, isStaff: true, staffid: staffid)
    }
    @IBAction func audiologistRateButtonPressed(_ sender: UIButton) {
        self.navigateToServiceRequestStaffRatingViewController(bookingUid: self.bookingUid, staffExperience: self.audiologistexperience, staffName: self.audiologistname, staffSpecialization: self.audiologistspecialisation, imageurl: self.audiologistimage, isStaff: false, staffid: audiologistid)
    }
    @IBAction func downloadReportButtonPressed(_ sender: UIButton) {
        if !(self.downloadReportLink.isEmpty) {
            guard let appURL = URL(string: self.downloadReportLink.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func contactButtonPressed(_ sender: UIButton) {
        self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportSRD.rawValue)
    }
    @IBAction func servicePolicyCheckButtonPressed(_ sender: UIButton) {
        self.setservicePolicyCheck()
    }
    @IBAction func approveButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)
    }
    @IBAction func downloadReceiptButtonPressed(_ sender: UIButton) {
        if !(self.paymentReceipt.isEmpty) {
            guard let appURL = URL(string: self.paymentReceipt.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func downloadInvoiceButtonPressed(_ sender: UIButton) {
        if !(self.invoiceDocument.isEmpty) {
            guard let appURL = URL(string: self.invoiceDocument.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }

    // MARK: - Custom Methods
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.servicePolicyLabel.text else { return }
        let termsandConditionsRange = (text as NSString).range(of: AppLocalizationString.termsamberConditions)
        let texttap = (text as NSString).range(of: text)
        //        if gesture.didTapAttributedTextInLabel(label: self.policylabel, inRange: termsandConditionsRange) {
        //            self.navigateToTermsConditionsViewController(isFrom: isFrom)
        //        }
        if gesture.didTapAttributedTextInLabel(label: self.servicePolicyLabel, inRange: termsandConditionsRange) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseSRD.rawValue)
        } else if gesture.didTapAttributedTextInLabel(label: self.servicePolicyLabel, inRange: texttap) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseSRD.rawValue)
        } else {
            
        }

    }
    func setUserInteractionPostButton() {
        DispatchQueue.main.async {
            if self.isTermsSelected == true {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.approveButton.isUserInteractionEnabled = false
        self.approveButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.approveButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.approveButton.setNeedsDisplay()
        self.approveButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.approveButton.isUserInteractionEnabled = true
        self.approveButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.approveButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.approveButton.setNeedsDisplay()
        self.approveButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setservicePolicyCheck() {
        if self.isTermsSelected == true {
            self.isTermsSelected = false
            self.servicePolicyCheckButton.setImage(UIImage(named: Asset.checksquaregrey), for: .normal)
            self.setUserInteractionPostButton()
        } else {
            self.isTermsSelected = true
            self.servicePolicyCheckButton.setImage(UIImage(named: Asset.checksquarelightblue), for: .normal)
            self.setUserInteractionPostButton()
        }
    }
    @objc func refresh(sender: AnyObject) {
        // Code to refresh table view
        self.commonAPICALL(retryAPIID: 2001)
    }
}

extension ServiceRequestDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.srd.rawValue {
            self.navigateBackToViewController()
        } else if isFrom == IsNavigateFrom.srdAlert.rawValue {
            self.navigateBackToMyAlertViewController()
        } else if isFrom == IsNavigateFrom.srdOnlineConsulationSuccess.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.srdBookAppointmentSuccess.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension ServiceRequestDetailViewController: ProtocolNetworkRechabilityDelegate {
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
extension ServiceRequestDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.serviceQuantityTableView && self.serviceRequestsList.count > 0 {
            return self.serviceRequestsList.count
        } else if tableView == self.audiogramTimelineTableView && self.audiogramTimelineList.count > 0 {
            return self.audiogramTimelineList.count
        } else if tableView == self.trialTimelineTableView && self.trialTimelineList.count > 0 {
            return self.trialTimelineList.count
        } else if tableView == self.trialPickTimelineTableView && self.trialPickTimelineList.count > 0 {
            return self.trialPickTimelineList.count
        } else if tableView == self.tuningTimelineTableView && self.tuningTimelineList.count > 0 {
            return self.tuningTimelineList.count
        } else if tableView == self.tuningDeviceListTableView && self.tuningDeviceList.count > 0 {
            return self.tuningDeviceList.count
        } else if tableView == self.tuningSummaryTableView && self.tuningSummaryList.count > 0 {
            return self.tuningSummaryList.count
        } else if tableView == self.serviceDeviceQuoteTableView && self.hearingAidServiceSummaryList.count > 0 {
            return self.hearingAidServiceSummaryList.count
        } else if tableView == self.serviceTimelineTableView && self.hearingAidServiceTimelineList.count > 0 {
            return self.hearingAidServiceTimelineList.count
        } else if tableView == self.serviceDeviceListTableView && self.hearingAidServiceDeviceList.count > 0 {
            return self.hearingAidServiceDeviceList.count
        } else if tableView == self.serviceReturnDeviceQuoteTableView && self.hearingAidServiceReturnSummaryList.count > 0 {
            return self.hearingAidServiceReturnSummaryList.count
        } else if tableView == self.serviceReturnTimelineTableView && self.hearingAidServiceReturnTimelineList.count > 0 {
            return self.hearingAidServiceReturnTimelineList.count
        } else if tableView == self.serviceReturnDeviceListTableView && self.hearingAidServiceReturnDeviceList.count > 0 {
            return self.hearingAidServiceReturnDeviceList.count
        } else if tableView == self.onlineConsultationTimelineTableView && self.onlineConsultationTimelineList.count > 0 {
            return self.onlineConsultationTimelineList.count
        } else if tableView == self.onlineConsultationConcersTableView && self.onlineConsultationConcernsList.count > 0 {
            return self.onlineConsultationConcernsList.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.serviceQuantityTableView && self.serviceRequestsList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRDQuantityTableViewCell, for: indexPath) as! SRDQuantityTableViewCell
            var servicename = ""
            var qty = ""
            if !(self.serviceRequestsList[indexPath.row].name.isNilOrEmpty) {
                servicename = self.serviceRequestsList[indexPath.row].name!.capitalized
            }
            if self.serviceRequestsList[indexPath.row].qty != nil {
                qty = String(format: "%@ %d", AppLocalizationString.qty, self.serviceRequestsList[indexPath.row].qty!)
            }
            cell.quantityTitleLabel.text = servicename
            cell.quantityLabel.text = qty
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.audiogramTimelineTableView && self.audiogramTimelineList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRTrackingTableViewCell, for: indexPath) as! SRTrackingTableViewCell
            cell.configure(serviceTimeline: self.audiogramTimelineList[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.audiogramTimelineList.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.trialTimelineTableView && self.trialTimelineList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRTrackingTableViewCell, for: indexPath) as! SRTrackingTableViewCell
            cell.configure(serviceTimeline: self.trialTimelineList[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.trialTimelineList.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.trialPickTimelineTableView && self.trialPickTimelineList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRTrackingTableViewCell, for: indexPath) as! SRTrackingTableViewCell
            cell.configure(serviceTimeline: self.trialPickTimelineList[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.trialPickTimelineList.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.tuningTimelineTableView && self.tuningTimelineList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRTrackingTableViewCell, for: indexPath) as! SRTrackingTableViewCell
            cell.configure(serviceTimeline: self.tuningTimelineList[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.tuningTimelineList.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.tuningDeviceListTableView && self.tuningDeviceList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRHATuningDeviceTableViewCell, for: indexPath) as! SRHATuningDeviceTableViewCell
            cell.configure(tuningComplaint: self.tuningDeviceList[indexPath.row])
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.tuningSummaryTableView && self.tuningSummaryList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRHATuningSummaryTableViewCell, for: indexPath) as! SRHATuningSummaryTableViewCell
            cell.configure(tuningComplaint: self.tuningSummaryList[indexPath.row])
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.serviceDeviceQuoteTableView && self.hearingAidServiceSummaryList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRHAServiceQuoteTableViewCell, for: indexPath) as! SRHAServiceQuoteTableViewCell
            cell.configure(serviceDevice: self.hearingAidServiceSummaryList[indexPath.row])
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.serviceTimelineTableView && self.hearingAidServiceTimelineList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRTrackingTableViewCell, for: indexPath) as! SRTrackingTableViewCell
            cell.configure(serviceTimeline: self.hearingAidServiceTimelineList[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.hearingAidServiceTimelineList.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.serviceDeviceListTableView && self.hearingAidServiceDeviceList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRHAServiceDeviceTableViewCell, for: indexPath) as! SRHAServiceDeviceTableViewCell
            cell.configure(serviceDevice: self.hearingAidServiceDeviceList[indexPath.row])
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.serviceReturnDeviceQuoteTableView && self.hearingAidServiceReturnSummaryList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRHAServiceQuoteTableViewCell, for: indexPath) as! SRHAServiceQuoteTableViewCell
            cell.configure(serviceDevice: self.hearingAidServiceReturnSummaryList[indexPath.row])
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.serviceReturnTimelineTableView && self.hearingAidServiceReturnTimelineList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRTrackingTableViewCell, for: indexPath) as! SRTrackingTableViewCell
            cell.configure(serviceTimeline: self.hearingAidServiceReturnTimelineList[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.hearingAidServiceReturnTimelineList.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.serviceReturnDeviceListTableView && self.hearingAidServiceReturnDeviceList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRHAServiceDeviceTableViewCell, for: indexPath) as! SRHAServiceDeviceTableViewCell
            cell.configure(serviceDevice: self.hearingAidServiceReturnDeviceList[indexPath.row])
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else if tableView == self.onlineConsultationTimelineTableView && self.onlineConsultationTimelineList.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRTrackingTableViewCell, for: indexPath) as! SRTrackingTableViewCell
            cell.configure(serviceTimeline: self.onlineConsultationTimelineList[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.onlineConsultationTimelineList.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else /*if (tableView == self.onlineConsultationConcersTableView)*/{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SRConcersTableViewCell, for: indexPath) as! SRConcersTableViewCell
            cell.configure(questions: self.onlineConsultationConcernsList[indexPath.row])
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.serviceQuantityTableView && self.serviceRequestsList.count > 0 {
            return self.serviceQuantityTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.audiogramTimelineTableView) && self.audiogramTimelineList.count > 0 {
            return self.audiogramTimelineTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.trialTimelineTableView) && self.trialTimelineList.count > 0 {
            return self.trialTimelineTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.trialPickTimelineTableView) && self.trialPickTimelineList.count > 0 {
            return self.trialPickTimelineTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.tuningTimelineTableView) && self.tuningTimelineList.count > 0 {
            return self.tuningTimelineTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.tuningDeviceListTableView) && self.tuningDeviceList.count > 0 {
            return self.tuningDeviceListTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.tuningSummaryTableView) && self.tuningSummaryList.count > 0 {
            return self.tuningSummaryTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.serviceDeviceQuoteTableView) && self.hearingAidServiceSummaryList.count > 0 {
            return self.serviceDeviceQuoteTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.serviceTimelineTableView) && self.hearingAidServiceTimelineList.count > 0 {
            return self.serviceTimelineTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.serviceDeviceListTableView) && self.hearingAidServiceDeviceList.count > 0 {
            return self.serviceDeviceListTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.serviceReturnDeviceQuoteTableView) && self.hearingAidServiceReturnSummaryList.count > 0 {
            return self.serviceReturnDeviceQuoteTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.serviceReturnTimelineTableView) && self.hearingAidServiceReturnTimelineList.count > 0 {
            return self.serviceReturnTimelineTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.serviceReturnDeviceListTableView) && self.hearingAidServiceReturnDeviceList.count > 0 {
            return self.serviceReturnDeviceListTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.onlineConsultationTimelineTableView) && self.onlineConsultationTimelineList.count > 0 {
            return self.onlineConsultationTimelineTableViewHeight.constant = tableView.contentSize.height
        } else if (tableView == self.onlineConsultationConcersTableView) && self.onlineConsultationConcernsList.count > 0 {
            return self.onlineConsultationConcersTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}

extension ServiceRequestDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.executiveTagCollectionView {
            return self.executiveLangPreferenceArray.count
        } else if collectionView == self.audiologistTagCollectionView {
            return self.audiologistLangPreferenceArray.count
        } else if collectionView == self.servicePhotoCollectionView {
            return self.hearingAidServicePhotoList.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.executiveTagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ExecutiveLangCollectionViewCell, for: indexPath) as! ExecutiveLangCollectionViewCell
            cell.titleLabel.text = self.executiveLangPreferenceArray[indexPath.item]
            return cell
        } else if collectionView == self.audiologistTagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AudiologistLangCollectionViewCell, for: indexPath) as! AudiologistLangCollectionViewCell
            cell.titleLabel.text = self.audiologistLangPreferenceArray[indexPath.item]
            return cell
        } else if collectionView == self.servicePhotoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.SRHAServicePhotoCollectionViewCell, for: indexPath) as! SRHAServicePhotoCollectionViewCell
            var imgurl = ""
            if !(self.hearingAidServicePhotoList[indexPath.item].isEmpty) {
                imgurl = self.hearingAidServicePhotoList[indexPath.item]
            }
            cell.deviceImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.SRHAServicePhotoCollectionViewCell, for: indexPath) as! SRHAServicePhotoCollectionViewCell
            var imgurl = ""
            if !(self.hearingAidServiceReturnPhotoList[indexPath.item].isEmpty) {
                imgurl = self.hearingAidServiceReturnPhotoList[indexPath.item]
            }
            cell.deviceImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.executiveTagCollectionView {
            if self.executiveLangPreferenceArray.count > 0 {
                let tag = self.executiveLangPreferenceArray[indexPath.item]
                let font = AppFont.regular.size(13)
                let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                cellWidth = 12 + size.width + 5 + 16/*imagewidth*/ + 12
                cellHeight = tagHeight
            }
        } else if collectionView == self.audiologistTagCollectionView {
            if self.audiologistLangPreferenceArray.count > 0 {
                let tag = self.audiologistLangPreferenceArray[indexPath.item]
                let font = AppFont.regular.size(13)
                let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                cellWidth = 12 + size.width + 5 + 16/*imagewidth*/ + 12
                cellHeight = tagHeight
            }
        } else if collectionView == self.servicePhotoCollectionView {
            if self.hearingAidServicePhotoList.count > 0 {
                cellWidth = servicePhotoCollectionViewItemWidth
                cellHeight = servicePhotoCollectionViewItemHeight
            }
        } else if collectionView == self.serviceReturnPhotoCollectionView {
            if self.hearingAidServiceReturnPhotoList.count > 0 {
                cellWidth = serviceReturnPhotoCollectionViewItemWidth
                cellHeight = serviceReturnPhotoCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension ServiceRequestDetailViewController: ProtocolServiceRequestStaffRatingViewController, ProtocolCancelServiceRequestViewController {
    func postButtonPressedServiceRequestStaffRatingViewController() {
        self.commonAPICALL(retryAPIID: 2000)
    }
    func postButtonPressedCancelServiceRequestViewController() {
        self.commonAPICALL(retryAPIID: 2000)
    }
}
