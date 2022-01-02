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
    var photoTapped: (() -> Void)?
    var closePhotoButtonTapped: (() -> Void)?
    
    private lazy var photoData = UIImage(named: "haskey_avatar")
    private lazy var photoProfile: UIImageView = {
        var iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = photoData
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3
        iv.layer.cornerRadius = photoProfile.frame.height / 2
        
        return iv
    }()
    private lazy var nameProfile: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .left
        label.text = "Dmitry \"Haskey\""
        label.textColor = .black
        
        return label
    }()
    private lazy var statusBarProfile: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14,weight: .regular)
        label.textAlignment = .left
        label.text = "Add your profile status..."
        label.textColor = .darkGray
        
        return label
    }()
    private lazy var buttonStatusProfile: UIButton = {
        var button = UIButton()
        button.setTitle("Set my status 👀", for: button.state)
        button.titleLabel!.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "color_set")
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
                
        return button
    }()
    private lazy var textFieldProfile: UITextField = {
        var tf = UITextField()
        tf.delegate = self
        tf.clearsOnBeginEditing = true
        tf.leftView = UIView(frame: CGRect(
                                            x: 0,
                                            y: 0,
                                            width: 10,
                                            height: tf.frame.height))
        tf.leftViewMode = .always
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 15,weight: .regular)
        tf.placeholder = "Type status here..."
        tf.textColor = .black
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 3
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)

        return tf
    }()
    private lazy var statusText = String()
    private lazy var closeButton: UIButton = {
        var button = UIButton()
        button.sizeToFit()
        button.setImage(UIImage(systemName: "multiply"), for: button.state)
        button.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 0.9985017123).withAlphaComponent(0)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    private lazy var backgroundForOpenedPhoto: UIView = {
        var view = UIView()
        view.frame = UIScreen.main.bounds
        
        var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        
        return view
    }()
    private lazy var photo = UIImageView(image: photoProfile.image)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScreen()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}

@available(iOS 13.0, *)
extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

@available(iOS 13.0, *)
extension ProfileHeaderView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}

@available(iOS 13.0, *)
extension ProfileHeaderView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        photoProfile.layer.cornerRadius = photoProfile.frame.height / 2
    }
    
    func setupLayout() {
        addSubview(nameProfile)
        addSubview(statusBarProfile)
        addSubview(buttonStatusProfile)
        addSubview(textFieldProfile)
        addSubview(photoProfile)
        
        photoProfile.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalTo(snp.top).offset(16)
            make.leading.equalTo(snp.leading).offset(16)
        }
        
        nameProfile.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(16)
            make.leading.equalTo(photoProfile.snp.trailing).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
        
        statusBarProfile.snp.makeConstraints { make in
            make.top.equalTo(nameProfile.snp.bottom).offset(8)
            make.leading.equalTo(photoProfile.snp.trailing).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
        
        textFieldProfile.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalTo(photoProfile.snp.trailing).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
            make.bottom.equalTo(photoProfile.snp.bottom)
        }
        
        buttonStatusProfile.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(photoProfile.snp.bottom).offset(16)
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).offset(-16)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
    }
}

@available(iOS 13.0, *)
extension ProfileHeaderView {
    @objc private func buttonPressed(_ textField: UITextField) {
        statusBarProfile.text = statusText
        
        textField.resignFirstResponder()
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        statusText = text
    }
    
    @objc private func closedFullScreenPhoto() {
        UIView.animate(withDuration: 0.5,
                       animations: { [self] in
                        backgroundForOpenedPhoto.alpha = 0.0
                        closeButton.alpha = 0.0
                        photo.alpha = 0.0
                        
                        photo.transform = CGAffineTransform(scaleX: 0, y: 0)
                        
                                    
                       }) { [self] _ in
                        backgroundForOpenedPhoto.removeFromSuperview()
                        closeButton.removeFromSuperview()
                        photo.removeFromSuperview()
                    }
        
        closePhotoButtonTapped?()
    }
    
    @objc private func photoSizeChanged(_ sender: UITapGestureRecognizer) {
        photoTapped?()
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                addSubview(backgroundForOpenedPhoto)
                backgroundForOpenedPhoto.addSubview(photo)
                backgroundForOpenedPhoto.addSubview(closeButton)
                
                backgroundForOpenedPhoto.alpha = 1
                closeButton.alpha = 1
                photo.alpha = 1
                
                closeButton.frame = CGRect(
                    x: backgroundForOpenedPhoto.bounds.maxX - 32,
                    y: backgroundForOpenedPhoto.bounds.minY + 16,
                    width: closeButton.frame.width,
                    height: closeButton.frame.height)
                
                photo.center = backgroundForOpenedPhoto.center
                photo.transform = CGAffineTransform(scaleX: 2, y: 2)
                photo.contentMode = .scaleAspectFit
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

@available(iOS 13.0, *)
extension ProfileHeaderView {
    func setupActions() {
        let closePhotoTGR  = UITapGestureRecognizer(target: self,
                                                    action: #selector(closedFullScreenPhoto))
        closePhotoTGR .delegate = self
        closeButton.addGestureRecognizer(closePhotoTGR )
        
        let openFullScreenPhotoTGR = UITapGestureRecognizer(target: self,
                                                            action: #selector(photoSizeChanged))
        openFullScreenPhotoTGR.delegate = self
        openFullScreenPhotoTGR.numberOfTapsRequired = 1
        photoProfile.addGestureRecognizer(openFullScreenPhotoTGR)
    }
}
