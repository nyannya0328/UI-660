//
//  ResponceView.swift
//  UI-660
//
//  Created by nyannyan0328 on 2022/09/04.
//

import SwiftUI

struct ResponceView<Content : View>: View {
    var content : (Properties) -> Content
    
    init(@ViewBuilder content : @escaping(Properties) -> Content) {
        self.content = content
    }
    var body: some View {
        GeometryReader{proxy in
            
            
            let size = proxy.size
            let isLandScpae = size.width > size.height
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let isMaxSprit = isSprit() && size.width > 400
            
            
            let isAdaptable = isIpad && (isLandScpae ? !isMaxSprit : !isSprit())
            
            let properties = Properties(isLandscape: isLandScpae, isIpad: isIpad, isSprit: isSprit(), isMaxSprit: isMaxSprit, isAdaptable: isAdaptable, size: size)
            
            
            content(properties)
            .frame(width: size.width,height: size.height)
            
            
        }
    }
    func isSprit()->Bool{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{return false}
        
        return screen.windows.first?.frame.size != screen.screen.bounds.size
    }
}


struct Properties{
    
    var isLandscape : Bool
    var isIpad : Bool
    var isSprit : Bool
    var isMaxSprit : Bool
    var isAdaptable : Bool
    var size : CGSize
}
