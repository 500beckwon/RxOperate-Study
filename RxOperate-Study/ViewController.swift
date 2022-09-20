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
    private var disposeBag = DisposeBag()
    
    private let scanCountButton = UIButton()
    private let scanCountButton2 = UIButton(type: .system)
    private let scanStateButton = UIButton()
    private let scanNumberTextField = UITextField()
    
    let addCount = BehaviorRelay<Int>(value: 0)
    let minusCount = BehaviorRelay<Int>(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        bindUI()
    }
    
    
    func bindUI() {
        scanCountButton.rx.tap
            .map { 1 }
            .bind(to: addCount)
            .disposed(by: disposeBag)
        
        scanCountButton2.rx.tap
            .map { -1 }
            .bind(to: minusCount)
            .disposed(by: disposeBag)
        
        scanStateButton.rx.tap
            .scan(false) { preValue, _ in
            return !preValue
        }.bind(to: scanStateButton.rx.isSelected)
        .disposed(by: disposeBag)
        
        scanNumberTextField.rx.text.orEmpty
            .scan("") { preValue, newValue in
            return newValue.isNumber ? newValue: preValue
        }.bind(to: scanNumberTextField.rx.text)
        .disposed(by: disposeBag)
    }
    
    func bind() {
        addCount
            .scan(0, accumulator: {$0 + $1})
            .map { "scan Plus Count \($0)" }
            .bind(to: scanCountButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        minusCount
            .scan(0, accumulator: {$0 - $1 })
            .map { "scan Minus Count \(-$0)" }
            .bind(to: scanCountButton2.rx.title(for: .normal))
            .disposed(by: disposeBag)
    }
    
    func insertUI() {
        view.addSubview(scanCountButton)
        view.addSubview(scanCountButton2)
        view.addSubview(scanStateButton)
        view.addSubview(scanNumberTextField)
    }
    
    func basicSetUI() {
        scanCountButton.setTitle("scan Plus Count", for: .normal)
        scanCountButton.setTitleColor(.black, for: .normal)
        scanCountButton.tintColor = .clear
        
        scanCountButton2.setTitle("scan Minus Count", for: .normal)
        scanCountButton2.setTitleColor(.black, for: .normal)
        scanCountButton2.tintColor = .clear
        
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
        
        scanCountButton2.snp.makeConstraints {
            $0.top.equalTo(scanCountButton.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(40)
        }
        
        scanStateButton.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.top.equalTo(scanCountButton2.snp.bottom)
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
