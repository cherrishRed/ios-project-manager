//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation
import SwiftUI

class CreateViewModel: ObservableObject {
  var todoService: TodoService
  @Published var todo: Todo
  var isClosed: () -> Void
  
  init(todoService: TodoService,
       todo: Todo = Todo(title: "", content: ""),
       isClosed: @escaping () -> Void
  ) {
    self.todoService = todoService
    self.todo = todo
    self.isClosed = isClosed
  }
  
  func cancelButtonTapped() {
    todo = Todo(title: "", content: "")
    isClosed()
  }
  
  func doneButtonTapped() {
    saveTodo()
    todo = Todo(title: "", content: "")
    isClosed()
  }
  
  private func saveTodo() {
    todoService.creat(todo: todo)
  }
}
