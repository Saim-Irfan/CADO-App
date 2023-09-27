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
                "image_url": "https://media.istockphoto.com/id/1049163672/photo/world-environment-day-concept.webp?b=1&s=170667a&w=0&k=20&c=-koI3b_iJv_xqWU8DCsWdZrR5mj-i4EjhGxarwDUydc="
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
                "product_id_list": [1, 2, 1, 2]
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
                "image_url": "https://media.istockphoto.com/id/1049163672/photo/world-environment-day-concept.webp?b=1&s=170667a&w=0&k=20&c=-koI3b_iJv_xqWU8DCsWdZrR5mj-i4EjhGxarwDUydc="
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
                "image_url": "https://media.istockphoto.com/id/1049163672/photo/world-environment-day-concept.webp?b=1&s=170667a&w=0&k=20&c=-koI3b_iJv_xqWU8DCsWdZrR5mj-i4EjhGxarwDUydc="
              },
              {
                "id": 9,
                "title": "Mother",
                "image_url": "https://media.istockphoto.com/id/1049163672/photo/world-environment-day-concept.webp?b=1&s=170667a&w=0&k=20&c=-koI3b_iJv_xqWU8DCsWdZrR5mj-i4EjhGxarwDUydc="
              },
              {
                "id": 10,
                "title": "Daughter",
                "image_url": "https://media.istockphoto.com/id/1049163672/photo/world-environment-day-concept.webp?b=1&s=170667a&w=0&k=20&c=-koI3b_iJv_xqWU8DCsWdZrR5mj-i4EjhGxarwDUydc="
              }
            ]
          }
        ]
"""
    }
}
