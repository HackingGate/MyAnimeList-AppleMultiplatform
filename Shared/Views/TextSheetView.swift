//
//  TextSheetView.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/18.
//

import SwiftUI

struct TextSheetView: View {
    let title: String
    let synopsis: String

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            #if os(tvOS)
            Text(synopsis)
            #else
            ScrollView(.vertical) {
                Text(synopsis)
                    .padding()
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button("Done") {
                            // TODO: fix no dismiss animation on iOS
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    )
            }
            #endif
        }
    }
}

struct TextSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TextSheetView(title: "Sword Art Online", synopsis: "In the year 2022, virtual reality has progressed by leaps and bounds, and a massive online role-playing game called Sword Art Online (SAO) is launched. With the aid of \"NerveGear\" technology, players can control their avatars within the game using nothing but their own thoughts. Kazuto Kirigaya, nicknamed \"Kirito,\" is among the lucky few enthusiasts who get their hands on the first shipment of the game. He logs in to find himself, with ten-thousand others, in the scenic and elaborate world of Aincrad, one full of fantastic medieval weapons and gruesome monsters. However, in a cruel turn of events, the players soon realize they cannot log out; the game\'s creator has trapped them in his new world until they complete all one hundred levels of the game. In order to escape Aincrad, Kirito will now have to interact and cooperate with his fellow players. Some are allies, while others are foes, like Asuna Yuuki, who commands the leading group attempting to escape from the ruthless game. To make matters worse, Sword Art Online is not all fun and games: if they die in Aincrad, they die in real life. Kirito must adapt to his new reality, fight for his survival, and hopefully break free from his virtual hell. [Written by MAL Rewrite]")
    }
}
