//
//  NoteBLDelegate.swift
//  MyNotes
//Created by ocean.yu on 16/4/01.



import Foundation

protocol NoteBLDelegate {
    
    //查询所有数据方法 成功
    func findAllNotesFinished(list : NSMutableArray)
    
    //查询所有数据方法 失败
    func findAllNotesFailed(error : NSError)
    
    //插入Note方法 成功
    func createNoteFinished()
    
    //插入Note方法 失败
    func createNoteFailed(error : NSError)
    
    //修改Note方法 成功
    func modifyNoteFinished()
    
    //修改Note方法 失败
    func modifyNoteFailed(error : NSError)
    
    //删除Note方法 成功
    func removeNoteFinished()
    
    //删除Note方法 失败
    func removeNoteFailed(error : NSError)
    
}