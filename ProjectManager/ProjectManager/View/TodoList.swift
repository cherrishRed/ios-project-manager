//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoListView: View {
  @ObservedObject var viewModel: TodoViewModel
  @State var isShowDetailView: Bool
  let status: Todo.Status
  
  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(viewModel: viewModel, title: status)
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(viewModel.read(by: status)) { todo in
            DetailViewButton(viewModel: viewModel, todo: todo, isShowDetailView: $isShowDetailView)
              .listRowSeparator(.hidden)
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

struct DetailViewButton: View {
  @ObservedObject var viewModel: TodoViewModel
  @ObservedObject var todo: Todo
  @Binding var isShowDetailView: Bool
  @State var isLongPressing = false
  @State private var isShowingPopover = false
  
  var body: some View {
    Button {
      if isLongPressing {
        isLongPressing = false
      }
    
    } label: {
      TodoListCell(todo)
    }
    .sheet(isPresented: $isShowDetailView) {
      DetailView(viewModel: viewModel, todo: todo, isShow: $isShowDetailView, method: .update)
    }
    .popover(isPresented: $isLongPressing) {
        TodoListPopOver()
    }
    .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded({ _ in
      print("long")
      self.isLongPressing = true
    }))
    .simultaneousGesture(TapGesture().onEnded {
      isShowDetailView = true
      
    })
  }
}
