//
//  CreateView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct CreateView: View {
  @State var todo = Todo(title: "", content: "")
  @ObservedObject var viewModel: CreateViewModel
  
  var body: some View {
    NavigationView {
      DetailView(todo: $todo)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Calcel") {
              viewModel.cancel()
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewModel.create(todo)
            }
          }
        }
    }
  }
}
