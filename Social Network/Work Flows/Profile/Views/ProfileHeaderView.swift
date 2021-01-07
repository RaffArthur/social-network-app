//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Arthur Raff on 02.10.2020.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
class ProfileHeaderView: UIView {
    
    // MARK: - Properties
    private lazy var photoProfile: UIImageView = {
        var tgr = UITapGestureRecognizer(target: self, action: #selector(photoSizeChanged))
        tgr.delegate = self
        tgr.numberOfTapsRequired = 1
        
        var image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "haskey_avatar")
        image.layer.masksToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        image.addGestureRecognizer(tgr)
        
        return image
    }()
    private lazy var nameProfile: UILabel = {
        var nameProfile = UILabel()
        nameProfile.font = .systemFont(ofSize: 18, weight: .heavy)
        nameProfile.textAlignment = .left
        nameProfile.text = "Dmitry \"Haskey\""
        nameProfile.textColor = .black
        
        return nameProfile
    }()
    private lazy var statusBarProfile: UILabel = {
        var statusBarProfile = UILabel()
        statusBarProfile.font = .systemFont(ofSize: 14,weight: .regular)
        statusBarProfile.textAlignment = .left
        statusBarProfile.text = "Add your profile status..."
        statusBarProfile.textColor = .darkGray
        
        return statusBarProfile
    }()
    private lazy var buttonStatusProfile: UIButton = {
        var buttonStatusProfile = UIButton()
        buttonStatusProfile.setTitle("Set my status 👀", for: buttonStatusProfile.state)
        buttonStatusProfile.titleLabel!.font = .systemFont(ofSize: 18, weight: .bold)
        buttonStatusProfile.backgroundColor = UIColor(named: "color_set")
        buttonStatusProfile.layer.cornerRadius = 12
        buttonStatusProfile.layer.shadowOffset = CGSize(width: 4, height: 4)
        buttonStatusProfile.layer.shadowColor = UIColor.black.cgColor
        buttonStatusProfile.layer.shadowRadius = 4
        buttonStatusProfile.layer.shadowOpacity = 0.2
        buttonStatusProfile.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                
        return buttonStatusProfile
    }()
    private lazy var textFieldProfile: UITextField = {
        var textfieldProfile = UITextField()
        textfieldProfile.clearsOnBeginEditing = true
        textfieldProfile.leftView = UIView(frame: CGRect(
                                            x: 0,
                                            y: 0,
                                            width: 10,
                                            height: textfieldProfile.frame.height))
        textfieldProfile.leftViewMode = .always
        textfieldProfile.backgroundColor = .white
        textfieldProfile.font = .systemFont(ofSize: 15,weight: .regular)
        textfieldProfile.placeholder = "Type status here..."
        textfieldProfile.textColor = .black
        textfieldProfile.layer.cornerRadius = 12
        textfieldProfile.layer.borderWidth = 3
        textfieldProfile.layer.borderColor = UIColor.darkGray.cgColor
        textfieldProfile.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)

        return textfieldProfile
    }()
    private lazy var statusText = String()
    private lazy var closeButton: UIButton = {
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closedFullScreenPhoto))
        var button = UIButton()
        button.sizeToFit()
        button.setImage(UIImage(systemName: "multiply"), for: button.state)
        button.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 0.9985017123).withAlphaComponent(0)
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGestureRecognizer)
        
        return button
    }()
    private lazy var backgroundForOpenedPhoto: UIView = {
        var view = UIView()
        view.frame = UIScreen.main.bounds
        
        var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        return view
    }()
    private lazy var photo = UIImageView(image: photoProfile.image)

    // MARK: - Initis
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Subviews funcs
    func setupLayout() {
        addSubview(nameProfile)
        addSubview(statusBarProfile)
        addSubview(buttonStatusProfile)
        addSubview(textFieldProfile)
        addSubview(photoProfile)
        
        photoProfile.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalTo(self.snp.top).offset(16)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
        
        nameProfile.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(16)
            make.leading.equalTo(photoProfile.snp.trailing).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
        }
        
        statusBarProfile.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameProfile.snp.bottom).offset(8)
            make.leading.equalTo(photoProfile.snp.trailing).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
        }
        
        textFieldProfile.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.leading.equalTo(photoProfile.snp.trailing).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.bottom.equalTo(photoProfile.snp.bottom)
        }
        
        buttonStatusProfile.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.equalTo(photoProfile.snp.bottom).offset(16)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoProfile.layer.cornerRadius = photoProfile.frame.height / 2
    }
    
    // MARK: - @objc Actions
    @objc private func buttonPressed() {
        statusBarProfile.text = statusText
        print("\(String(describing: statusBarProfile.text!))")
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text!
    }
    
    @objc private func closedFullScreenPhoto() {
        UIView.animate(withDuration: 0.5,
                       animations: { [self] in
                        backgroundForOpenedPhoto.alpha = 0.0
                        closeButton.alpha = 0.0
                        photo.alpha = 0.0
            
                       }) { [self] _ in
                        backgroundForOpenedPhoto.removeFromSuperview()
                        closeButton.removeFromSuperview()
                        photo.removeFromSuperview()
                    }
        
    }
    
    @objc private func photoSizeChanged() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                addSubview(backgroundForOpenedPhoto)
                
                backgroundForOpenedPhoto.alpha = 1
                closeButton.alpha = 1
                photo.alpha = 1
                
                closeButton.frame = CGRect(
                    x: backgroundForOpenedPhoto.bounds.maxX - 32,
                    y: backgroundForOpenedPhoto.bounds.minY + 16,
                    width: closeButton.frame.width,
                    height: closeButton.frame.height)
                
                backgroundForOpenedPhoto.addSubview(photo)
                backgroundForOpenedPhoto.addSubview(closeButton)
                
                photo.center = backgroundForOpenedPhoto.center
                photo.transform = CGAffineTransform(scaleX: 2, y: 2)
                photo.contentMode = .scaleAspectFill
                photo.layer.masksToBounds = false
                photo.layer.cornerRadius = 0
                photo.layer.borderWidth = 0
            }
        } completion: { _ in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.5, options: []) { [self] in
                closeButton.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 1).withAlphaComponent(0.6)
            }
        }
    }
}
// MARK: - Extensions
@available(iOS 13.0, *)
extension ProfileHeaderView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
