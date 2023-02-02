//
//  EmojiAtrsViewModel.swift
//  EmojiArts
//
//  Created by Guru Mahan on 23/12/22.
//

import Foundation
import UIKit


class EmojiAtrsViewModel: ObservableObject{
    
    
    @Published private(set) var emojiArts: EmojiArtModel {
        didSet{
            if emojiArts.background != oldValue.background {
                fetchBackgroundImageDataIfNecessary()
            }
        }
    }
    
    init() {
        emojiArts = EmojiArtModel()
        emojiArts.addEmoji("🎉", at: (100, -100), size: 80)
        emojiArts.addEmoji("😀", at: (50, 100), size: 40)
    }
    
    var emojis: [EmojiArtModel.Emoji] {emojiArts.emojis}
    var background: EmojiArtModel.Background{emojiArts.background}
    @Published var backgroundImage: UIImage?
    @Published var backgroundImageFetchStatus = BackgroundImageFetchStatus.idle
    
    enum BackgroundImageFetchStatus {
        case idle
        case fetching
    }
    //MARK: - Intent(s)
    func fetchBackgroundImageDataIfNecessary() {
        backgroundImage = nil
        switch emojiArts.background {
        case .url(let url):
            //fetch the url
            backgroundImageFetchStatus = .fetching
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = try?Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    if self?.emojiArts.background == EmojiArtModel.Background.url(url){
                        self?.backgroundImageFetchStatus = .idle
                        if imageData != nil {
                            self?.backgroundImage = UIImage(data: imageData!)
                    }
                   
                }
            }
           
            }
        case .imageDate(let data):
            backgroundImage = UIImage(data: data)
            
        case .blank:
            break
        }
    }
    func setBackground(_ background: EmojiArtModel.Background){
        emojiArts.background = background
        
    }
    func addEmoji(_ emoji: String,at location: (x: Int, y: Int),size: CGFloat) {
        emojiArts.addEmoji(emoji, at: location, size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArtModel.Emoji, by offset: CGSize) {
        if let index = emojiArts.emojis.index(matching: emoji){
            emojiArts.emojis[index].x += Int(offset.width)
            emojiArts.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArtModel.Emoji, by scale: CGFloat){
        if let index = emojiArts.emojis.index(matching: emoji){
            emojiArts.emojis[index].size = Int((CGFloat(emojiArts.emojis[index].size) * scale).rounded(.toNearestOrAwayFromZero))
        }
    }
}
