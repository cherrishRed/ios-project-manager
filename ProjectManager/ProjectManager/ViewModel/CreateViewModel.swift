//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation
import SwiftUI

class CreateViewModel: ObservableObject {
  var create: (Todo) -> Void
  var cancel: () -> Void
  init(create: @escaping (Todo) -> Void, cancel: @escaping () -> Void) {
    self.create = create
    self.cancel = cancel
    
  }
}
