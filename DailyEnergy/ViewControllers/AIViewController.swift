//
//  AIViewController.swift
//  DailyEnergy
//
//  Created by AI Assistant on 2024/12/21.
//

import UIKit
import SnapKit

class AIViewController: BaseViewController {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let placeholderImageView = UIImageView()
    private let descriptionLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = UIColor.color(.color_5ED4A4)
        
        // RTRootNavigationController会自动管理导航栏，这里设置隐藏
        isNavBarisHidden = true
        
        // 标题
        view.addSubview(titleLabel)
        titleLabel.text = "AI 识图"
        titleLabel.font = UIFont.systemFont(ofSize: 28.fit(), weight: .bold)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        
        // 副标题
        view.addSubview(subtitleLabel)
        subtitleLabel.text = "智能识别食物热量"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16.fit())
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        subtitleLabel.textAlignment = .center
        
        // 占位图标
        view.addSubview(placeholderImageView)
        placeholderImageView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        placeholderImageView.layer.cornerRadius = 50.fit()
        placeholderImageView.contentMode = .center
        
        // 创建相机图标
        let cameraIcon = UIImageView()
        cameraIcon.image = UIImage(systemName: "camera.fill")
        cameraIcon.tintColor = UIColor.white
        cameraIcon.contentMode = .scaleAspectFit
        placeholderImageView.addSubview(cameraIcon)
        
        cameraIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40.fit())
        }
        
        // 描述文字
        view.addSubview(descriptionLabel)
        descriptionLabel.text = "功能开发中，敬请期待..."
        descriptionLabel.font = UIFont.systemFont(ofSize: 14.fit())
        descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80.fit())
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8.fit())
        }
        
        placeholderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50.fit())
            make.width.height.equalTo(100.fit())
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(placeholderImageView.snp.bottom).offset(40.fit())
            make.left.equalToSuperview().offset(40.fit())
            make.right.equalToSuperview().offset(-40.fit())
        }
    }
}