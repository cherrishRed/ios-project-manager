//
//  DetailView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct EditView: View {
  @State private var nonEditable: Bool = true
  @State var todo: Todo = Todo(title: "", content: "")
  @ObservedObject var viewModel: EditViewModel
  var isClosed: () -> Void
  
//  init(todo: Todo, viewModel: EditViewModel, isClosed: @escaping () -> Void) {
//    self.viewModel = viewModel
//    self.isClosed = isClosed
//    self.todo = todo
//  }
  
  var body: some View {
    NavigationView {
      DetailView(todo: $todo)
        .disabled(nonEditable)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              if nonEditable == true {
                nonEditable = false
              } else {
                isClosed()
              }
            } label: {
              nonEditable ? Text("Edit") : Text("Calcel")
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewModel.update(todo)
              isClosed()
            }
          }
        }
    }
  }
}
