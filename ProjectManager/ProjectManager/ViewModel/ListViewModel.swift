//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/15.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
  var todoService: TodoService
  var status: Status
  @Published var todoList: [Todo]
  var changedStatus: (Status, Todo) -> Void
  @Published var isLongPressing = false
  @Published var isShowEditView = false
  
  lazy var editViewModel = EditViewModel(update: { [self] todo in
    todoService.update(todo: todo)
    todoList = todoService.read()
  })
 
  init(todoService: TodoService, status: Status, todoList: [Todo], changedStatus: @escaping (Status, Todo) -> Void) {
    self.todoService = todoService
    self.status = status
    self.todoList = todoList
    self.changedStatus = changedStatus
  }
  
  func read() -> [Todo] {
    return todoService.read(by: status)
  }
  
  func delete(set: IndexSet) {
    let filteredtodoList = self.todoService.read(by: status)
    
    guard let index = set.first else { return }
    
    let id = filteredtodoList[index].id
    
    todoService.delete(id: id)
    
    todoList = todoService.read()
  }
  
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    todoList = todoService.read()
  }
}
