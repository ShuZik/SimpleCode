//
//  MatrixRainView.swift
//  SimpleCode
//
//  Created by ShuZik on 01.11.2024.
//

import SwiftUI

struct MatrixRainView: View {
    @State private var characters: [RainCharacter] = []
    @State private var hueRotation: Double = 0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ForEach(characters) { character in
                Text(character.value)
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundColor(.green.opacity(character.opacity))
                    .position(x: character.x, y: character.y)
                    .animation(.linear(duration: character.duration), value: character.y)
            }
        }
        .onAppear {
            startRain()
        }
        .onReceive(timer) { _ in
            updateRain()
            withAnimation(.linear(duration: 3)) {
                hueRotation = hueRotation + 10
                if hueRotation >= 360 { hueRotation = 0 }
            }
        }
    }
    
    private func startRain() {
        // Создаем начальное распределение символов по всему экрану
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0...50 {
            let newChar = RainCharacter(
                value: String(randomMatrixCharacter()),
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: -50...screenHeight), // Распределяем по всей высоте
                opacity: Double.random(in: 0.5...1),
                duration: Double.random(in: 0.5...1.5)
            )
            characters.append(newChar)
        }
    }
    
    private func updateRain() {
        characters = characters.filter { $0.y < UIScreen.main.bounds.height + 50 }
        if characters.count < 50 {
            addNewCharacter()
        }
        
        characters = characters.map { character in
            var newChar = character
            newChar.y += CGFloat.random(in: 15...25) // Добавляем случайную скорость падения
            return newChar
        }
    }
    
    private func addNewCharacter() {
        let newChar = RainCharacter(
            value: String(randomMatrixCharacter()),
            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
            y: -50,
            opacity: Double.random(in: 0.5...1),
            duration: Double.random(in: 0.5...1.5)
        )
        characters.append(newChar)
    }
    
    private func randomMatrixCharacter() -> Character {
        let characters = "αβγδεζηθικλμνξοπρστυφχψωℵ∀∃∄∅∈∉∋∌∏∑∕∗∘∙√∝∞∟∠∡∢∴∵∶∷∼∽∾∿≀≁≪≫⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟⊠⊡⊢⊣⊤⊥⊦⊧⊨⊩⊪⊫⊬⊭⊮⊯⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊺⊻⊼⊽⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿"
        let index = Int.random(in: 0..<characters.count)
        return Array(characters)[index]
    }
}

struct RainCharacter: Identifiable {
    let id = UUID()
    let value: String
    var x: CGFloat
    var y: CGFloat
    let opacity: Double
    let duration: Double
}

struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixRainView()
    }
}
