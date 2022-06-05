//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Arthur Raff on 02.10.2020.
//

import UIKit

class ProfileHeaderView: UIView {
    weak var delegate: ProfileHeaderViewDelegate?
        
    private lazy var userPhoto: UIImageView = {
        var iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "haskey_avatar")
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.darkGray.cgColor
        iv.layer.borderWidth = 2
        
        return iv
    }()
    
    private lazy var userName: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .left
        label.text = "Dmitry \"Haskey\""
        label.textColor = .SocialNetworkColor.mainText.set()
        
        return label
    }()
    
    private lazy var userStatus: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .SocialNetworkColor.secondaryText.set()
        label.text = "Статуст отсутствует..."
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var setUserStatusButton: UIButton = {
        var button = UIButton()
        button.setTitle("Настроить статус 👀", for: button.state)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .SocialNetworkColor.accent.set()
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(setUserStatusButtonPressed), for: .touchUpInside)
                
        return button
    }()
        
    private lazy var closeFullUserPhotoButton: UIButton = {
        var button = UIButton()
        button.sizeToFit()
        button.setImage(UIImage(systemName: "multiply"), for: button.state)
        button.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 0.9985017123).withAlphaComponent(0)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    private lazy var fullUserPhotoBackground: UIView = {
        var view = UIView()
        view.frame = UIScreen.main.bounds
        
        var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        
        return view
    }()
    
    private lazy var photo = UIImageView(image: userPhoto.image)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScreen()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        userPhoto.layer.cornerRadius = userPhoto.frame.height / 2
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension ProfileHeaderView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

private extension ProfileHeaderView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        userPhoto.layer.cornerRadius = userPhoto.frame.height / 2
    }
    
    func setupLayout() {
        add(subviews: [userName,
                       userStatus,
                       setUserStatusButton,
                       userPhoto])
        
        userPhoto.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(userPhoto.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userStatus.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(userName.snp.bottom).offset(8)
            make.leading.equalTo(userPhoto.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
                
        setUserStatusButton.snp.makeConstraints { make in
            make.top.equalTo(userStatus.snp.bottom).offset(16)
            make.leading.equalTo(userPhoto.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupActions() {
        let closePhotoTGR = UITapGestureRecognizer(target: self,
                                                   action: #selector(fullUserPhotoClosed))
        closePhotoTGR.delegate = self
        closeFullUserPhotoButton.addGestureRecognizer(closePhotoTGR)
        
        let openFullScreenPhotoTGR = UITapGestureRecognizer(target: self,
                                                            action: #selector(fullUserPhotoOpened))
        openFullScreenPhotoTGR.delegate = self
        userPhoto.addGestureRecognizer(openFullScreenPhotoTGR)
    }
}

private extension ProfileHeaderView {
    @objc private func setUserStatusButtonPressed() {
        delegate?.setUserStatusButtonTapped()
    }
    
    @objc private func fullUserPhotoClosed() {
        delegate?.userPhotoCloseButtonTapped()
    }
    
    @objc private func fullUserPhotoOpened(_ sender: UITapGestureRecognizer) {
        delegate?.userPhotoTapped()
    }
}

extension ProfileHeaderView {
    func updateUserStatus(message: String) {
        userStatus.text = message
    }
    
    func closeFullUserPhoto() {
        UIView.animate(withDuration: 0.5) { [self] in
            fullUserPhotoBackground.alpha = 0.0
            closeFullUserPhotoButton.alpha = 0.0
            photo.alpha = 0.0
            
            photo.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            fullUserPhotoBackground.removeFromSuperview()
            closeFullUserPhotoButton.removeFromSuperview()
            photo.removeFromSuperview()
        }
    }
    
    func openFullUserPhoto() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                addSubview(fullUserPhotoBackground)
                fullUserPhotoBackground.addSubview(photo)
                fullUserPhotoBackground.addSubview(closeFullUserPhotoButton)
                
                fullUserPhotoBackground.alpha = 1
                closeFullUserPhotoButton.alpha = 1
                photo.alpha = 1
                
                closeFullUserPhotoButton.frame = CGRect(
                    x: fullUserPhotoBackground.bounds.maxX - 32,
                    y: fullUserPhotoBackground.bounds.minY + 16,
                    width: closeFullUserPhotoButton.frame.width,
                    height: closeFullUserPhotoButton.frame.height)
                
                photo.center = fullUserPhotoBackground.center
                photo.transform = CGAffineTransform(scaleX: 2, y: 2)
                photo.contentMode = .scaleAspectFit
                photo.layer.masksToBounds = false
                photo.layer.cornerRadius = 0
                photo.layer.borderWidth = 0
            }
        } completion: { _ in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.5, options: []) { [self] in
                closeFullUserPhotoButton.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 1).withAlphaComponent(0.6)
            }
        }
    }
}
