import UIKit

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
