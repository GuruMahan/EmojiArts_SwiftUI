//
//  EmojiArtsModel.swift
//  EmojiArts
//
//  Created by Guru Mahan on 23/12/22.
//

import Foundation

struct EmojiArtModel {
    var background = Background.blank
    //var backGround = BackGround.self
    var emojis = [Emoji]()
    
    struct Emoji:Identifiable, Hashable {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        let id: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    init() { }
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: uniqueEmojiId))
    }
    enum Background: Equatable {
        case blank
        case url(URL)
        case imageDate(Data)
        
        var url: URL? {
            switch self{
            case .url(let url): return url
            default: return nil
            }
        }
        var imageData: Data?{
            switch self {
            case .imageDate(let data): return data
            default: return nil
            }
        }
    }
}


