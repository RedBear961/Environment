//
//  AddServiceView.swift
//  Environment
//
//  Created by  User on 09.03.2023.
//

import SwiftUI

struct AddServiceView: View {
    
    @ObservedObject public var addService = AddServiceViewModel()
    
    var dropViewAnimation: Animation {
        Animation.linear(duration: 0.5)
            .repeatForever()
    }
    
    @State var isDropViewAnimation: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                addService.image
                    .resizable()
                    .frame(width: 48, height: 48)
                
                VStack {
                    TextField("Имя", text: $addService.name)
                        .textFieldStyle(.plain)
                        .font(.title2)
                    
                    Divider()
                }
            }.padding()
            
            List {
                RowView(
                    header: "Путь к исполняемому файлу запуска:",
                    placeholder: "Путь",
                    text: $addService.startupURL
                )
                RowView(
                    header: "Аргументы:",
                    placeholder: "Аргументы",
                    text: $addService.startupArgs
                )
                Divider()
                
                RowView(
                    header: "Путь к исполняемому файлу остановки:",
                    placeholder: "Путь",
                    text: $addService.shutdownURL
                )
                RowView(
                    header: "Аргументы:",
                    placeholder: "Аргументы",
                    text: $addService.shutdownArgs
                )
                Divider()
                
                Text("Порт:")
                TextField("Порт", text: $addService.port)
                    .textFieldStyle(.plain)
            }
            .listStyle(.inset)
            
            Spacer()
        }
        .overlay {
            if addService.isShowDropView {
                ZStack {
                    Color.black.opacity(0.6)
                    Rectangle()
                        .stroke(
                            .gray,
                            style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [6, 6])
                        )
                    
                    VStack {
                        Image("drop_down_icon")
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .offset(y: isDropViewAnimation ? -40 : 0)
                            .animation(dropViewAnimation, value: isDropViewAnimation)
                            .onAppear {
                                isDropViewAnimation.toggle()
                            }
                        
                        Text("Отпустите файл")
                            .font(.largeTitle)
                    }
                }
            }
        }
        .onDrop(of: [.image], delegate: addService)
        .toolbar {
            Button("Сохранить") {
                
            }
        }
    }
}

extension AddServiceView {
    
    struct RowView: View {
        
        let header: String
        let placeholder: String
        @Binding var text: String
        
        var body: some View {
            Text(header)
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
        }
    }
}

final class AddServiceViewModel: ObservableObject {
    
    @Published public var name: String = ""
    @Published public var image: Image = Image("template_icon")
    @Published public var startupURL: String = ""
    @Published public var startupArgs: String = ""
    @Published public var shutdownURL: String = ""
    @Published public var shutdownArgs: String = ""
    @Published public var port: String = ""
    
    @Published public var isShowDropView = false
}

extension AddServiceViewModel: DropDelegate {
    
    func performDrop(info: DropInfo) -> Bool {
        isShowDropView = false
        let item = info.itemProviders(for: [.image]).first!
        let id = item.registeredTypeIdentifiers.first!
        item.loadItem(forTypeIdentifier: id) { data, error in
            guard let url = data as? URL,
                  let image = NSImage(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.image = Image(nsImage: image)
            }
        }
        return true
    }
    
    func dropEntered(info: DropInfo) {
        isShowDropView = true
    }
    
    func dropExited(info: DropInfo) {
        isShowDropView = false
    }
}

struct AddServiceView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddServiceView()
            .frame(width: 400, height: 400)
    }
}
