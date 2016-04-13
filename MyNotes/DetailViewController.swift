//
//  DetailViewController.swift
//  MyNotes
//
//  //Created by ocean.yu on 16/4/01.

//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate, NoteBLDelegate {
    
    //接收从服务器返回数据。
    var datas : NSMutableData!
    //业务逻辑对象BL
    var bl: NoteBL!    
    
    @IBOutlet weak var txtView: UITextView!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let note: Note = self.detailItem as? Note {
            let content = note.content as String? //NSString改为String
            if self.txtView != nil {
                self.txtView.text = content
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        self.bl = NoteBL()
        self.bl.delegate = self
        self.txtView.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onclickSave(sender: AnyObject) {
        
        let note = self.detailItem as! Note//as改为as!
        
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate  =  dateFormatter.stringFromDate(NSDate())
        
        note.date = strDate
        note.content = self.txtView.text
        //var nnot = Note(id: nil, date: strDate, content: self.txtview.text)
        self.bl.modifyNote(note)
        
        self.txtView.resignFirstResponder()
    }
    
    // MARK:- 处理通知    
    //修改Note方法 成功
    func modifyNoteFinished() {
        let alertView = UIAlertView(title: "操作信息",
            message: "修改成功。",
            delegate: nil,
            cancelButtonTitle: "OK")
        
        alertView.show()
    }
    
    //修改Note方法 失败
    func modifyNoteFailed(error : NSError) {
        
        let errorStr = error.localizedDescription
        
        let alertView = UIAlertView(title: "操作信息",
            message: errorStr,
            delegate: nil,
            cancelButtonTitle: "OK")
        
        alertView.show()
    }
    
    //查询所有数据方法 成功
    func findAllNotesFinished(list : NSMutableArray) {  }
    
    //查询所有数据方法 失败
    func findAllNotesFailed(error : NSError) {  }

    
    //删除Note方法 成功
    func removeNoteFinished() {}
    
    //删除Note方法 失败
    func removeNoteFailed(error : NSError) {}
    
    //插入Note方法 成功
    func createNoteFinished(){}
    
    //插入Note方法 失败
    func createNoteFailed(error : NSError){}
}

