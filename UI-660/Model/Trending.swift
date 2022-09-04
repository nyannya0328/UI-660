//
//  Trending.swift
//  New Complex
//
//  Created by nyannyan0328 on 2022/09/03.
//

import SwiftUI
struct Trending: Identifiable{
    var id: String = UUID().uuidString
    var title: String
    var subTitle: String
    var count: Int
    var image: String
}

var trendingDishes: [Trending] = [
    Trending(title: "American Favourite", subTitle: "Order", count: 120, image: "Pizza1"),
    Trending(title: "Super Supreme", subTitle: "Order", count: 90, image: "Pizza2"),
    Trending(title: "Orange Juice", subTitle: "Order", count: 110, image: "Pizza3"),
    Trending(title: "Chicken Mushroom", subTitle: "Order", count: 70, image: "OrangeJuice"),
]
