    //
    //  ViewAllPriceProductModel.swift
    //  HEARZAP
    //
    //  Created by Purushoth on 03/01/23.
    //  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
    //

    import Foundation

    // MARK: - ViewAllPriceProductModel
    struct ViewAllPriceProductModel: Codable {
        var statusCode: Int?
        var message: String?
        var data: ViewAllPriceProductModelDataClass?
        var errors: Errors?
        
        enum CodingKeys: String, CodingKey {
            case statusCode = "status_code"
            case message, data, errors
        }
    }

    // MARK: - DataClass
    struct ViewAllPriceProductModelDataClass: Codable {
        let priceRangeList: [HearingAidPriceRangeList]
        let priceRangeDict: PriceRangeDict?
        let brandList: [HearingAidBrandList]?
        
        enum CodingKeys: String, CodingKey {
            case priceRangeList = "price_range_list"
            case priceRangeDict = "price_range_dict"
            case brandList = "brand_list"
        }
    }

    // MARK: - PriceRangeDict
    struct PriceRangeDict: Codable {
        let priceRangeName, priceRangeDictDescription: String?
        let paginatedData: PaginatedData?
        let products: [ShopProductList]?
        let id: Int?
        let name, slug, image: String?
        let priceStartRange, priceEndRange: Int?
        
        enum CodingKeys: String, CodingKey {
            case priceRangeName = "price_range_name"
            case priceRangeDictDescription = "description"
            case paginatedData = "paginated_data"
            case products, id, name, slug, image
            case priceStartRange = "price_start_range"
            case priceEndRange = "price_end_range"
        }
    }
