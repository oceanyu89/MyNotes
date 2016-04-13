//
//  NoteDAODelegate.swift
//  MyNotes
//
//Created by ocean.yu on 16/4/01.

//
//

import Foundation

protocol NoteDAODelegate {
    
    //查询所有数据方法 成功
    func findAllFinished(list : NSMutableArray)
    
    //查询所有数据方法 失败
    func findAllFailed(error : NSError)
    
    //按照主键查询数据方法 成功
    func findByIdFinished(model : Note)
    
    //按照主键查询数据方法 失败
    func findByIdFailed(error : NSError)
    
    //插入Note方法 成功
    func createFinished()
    
    //插入Note方法 失败
    func createFailed(error : NSError)
    
    //删除Note方法 成功
    func removeFinished()
    
    //删除Note方法 失败
    func removeFailed(error : NSError)
    
    //修改Note方法 成功
    func modifyFinished()
    
    //修改Note方法 失败
    func modifyFailed(error : NSError)
    
}