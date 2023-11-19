//
//  MenuViewViewModel.swift
//  RealityFace
//
//  Created by Marko on 18.11.23..
//

import Foundation

class MenuViewViewModel {
    var scenes: [SceneType] = [.box, .glasses, .head]
    
    var images: [SceneType: String] = [
        .box: "box",
        .head: "robotHead",
        .glasses: "glasses"
    ]
}
