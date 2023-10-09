//
//  JsonData.swift
//  Cado-App
//
//  Created by Saim on 27/09/2023.
//

import Foundation


struct CADOAppData {
    private init() {}
    
    static func getFakeData() -> String {
        """
        [
          {
            "id": 1,
            "type": "big_banner",
            "title": null,
            "items": [
              {
                "id": 1,
                "title": "Shop by Occasion",
                "image_url": "https://static.vecteezy.com/system/resources/previews/017/379/916/large_2x/close-up-red-gift-box-with-bunch-of-rosy-roses-blurred-background-valentine-s-day-wedding-birthday-and-special-occasion-concept-copy-space-for-text-photo.JPG"
              }
            ]
          },
          {
            "id": 2,
            "type": "scrollable",
            "title": "CADO Picks",
            "items": [
              {
                "id": 2,
                "product_id_list": [1, 2, 3]
              }
            ]
          },
          {
            "id": 3,
            "type": "big_banner",
            "title": null,
            "items": [
              {
                "id": 6,
                "title": "Products",
                "image_url": "https://as1.ftcdn.net/v2/jpg/04/25/93/38/1000_F_425933853_8c8fXmDMqhWTJGCdeXvSanRzoNLnPDBO.jpg"
              }
            ]
          },
          {
            "id": 4,
            "type": "big_banner",
            "title": null,
            "items": [
              {
                "id": 7,
                "title": "Add Ons",
                "image_url": "https://media.istockphoto.com/id/1049163672/photo/world-environment-day-concept.webp?b=1&s=170667a&w=0&k=20&c=-koI3b_iJv_xqWU8DCsWdZrR5mj-i4EjhGxarwDUydc="
              }
            ]
          },
          {
            "id": 4,
            "type": "small_banner",
            "title": "Gifts For",
            "items": [
              {
                "id": 8,
                "title": "Father",
                "image_url": "https://thumbs.dreamstime.com/z/asian-family-spending-spring-concept-father-lifting-daughter-blur-tree-background-110306591.jpg"
              },
              {
                "id": 9,
                "title": "Mother",
                "image_url": "https://lakelandmom.com/wp-content/uploads/2017/08/Mother-with-son-e1503377282322.jpg"
              },
              {
                "id": 10,
                "title": "Daughter",
                "image_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT52lnvhOrorDEtE4qfChOd4S37Z8HqOlEnmw&usqp=CAU"
              }
            ]
          }
        ]
"""
    }
}
