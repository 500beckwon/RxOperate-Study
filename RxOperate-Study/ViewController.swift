//
//  ViewController.swift
//  RxOperate-Study
//
//  Created by ByungHoon Ann on 2022/08/28.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

// 자료 출처: https://jusung.github.io/scan/

final class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private let scanCountButton = UIButton()
    private let scanStateButton = UIButton()
    private let scanNumberTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
       
        scanCountButton.rx.tap
            .scan(0) { preValue, _ in
                return preValue + 1
            }.map { "scan count \($0)" }
            .bind(to: scanCountButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        scanStateButton.rx.tap
            .scan(false) { preValue, _ in
            return !preValue
        }.bind(to: scanStateButton.rx.isSelected)
        .disposed(by: disposeBag)
        
        scanNumberTextField.rx.text.orEmpty.scan("") { preValue, newValue in
            print(preValue, newValue)
            return newValue.isNumber ? newValue: preValue
        }.bind(to: scanNumberTextField.rx.text)
        .disposed(by: disposeBag)
    }
    
    func insertUI() {
        view.addSubview(scanCountButton)
        view.addSubview(scanStateButton)
        view.addSubview(scanNumberTextField)
    }
    
    func basicSetUI() {
        scanCountButton.setTitle("scan count", for: .normal)
        scanCountButton.setTitleColor(.black, for: .normal)
        scanCountButton.tintColor = .clear
        scanCountButton.tintColor = .clear
        
        scanStateButton.setTitle("Scan Selected false", for: .normal)
        scanStateButton.setTitle("Scan Selected true", for: .selected)
        scanStateButton.setTitleColor(.black, for: .normal)
        scanStateButton.setTitleColor(.black, for: .selected)
        
        scanNumberTextField.placeholder = "Scan Into Number"
        scanNumberTextField.textAlignment = .center
    }
    
    func anchorUI() {
        scanCountButton.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        scanStateButton.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.top.equalTo(scanCountButton.snp.bottom)
            $0.trailing.equalTo(view)
            $0.height.equalTo(40)
        }
    
        scanNumberTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(scanStateButton.snp.bottom)
            $0.height.equalTo(40)
        }
    }
    
    func layout() {
        navigationItem.title = "Scan Operator"
        insertUI()
        basicSetUI()
        anchorUI()
    }
}
