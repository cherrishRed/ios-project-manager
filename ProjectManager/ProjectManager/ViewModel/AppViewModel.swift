//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
  var todoService: TodoService = TodoService()
  @Published var isShowDetailView: Bool = false
  @Published private var todoList: [Todo] = []
  
  lazy var toodoListViewModel = ListViewModel(todoService: todoService, status: .todo, todoList: todoList) { self.changeStatus(status: $0, todo: $1) }
  lazy var doingListViewModel = ListViewModel(todoService: todoService, status: .doing, todoList: todoList) { self.changeStatus(status: $0, todo: $1) }
  lazy var doneListViewModel = ListViewModel(todoService: todoService, status: .done, todoList: todoList) { self.changeStatus(status: $0, todo: $1) }
  
  lazy var createViewModel = CreateViewModel(create: { [self] todo in
  self.todoService.creat(todo: todo)
    todoList = todoService.read()
    self.isShowDetailView = false
  }, cancel: {
    self.isShowDetailView = false
  })
  
  init() {
    todoList = todoService.read()
  }
  
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    todoList = todoService.read()
  }
  
  func nothing() {
    
  }
  
}
