//
//  AddViewController.swift
//  MyNotes
//
//  //Created by ocean.yu on 16/4/01.




//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate,UIAlertViewDelegate, NoteBLDelegate {
    
    //接收从服务器返回数据。
    var datas : NSMutableData!
    //业务逻辑对象BL
    var bl: NoteBL!
    
    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bl = NoteBL()
        self.bl.delegate = self
        self.txtView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onclickSave(sender: AnyObject) {
        
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate  =  dateFormatter.stringFromDate(NSDate())
       
        let note = Note(id:nil , date: strDate ,content: self.txtView.text)
        
        self.bl.createNote(note)
        
        self.txtView.resignFirstResponder()
    }
    
    @IBAction func onclickCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //UIAlertView Delegate  Method
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex = \(buttonIndex)")
        
        if buttonIndex == 0 {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else if buttonIndex == 1 {
            self.txtView.text = ""
            self.txtView.becomeFirstResponder()
        }
    }
    
    // MARK:- 处理通知
    //插入Note方法 成功
    func createNoteFinished(){
        
        let alertView = UIAlertView(title: "操作信息",
            message: "插入成功。",
            delegate: self,
            cancelButtonTitle: "返回",
            otherButtonTitles:"继续")
        
        alertView.show()
    }
    
    //插入Note方法 失败
    func createNoteFailed(error : NSError) {
        let errorStr = error.localizedDescription
        
        let alertView = UIAlertView(title: "操作信息",
            message: errorStr,
            delegate: self,
            cancelButtonTitle: "返回",
            otherButtonTitles:"继续")
        
        alertView.show()
    }
    
    //修改Note方法 成功
    func modifyNoteFinished() { }
    
    //修改Note方法 失败
    func modifyNoteFailed(error : NSError) { }
    
    //查询所有数据方法 成功
    func findAllNotesFinished(list : NSMutableArray) {  }
    
    //查询所有数据方法 失败
    func findAllNotesFailed(error : NSError) {  }
    
    
    //删除Note方法 成功
    func removeNoteFinished() {}
    
    //删除Note方法 失败
    func removeNoteFailed(error : NSError) {}

}
