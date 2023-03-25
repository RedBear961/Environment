//
//  DropView.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 11.03.2023.
//

import SwiftUI

public struct DropView: View {

	@State private var isShowAnimation = false
	
	public var body: some View {
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
					.offset(y: isShowAnimation ? -40 : 0)
					.animation(
						.linear(duration: 0.5).repeatForever(),
						value: isShowAnimation
					)
					.onAppear {
						isShowAnimation.toggle()
					}

				Text("Отпустите файл")
					.font(.largeTitle)
			}
		}
    }
}

struct DropView_Previews: PreviewProvider {

    static var previews: some View {
        DropView()
    }
}
