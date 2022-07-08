//
//  TodoListPopOver.swift
//  ProjectManager
//
//  Created by 박세리 on 2022/07/08.
//

import SwiftUI

struct TodoListPopOver: View {
  
  var body: some View {
    VStack {
      Button("MOVE to DOING") {
      }
      .buttonStyle(GrayBasicButtonStyle())
      Button("MOVE to DONE") {
      }
      .buttonStyle(GrayBasicButtonStyle())
    }
    .padding()
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
