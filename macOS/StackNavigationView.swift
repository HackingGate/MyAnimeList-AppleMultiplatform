//
//  StackNavigationView.swift
//  StackNavigationView
//
//  Created by HG on 2021/07/21.
//

import SwiftUI

class Stack: ObservableObject {
    @Published var content: [AnyView] = []
}

struct StackNavigationView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme

    var content: Content

    @StateObject var stack = Stack()

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        if stack.content.count > 0 {
            MotherView().environmentObject(stack)
                .background(colorScheme == .light ? Color.white : Color(red: 45 / 255, green: 45 / 255, blue: 45 / 255))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            // TODO: A better way to initialize @StateObject
            // https://stackoverflow.com/a/63645468/4063462
            content
                .onAppear {
                    stack.content.append(AnyView(content))
                }
        }
    }
}

struct MotherView: View {
    @EnvironmentObject var stack: Stack

    var body: some View {
        VStack {
            stack.content.last
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct StackNavigationLink<Label, Destination>: View where Label: View, Destination: View {
    @EnvironmentObject var stack: Stack

    let destination: () -> Destination
    let label: () -> Label

    init(@ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }

    var body: some View {
        Button {
            stack.content.append(AnyView(destination()))
        } label: {
            label()
        }
    }
}

struct StackNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        StackNavigationView {
            StackNavigationLink {
                StackNavigationLink {
                    Text("success")
                } label: {
                    Text("button2")
                }
            } label: {
                Text("button1")
            }
        }
    }
}
