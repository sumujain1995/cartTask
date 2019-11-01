//
//  CategoriesModel.swift
//  CartTask
//
//  Created by Sumeet  Jain on 30/10/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

var imgArr = ["https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/98857/biotique-bio-cucumber-pore-tightning-freshner-with-himalayan-waters-for-normal-to-skin-120-ml_1_display_1544606887_35636d5b.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try_On_-_235x235_small_hvtHhUWLB.png,ofo-top_right/static/img/product/141884/ny-bae-lip-crayon-red-playoffs-champion-6_2_display_1522927296_c49604de.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/149403/ny-bae-bb-cream-sophie-s-honey-4_1_display_1534486033_3ae9924c.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try-On---235x235-small__1__pp6Fymsrr.jpg,ofo-top_right/static/img/product/143700/ny-bae-lip-crayon-mets-matte-swing-like-me-8_1_display_1525845477_7670e968.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/8214/biotique-fresh-growth-therapeutic-oil-bio-bhringraj-120-ml_2_display_1537012482_c78c9dab.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/138323/faces-magneteyes-kajal-black-1-0-35-g_3_display_1498718376_3a9db86c.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try-On---235x235-small__1__pp6Fymsrr.jpg,ofo-top_right/static/img/product/137314/good-vibes-brightening-scrub-pomegranate-50-g_5_display_1543497219_0b042810.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/128625/good-vibes-deep-moisturizing-body-lotion-shea-butter_5_display_1543301792_4c620493.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try-On---235x235-small__1__pp6Fymsrr.jpg,ofo-top_right/static/img/product/128623/good-vibes-rejuvenating-face-wash-pomegranate_3_display_1547720788_a2d637cb.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/129438/plum-green-tea-alcohol-free-toner-200-ml_1_display_1445325756_1607d58e.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/142754/ny-bae-matte-nail-lacquer-brown-chocolate-chip-cookie-4_2_display_1523622160_757ebdd3.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/147869/alps-goodness-skin-nourishing-shower-gel-argan-oil-200-ml_4_display_1530873013_9bec1d4a.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/145496/st-d-vence-body-moisturiser-for-normal-skin-with-almond-oil-and-aloe-vera-100-ml_3_display_1527498041_2e9a0560.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/147091/lacto-calamine-oil-balance-lotion-combination-to-normal-skin-30-ml-19_1_display_1548743499_7127e5d9.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try-On---235x235-small__1__pp6Fymsrr.jpg,ofo-top_right/static/img/product/129716/stay-quirky-liquid-lipstick-pink-color-goals-5_1_display_1521524705_4d03118d.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/145514/st-d-vence-tea-tree-body-wash-with-eucalyptus-oil-and-peppermint-oil-100-ml_4_display_1527498170_dfadf270.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try_On_-_235x235_small_hvtHhUWLB.png,ofo-top_right/static/img/product/133780/ny-bae-lipstick-matte-brown-long-island-delight-19_2_display_1521609872_86056117.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/115435/colorbar-mesmereyes-kajal-black-rose-001_2_display_1566808095_0fd9343a.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/98794/biotique-basil-and-parsleya-body-cleansers-150-g-new-2_2_display_1537013763_08774987.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/147821/olay-natural-white-rich-day-cream-with-spf-24-50-g_7_display_1506163176_9f7eb916.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/145985/good-vibes-sunscreen-spf-30_1_display_1528115847_e2d2a10e.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try_On_-_235x235_small_hvtHhUWLB.png,ofo-top_right/static/img/product/151866/kareena-kapoor-khan-lakme-absolute-pout-definer-fearless-red-2-5-g_3_display_1535978889_7258c7ca.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/151872/kareena-kapoor-khan-lakme-absolute-eye-definer-cobalt-1-2-g_1_display_1535979034_9494c288.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/130165/aroma-magic-under-eye-cream-20-g_1_display_1518425419_806e7754.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try_On_-_235x235_small_hvtHhUWLB.png,ofo-top_right/static/img/product/124196/stay-quirky-kajal-black-badass-1-0-25-g_3_display_1501684063_e3c54141.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/144900/livon-silky-potion-100-ml-_1_display_1444891404_14120337.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/13089/vlcc-gold-facial-kit-with-free-gold-bleach_1_display_1549269404_652440a6.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/13092/vlcc-diamond-facial-kit-free-matte-look-sunscreen-lotion-spf-30_2_display_1553258185_177b9880.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/146299/lotus-herbals-whiteglow-skin-whitening-brightening-gel-cream-spf-25-60-g_1_display_1426860713_e8afeb17.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/117918/wow-apple-cider-vinegar-shampoo-300-ml_1_display_1493026100_176f5088.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/90663/colorbar-duo-mascara-carbon-black-4-ml_3_display_1549441512_dfd1749a.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max/static/img/product/153891/stay-quirky-liquid-eyeliner-brown-smokin-like-a-rockstar-4-6-5-ml_1_display_1539582116_bcced355.jpg",
              "https://media6.ppl-media.com/tr:h-550,w-550,c-at_max,oi-Try_On_-_235x235_small_hvtHhUWLB.png,ofo-top_right/static/img/product/116416/sugar-smudge-me-not-liquid-lipstick-01-brazen-raisin-4-5-ml_2_display_1503987062_dd1e984f.jpg"]

struct CategoriesModel: Decodable {
    
    var name: String
    var products: [Products]
    var sortName = -1
    var sortPrice = -1
    
    //-1 -> Nothing
    //0 -> Ascending
    //1 -> Descending
    
    init(name: String, products: [Products]) {
        self.name = name
        self.products = products
    }
    
    enum CodingKeys: String, CodingKey {
        case name, products
    }
    
    mutating func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        
        let product = products[sourceIndex]
        products.remove(at: sourceIndex)
        products.insert(product, at: destinationIndex)
    }
}

struct Products: Decodable {
    var sku: Int
    var cost: Int
    var name: String
    var image: CGImage?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case sku
        case cost
        case name
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.sku = try values.decode(Int.self, forKey: .sku)
        self.cost = try values.decode(Int.self, forKey: .cost)
        self.name = try values.decode(String.self, forKey: .name)
        self.image = nil
        self.imageUrl = imgArr.randomElement()
    }
}

