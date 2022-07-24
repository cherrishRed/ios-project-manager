//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI
import RealmSwift

struct AppView: View {
  @ObservedObject private var viewModel: AppViewModel
  
  init(viewModel: AppViewModel) {
    let navigationBarApperance = UINavigationBarAppearance()
    navigationBarApperance.backgroundColor = UIColor.systemGray6
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
    
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(viewModel: viewModel.toodoListViewModel, updata: {
          viewModel.nothing() }
        )
                    
        TodoListView(viewModel: viewModel.doingListViewModel, updata: {
          viewModel.nothing() }
        )
                
        TodoListView(viewModel: viewModel.doneListViewModel, updata: {
          viewModel.nothing() }
        )
        
      }
      .background(Color(UIColor.systemGray4))
      .navigationTitle("Project Manager")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button(action: {
          viewModel.isShowDetailView = true
        }, label: {
          Image(systemName: "plus")
        })
      }
      .sheet(isPresented: $viewModel.isShowDetailView) {
        CreateView(viewModel: viewModel.createViewModel)
      }
    }
    .navigationViewStyle(.stack)
  }
}
