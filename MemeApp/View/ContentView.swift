//
//  ContentView.swift
//  MemeApp
//
//  Created by Hanamanth Nagonde on 18/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State private var rotationAngle: CGFloat = 0.0
    @ObservedObject var viewModel: MemeViewModel = MemeViewModel()
    
    private var letfList: some View {
        ForEach(0..<viewModel.memeData.count / 2, id: \.self) { index in
            VStack(alignment: .center, spacing: 10)  {
                WebImage(url: URL(string: viewModel.memeData[index].url))
                    .resizable()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: (UIScreen.main.bounds.width / 2) - 20, height: CGFloat.random(in: 180...300), alignment: .center)
                Text(viewModel.memeData[index].name)
                    .foregroundStyle(Color.white)
            }
            .padding(.bottom, 15)
        }
    }
    
    private var rightList: some View {
        ForEach(viewModel.memeData.count / 2..<viewModel.memeData.count, id: \.self) { index in
            VStack(alignment: .center, spacing: 10) {
                WebImage(url: URL(string: viewModel.memeData[index].url))
                    .resizable()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: (UIScreen.main.bounds.width / 2) - 20, height: CGFloat.random(in: 180...300), alignment: .center)
                Text(viewModel.memeData[index].name)
                    .foregroundStyle(Color.white)
            }
            .padding(.bottom, 15)
        }
    }
  
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]

    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            ScrollView(.vertical, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    LazyVGrid(columns: homeGridItems) {
                        letfList
                    }
                    LazyVGrid(columns: homeGridItems) {
                        rightList
                    }
                }
            }
            .padding(.horizontal, 10)

        }
        .onAppear {
            viewModel.fetchMeme()
        }
    }
}

#Preview {
    ContentView()
}
