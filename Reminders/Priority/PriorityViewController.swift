//
//  PriorityViewController.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class PriorityViewController: BaseViewController {
    
    let mainView = PriorityView()
    var delegate: PassDataDelegate?
    var selectedSegment: Int?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.prioritySegment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let selectedSegment = selectedSegment else { return }
        delegate?.priorityReceived(selectIndex: mainView.prioritySegment.selectedSegmentIndex)
    }
    
    @objc func segmentChanged(sender: UISegmentedControl) {
        selectedSegment = sender.selectedSegmentIndex
    }
}
