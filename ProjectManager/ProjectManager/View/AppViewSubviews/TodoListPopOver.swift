//
//  TodoListPopOver.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct TodoListPopOver: View {
  let todo: Todo
  @Binding var isShow: Bool
  @ObservedObject var viewModel: ListViewModel
  
  init(isShow: Binding<Bool>, viewModel: ListViewModel, todo: Todo) {
    self._isShow = isShow
    self.viewModel = viewModel
    self.todo = todo
  }
  
  var body: some View {
    VStack {
      switch todo.status {
      case .todo:
        MoveButton(isShow: $isShow, viewModel: viewModel, todo: todo, status: .doing)
        MoveButton(isShow: $isShow, viewModel: viewModel, todo: todo, status: .done)
      case .doing:
        MoveButton(isShow: $isShow, viewModel: viewModel, todo: todo, status: .todo)
        MoveButton(isShow: $isShow, viewModel: viewModel, todo: todo, status: .done)
      case .done:
        MoveButton(isShow: $isShow, viewModel: viewModel, todo: todo, status: .todo)
        MoveButton(isShow: $isShow, viewModel: viewModel, todo: todo, status: .doing)
      }
    }
    .padding()
  }
}

struct MoveButton: View {
  @ObservedObject var viewModel: ListViewModel
  @Binding var isShow: Bool
  let todo: Todo
  let status: Status
  
  init(isShow: Binding<Bool>, viewModel: ListViewModel, todo: Todo, status: Status) {
    self._isShow = isShow
    self.todo = todo
    self.viewModel = viewModel
    self.status = status
  }
  
  var body: some View {
    Button("MOVE to \(status.rawValue)") {
      viewModel.changedStatus(status, todo)
//      viewModel.changeStatus(status: status, todo: todo)
      isShow = false
    }
    .buttonStyle(GrayBasicButtonStyle())
  }
}

struct GrayBasicButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .font(.body)
      .background(Color(UIColor.systemGray2))
      .foregroundColor(.white)
      .clipShape(RoundedRectangle(cornerRadius: 4))
  }
}
