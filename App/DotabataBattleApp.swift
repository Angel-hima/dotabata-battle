import SwiftUI
import WebKit
import UIKit

@main
struct DotabataBattleApp: App {
    var body: some Scene {
        WindowGroup {
            GameContainer()
                .ignoresSafeArea()
                .statusBarHidden(true)
        }
    }
}

struct GameContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(
            frame: .zero,
            configuration: config
        )

        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false

        if let file = Bundle.main.url(
            forResource: "index",
            withExtension: "html"
        ) {
            webView.loadFileURL(
                file,
                allowingReadAccessTo:
                    file.deletingLastPathComponent()
            )
        }

        return webView
    }

    func updateUIView(
        _ uiView: WKWebView,
        context: Context
    ) {}
}
