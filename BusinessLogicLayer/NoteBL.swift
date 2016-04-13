//
//  NoteBL.swift
//  MyNotes
//
//Created by ocean.yu on 16/4/01.

//

import Foundation

class NoteBL : NSObject, NoteDAODelegate {
    
    var delegate: NoteBLDelegate!
    
    //插入Note方法
    func createNote(model: Note) {
        let dao:NoteDAO = NoteDAO.sharedInstance
        dao.delegate = self
        dao.create(model)
    }
    
    //修改Note方法
    func modifyNote(model: Note) {
        let dao:NoteDAO = NoteDAO.sharedInstance
        dao.delegate = self
        dao.modify(model)
    }
    
    //删除Note方法
    func removeNote(model: Note) {
        let dao:NoteDAO = NoteDAO.sharedInstance
        dao.delegate = self
        dao.remove(model)
    }
    
    //查询所用数据方法
    func findAllNotes() {
        let dao:NoteDAO = NoteDAO.sharedInstance
        dao.delegate = self
        dao.findAll()
    }
    
    //MARK: --NoteDAODelegate 委托方法
    //查询所有数据方法 成功
    func findAllFinished(list: NSMutableArray) {
        self.delegate.findAllNotesFinished(list)
    }
    
    //查询所有数据方法 失败
    func findAllFailed(error : NSError) {
        self.delegate.findAllNotesFailed(error)
    }
    
    //插入Note方法 成功
    func createFinished() {
        self.delegate.createNoteFinished()
    }
    
    //插入Note方法 失败
    func createFailed(error : NSError) {
        self.delegate.createNoteFailed(error)
    }
    
    //删除Note方法 成功
    func removeFinished() {
        self.delegate.removeNoteFinished()
    }
    //删除Note方法 失败
    func removeFailed(error : NSError) {
        self.delegate.removeNoteFailed(error)
    }
    
    //修改Note方法 成功
    func modifyFinished(){
        self.delegate.modifyNoteFinished()
    }
    //修改Note方法 失败
    func modifyFailed(error : NSError) {
        self.delegate.modifyNoteFailed(error)
    }
    
    //按照主键查询数据方法 成功
    func findByIdFinished(model : Note) {}
    
    //按照主键查询数据方法 失败
    func findByIdFailed(error : NSError) {}
    
    
}
