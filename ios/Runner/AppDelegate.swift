import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.window.secureApp()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension UIWindow {
  func secureApp(){
    let field = UITextField()
    field.isSecureTextEntry = true;
    self.addSubView(field)
    self.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.layer.superlayer?.addSublayer(field.layer)
    field.layer.superlayer?.first?.addSublayer(self.layer)
  }
  
}
