//
//  NoteDAO.swift
//  MyNotes
//
//Created by ocean.yu on 16/4/01.

//

import Foundation

class NoteDAO : NSObject {
    
    let HOST_PATH = "/service/mynotes/WebService.php"
    let HOST_NAME = "51work6.com"
    let USER_ID = "2250436706@qq.com"
    
    var delegate: NoteDAODelegate!
    
    //保存数据列表
    var listData: NSMutableArray!
    
    class var sharedInstance: NoteDAO {
        struct Static {
            static var instance: NoteDAO?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NoteDAO()
        }
        return Static.instance!
    }
    
    
    //插入Note方法
    func create(model: Note) {
        
        let engine = MKNetworkEngine(hostName: HOST_NAME, customHeaderFields: nil)
       //Swift1.1 -> Swift1.2修改点 start
        var param = [String : String]()
        param["email"] = USER_ID
        param["type"] = "JSON"
        param["action"] = "add"
        param["date"] = model.date
        param["content"] = model.content
        //Swift1.1 -> Swift1.2修改点 end
        
        let op = engine.operationWithPath(HOST_PATH, params: param, httpMethod:"POST")
        
        op.addCompletionHandler({ (operation) -> Void in
            
            NSLog("responseData : %@", operation.responseString())
            
            let data  = operation.responseData()
            var resDict :NSDictionary!
            do{
             resDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)  as! NSDictionary//as改为as!
            }catch{}
            
            let resultCodeNumber: NSNumber = resDict.objectForKey("ResultCode") as! NSNumber//as改为as!
            let resultCode = resultCodeNumber.integerValue
            
            if resultCode >= 0 {
                self.delegate.createFinished()
            } else {
                let message = resultCodeNumber.errorMessage
                //Swift1.1 -> Swift1.2修改点 start
                let userInfo = [NSLocalizedDescriptionKey:message]
                //Swift1.1 -> Swift1.2修改点 end
                let err = NSError(domain:"DAO", code:resultCode, userInfo: userInfo)
                
                self.delegate.createFailed(err)
            }
            
        }, errorHandler: { (operation, err) -> Void in
            NSLog("MKNetwork请求错误 : %@", err.localizedDescription)
            self.delegate.createFailed(err)
                
        })
        engine.enqueueOperation(op)
        
    }
    
    //删除Note方法
    func remove(model: Note) {
        
        let engine = MKNetworkEngine(hostName: HOST_NAME, customHeaderFields: nil)

        //Swift1.1 -> Swift1.2修改点 start
        var param = [String : String]()
        param["email"] = USER_ID
        param["type"] = "JSON"
        param["action"] = "remove"
        param["id"] = model.ID
        //Swift1.1 -> Swift1.2修改点 end
        
        let op = engine.operationWithPath(HOST_PATH, params: param, httpMethod:"POST")
        
        op.addCompletionHandler({ (operation) -> Void in
            
            let data  = operation.responseData()
            var resDict :NSDictionary!
            do{
                resDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)  as! NSDictionary//as改为as!
            }catch{}
            
            let resultCodeNumber: NSNumber = resDict.objectForKey("ResultCode") as! NSNumber//as改为as!
            let resultCode = resultCodeNumber.integerValue
            
            if resultCode >= 0 {
                self.delegate.removeFinished()
            } else {
                let message = resultCodeNumber.errorMessage
                //Swift1.1 -> Swift1.2修改点 start
                let userInfo = [NSLocalizedDescriptionKey:message]
                //Swift1.1 -> Swift1.2修改点 end
                
                let err = NSError(domain:"DAO", code:resultCode, userInfo: userInfo)
                
                self.delegate.removeFailed(err)
            }
            
            }, errorHandler: { (operation, err) -> Void in
                NSLog("MKNetwork请求错误 : %@", err.localizedDescription)
                self.delegate.removeFailed(err)
                
        })
        engine.enqueueOperation(op)
        
    }
    
    //修改Note方法
    func modify(model: Note) {
        
        let engine = MKNetworkEngine(hostName: HOST_NAME, customHeaderFields: nil)
  
        //Swift1.1 -> Swift1.2修改点 start
        var param = [String : String]()
        param["email"] = USER_ID
        param["type"] = "JSON"
        param["action"] = "modify"
        param["date"] = model.date
        param["content"] = model.content
        param["id"] = model.ID
        //Swift1.1 -> Swift1.2修改点 end
        
        let op = engine.operationWithPath(HOST_PATH, params: param, httpMethod:"POST")
        
        op.addCompletionHandler({ (operation) -> Void in
            
            NSLog("responseData : %@", operation.responseString())
            let data  = operation.responseData()
            var resDict :NSDictionary!
            do{
                resDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)  as! NSDictionary//as改为as!
            }catch{}
            
            let resultCodeNumber: NSNumber = resDict.objectForKey("ResultCode") as! NSNumber//as改为as!
            let resultCode = resultCodeNumber.integerValue
            
            if resultCode >= 0 {
                self.delegate.modifyFinished()
            } else {
                let message = resultCodeNumber.errorMessage
                //Swift1.1 -> Swift1.2修改点 start
                let userInfo = [NSLocalizedDescriptionKey:message]
                //Swift1.1 -> Swift1.2修改点 end
                let err = NSError(domain:"DAO", code:resultCode, userInfo: userInfo)
                
                self.delegate.modifyFailed(err)
            }
            
            }, errorHandler: { (operation, err) -> Void in
                NSLog("MKNetwork请求错误 : %@", err.localizedDescription)
                self.delegate.modifyFailed(err)
                
        })
        engine.enqueueOperation(op)
    }
    
    //查询所有数据方法
    func findAll() {
        
        let engine = MKNetworkEngine(hostName: HOST_NAME, customHeaderFields: nil)

        //Swift1.1 -> Swift1.2修改点 start
        var param = [String : String]()
        param["email"] = USER_ID
        param["type"] = "JSON"
        param["action"] = "query"
        
        let op = engine.operationWithPath(HOST_PATH, params: param, httpMethod:"POST")
        
        op.addCompletionHandler({ (operation) -> Void in
            
            NSLog("responseData : %@", operation.responseString())
            let data  = operation.responseData()
            var resDict :NSDictionary!
            do{
                resDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)  as! NSDictionary//as改为as!
            }catch{}
            
            if resDict != nil
            {
            
            
            let resultCodeNumber: NSNumber = resDict.objectForKey("ResultCode") as! NSNumber  //as改为as!
            let resultCode = resultCodeNumber.integerValue
            
            if resultCode >= 0 {
                
                let listDict = resDict.objectForKey("Record") as! NSMutableArray
                let listData = NSMutableArray()
                
                for dic in listDict {
                    let row = dic as! NSDictionary
                    
                    let _id  = row.objectForKey("ID") as! NSNumber  //as改为as!
                    let strDate  = row.objectForKey("CDate") as! String  //as改为as!,NSString改为String
                    let content = row.objectForKey("Content") as! String  //as改为as!,NSString改为String
                    
                    let note = Note(id: _id.stringValue, date:strDate, content: content)

                    listData.addObject(note)
                }
                //Swift1.1 -> Swift1.2修改点 end
                
                self.delegate.findAllFinished(listData)
                
            } else {
                let message = resultCodeNumber.errorMessage
                //Swift1.1 -> Swift1.2修改点 start
                let userInfo = [NSLocalizedDescriptionKey:message]
                //Swift1.1 -> Swift1.2修改点 end
                
                let err = NSError(domain:"DAO", code:resultCode, userInfo: userInfo)
                
                self.delegate.findAllFailed(err)
            }
            
            }
            else
            {
                let alertview = UIAlertView(title: "", message: "nil", delegate: nil, cancelButtonTitle: "ok")
                    alertview.show()
            }
            
            }, errorHandler: { (operation, err) -> Void in
                NSLog("MKNetwork请求错误 : %@", err.localizedDescription)
                self.delegate.findAllFailed(err)
                
        })
        engine.enqueueOperation(op)
        
    }    
}
