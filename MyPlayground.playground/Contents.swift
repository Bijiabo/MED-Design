//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var playListIndex : Int = 123

func playIndex(index : Int? = nil) -> Int {
  if index != nil
  {
    playListIndex = index!
  }
  
  return playListIndex
}

func playIndexAdd(number : Int? = 1) -> Int {
  if number != nil
  {
    playListIndex += number!
  }
  
  return playListIndex
}
playIndex()
playIndex(index: nil)
playIndex(index: 1)
playIndex(index: 2)
playListIndex
playIndexAdd(number: 1)
playIndexAdd(number: -1)