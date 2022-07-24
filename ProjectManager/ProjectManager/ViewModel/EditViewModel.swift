//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class EditViewModel: ObservableObject {
  @Published var nonEditable: Bool = true
  var update: (Todo) -> Void
  
  init(update: @escaping (Todo) -> Void) {
    self.update = update
  }
}
