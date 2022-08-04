//
//  ContentView.swift
//  OuterKeybordWatch
//
//  Created by 株式会社ティーエスアイ on 2022/08/04.
//参考：SwiftUI iOS - how to capture hardware key events
//https://stackoverflow.com/questions/59797650/swiftui-ios-how-to-capture-hardware-key-events
//

import SwiftUI

struct ContentView: View {
    @State var barcode:String=""
    var body: some View {
        Text("ラベルが２つあっても読み込める？")
        Text("Demo Root Controller access")
          .withHostingWindow { window in
              window?.rootViewController = KeyTestController(rootView: ContentView())
          }    }
}

class KeyTestController<Content>: UIHostingController<Content> where Content: View {

    override func becomeFirstResponder() -> Bool {
        true
    }
    
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: "1", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "2", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "3", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "4", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "5", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "6", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "7", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "8", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "9", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "0", modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: "\r" ,modifierFlags: [], action: #selector(test)),
            UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(test))
        ]
    }

    @objc func test(_ sender: UIKeyCommand) {
        var inKey:String=""
        inKey=sender.input ?? ""
        print(">>> test was pressed" + inKey)
        
    }

}
extension View {
    func withHostingWindow(_ callback: @escaping (UIWindow?) -> Void) -> some View {
        self.background(HostingWindowFinder(callback: callback))
    }
}

struct HostingWindowFinder: UIViewRepresentable {
    var callback: (UIWindow?) -> ()

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
