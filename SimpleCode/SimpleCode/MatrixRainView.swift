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
    
    let islandWidth: CGFloat = 127
    let islandHeight: CGFloat = 39
    let islandY: CGFloat = -60
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack {
                Ellipse()
                    .fill(Color.red.opacity(0.05))
                    .frame(width: 300, height: 120)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Wake up, Neo...")
                        .font(.custom("Courier", size: 20))
                        .foregroundColor(.green)
                    Text("The Matrix has you...")
                        .font(.custom("Courier", size: 20))
                        .foregroundColor(.green)
                }
            }
            
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
        for _ in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...1.5)) {
                addNewCharacter()
            }
        }
    }
    
    private func updateRain() {
        characters = characters.filter { $0.y < UIScreen.main.bounds.height + 50 }
        
        if characters.count < 300 {
            addNewCharacter()
        }
        
        characters = characters.map { character in
            var newChar = character
            let fallSpeed = CGFloat.random(in: 7...15)
            newChar.y += fallSpeed
            
            let distanceFromIsland = newChar.y - (islandY + islandHeight/2)
            if distanceFromIsland > 0 {
                let screenWidth = UIScreen.main.bounds.width
                
                if let spreadDirection = character.spreadDirection {
                    let spreadSpeed = CGFloat.random(in: 0.5...2.0)
                    newChar.x += spreadDirection * spreadSpeed
                } else {
                    newChar.spreadDirection = [-1.0, 1.0].randomElement()!
                }
                
                newChar.x = min(max(0, newChar.x), screenWidth)
            }
            
            return newChar
        }
    }
    
    private func addNewCharacter() {
        let islandLeftEdge = (UIScreen.main.bounds.width - islandWidth) / 2
        let islandRightEdge = islandLeftEdge + islandWidth
        let startX = CGFloat.random(in: islandLeftEdge...islandRightEdge)
        
        let newChar = RainCharacter(
            value: String(randomMatrixCharacter()),
            x: startX,
            y: islandY + islandHeight/2,
            opacity: Double.random(in: 0.5...1),
            duration: Double.random(in: 0.5...1.5),
            spreadDirection: nil
        )
        characters.append(newChar)
    }
    
    private func randomMatrixCharacter() -> Character {
        let characters = "αβγδεζηθικλμνξοπρστυφχψωℵ∀∃∄∅∈∉∋∌∏∑∕∗∘∙√∝∞∟∠∡∢∴∵∶∷∼∽∾∿≀≁≪≫⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟⊠⊡⊢⊣⊤⊥⊦⊧⊨⊩⊪⊫⊬⊭⊮⊯⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊺⊻⊼⊽⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿"
        let index = Int.random(in: 0..<characters.count)
        return Array(characters)[index]
    }
}

struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixRainView()
    }
}

// MARL: - RainCharacter
struct RainCharacter: Identifiable {
    let id = UUID()
    let value: String
    var x: CGFloat
    var y: CGFloat
    let opacity: Double
    let duration: Double
    var spreadDirection: CGFloat?
}
