//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.

import SwiftUI

struct TodoListView: View {
  @ObservedObject var viewModel: ListViewModel
  private let updata: () -> Void
  
  init(viewModel: ListViewModel, updata: @escaping () -> Void
  ) {
    self.viewModel = viewModel
    self.updata = updata
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(title: viewModel.status, listCount: viewModel.read().count)
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(viewModel.read()) { todo in
            ListCellView(todo: todo, viewModel: viewModel)
              .listRowSeparator(.hidden)
          }
          .onDelete { index in
            viewModel.delete(set: index)
          }
        }
        .padding(.horizontal, -24)
        .listStyle(.inset)
        .onAppear {
          UITableView.appearance().backgroundColor = .clear
        }
      }
    }
  }
}

struct ListCellView: View {
  @State var isLongPressing = false
  @State var isShowEditView = false
  @ObservedObject var viewModel: ListViewModel
  let todo: Todo
  
  init(todo: Todo, viewModel: ListViewModel) {
    self.todo = todo
    self.viewModel = viewModel
  }
  
  var body: some View {
    TodoListCell(todo)
      .onTapGesture(perform: {
        isShowEditView = true
      })
      .onLongPressGesture(perform: {
        isLongPressing = true
      })
      .popover(isPresented: $isLongPressing, content: {
        TodoListPopOver(isShow: $isLongPressing, viewModel: viewModel, todo: todo)
      })
      .sheet(isPresented: $isShowEditView) {
        EditView(
          todo: Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: todo.status),
          isShow: $isShowEditView,
          viewModel: viewModel.editViewModel)
      }
  }
}
