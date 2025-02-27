//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI
import RealmSwift

struct AppView: View {
  @State private var isShowDetailView = false
  @ObservedObject var viewModel: AppViewModel
  var todoRealm = TodoRealm()
  
  init(viewModel: AppViewModel) {
    let navigationBarApperance = UINavigationBarAppearance()
    navigationBarApperance.backgroundColor = UIColor.systemGray6
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
    
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      HStack(spacing: 10) {
        TodoListView(viewModel: viewModel.listViewModel,
                     todoService: viewModel.todoService,
                     status: .todo,
                     updata: { viewModel.changeStatus(status: $0, todo: $1) }
        )
                    
        TodoListView(viewModel: viewModel.listViewModel,
                     todoService: viewModel.todoService,
                     status: .doing,
                     updata: { viewModel.changeStatus(status: $0, todo: $1) }
        )
                
        TodoListView(viewModel: viewModel.listViewModel,
                     todoService: viewModel.todoService,
                     status: .done,
                     updata: { viewModel.changeStatus(status: $0, todo: $1) }
        )
                  
      }
      
      .background(Color(UIColor.systemGray4))
      .navigationTitle("Project Manager")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button(action: {
          isShowDetailView.toggle()
        }, label: {
          Image(systemName: "plus")
        })
      }
      .sheet(isPresented: $isShowDetailView) {
        CreateView(isShow: $isShowDetailView, viewModel: viewModel.createViewModel)
      }
    }
    .navigationViewStyle(.stack)
    .onAppear {
      
      let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
      print(documentsDirectory)

    }
  }
    
}
