//
//  ListViewController.swift
//  Shopping List
//
//  Created by Shishir_Mac on 12/3/23.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    @IBOutlet weak var listTableView: UITableView!
    
    var titles = [String]()
    var ids = [UUID]()
    var selectedRows = [IndexPath]()
    
    var selectedTask = ""
    var selectedTaskId : UUID?
    
//    var todoStruct = Todo(isMarked: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editBarButtonAction(_ sender: UIBarButtonItem) {
        print("Edit")
    }
    
    @IBAction func shareBarButtonAction(_ sender: UIBarButtonItem) {
        print("Share")
    }
    
    @IBAction func deleteBarButtonAction(_ sender: UIBarButtonItem) {
        print("Delete")
    }
    
}
