//
//  BlurView.swift
//  AlertToastPreview
//
//  Created by אילי זוברמן on 14/02/2021.
//

import Foundation
import SwiftUI

#if os(macOS)

@available(macOS 11, *)
public struct BlurView: NSViewRepresentable {
    
    public typealias NSViewType = NSVisualEffectView
    
    var material: NSVisualEffectView.Material?
    
    public init(material: NSVisualEffectView.Material? = .hudWindow) {
        self.material = material
    }
    
    public func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.material = material ?? .hudWindow
        effectView.blendingMode = .withinWindow
        effectView.state = NSVisualEffectView.State.active
        return effectView
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material ?? .hudWindow
        nsView.blendingMode = .withinWindow
    }
}

#else

@available(iOS 14, *)
public struct BlurView: UIViewRepresentable {
    
    public typealias UIViewType = UIVisualEffectView
    
    var material: UIBlurEffect.Style?
    
    public init(material: UIBlurEffect.Style? = .systemMaterial) {
        self.material = material
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: material ?? .systemMaterial))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: material ?? .systemMaterial)
    }
}

#endif
