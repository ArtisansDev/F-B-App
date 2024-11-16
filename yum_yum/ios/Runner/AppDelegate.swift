import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
//         if #available(iOS 13.0, *) {
//             if let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager {
//                 let statusBarFrame = statusBarManager.statusBarFrame
//                         let statusBarView = UIView(frame: statusBarFrame)
//                         statusBarView.backgroundColor = hexStringToUIColor(hex: "#503C2D").cgColor // Change to the desired color
//                         UIApplication.shared.windows.first?.addSubview(statusBarView)
//             }
//         } else {
//             if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//                  statusBar.layer.backgroundColor = hexStringToUIColor(hex: "#503C2D").cgColor
//             }
//         }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}