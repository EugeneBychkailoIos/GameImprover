//
//  UserModel.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import Foundation


struct UserModel: Identifiable {
  var id = UUID()
  var userName: String
  var steamId: String
  var phone: String
  var image: String
}
