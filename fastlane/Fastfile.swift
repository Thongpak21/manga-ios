// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    func testFlightLane() {
        match(type: "appstore", appIdentifier: ["com.skydea.mangaReader"], username: "geek@nextzy.com", gitUrl: "https://github.com/Thongpak21/manga-ios-cert.git")
        
        buildApp(workspace: "MangaReader.xcworkspace", scheme: "manga-ios")
        uploadToTestflight(username: "geek@nextzy.com", waitForUploadedBuild: true)
    }
}

//phasprase: manga
