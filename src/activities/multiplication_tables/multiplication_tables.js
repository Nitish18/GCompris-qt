/* GCompris - multiplication_tables.js
 *
 * Copyright (C) 2016 Nitish Chauhan <nitish.nc18@gmail.com>
 *
 * Authors:
 *
 *   "Nitish Chauhan" <nitish.nc18@gmail.com> (Qt Quick port)
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
.pragma library
  .import QtQuick 2.2 as Quick
  .import GCompris 1.0 as GCompris //for ApplicationInfo
  .import "qrc:/gcompris/src/core/core.js" as Core


var currentLevel = 0
var items
var mode
var dataset
var numberOfLevel
var url
var table
var question = []
var answer = []
var score_cnt = 0


function start(_items, _mode, _dataset, _url) {


  items = _items
  mode = _mode
  dataset = _dataset.get()
  url = _url
  numberOfLevel = dataset.length
  currentLevel = 0
  initLevel()
}



function stop() {}

function initLevel() {


    items.bar.level = currentLevel + 1


    // here the error is occurring..............................
    // not able to access them
    items.jamGrid.gridRepeater.itemAt(0).tabletext_1.text = "FFFF"
    items.jamGrid.gridRepeater.itemAt(0).tabletext_1.text = qsTr("FFFF")

    // here the error is occurring..............................


}



function loadCoordinates() {

  question = dataset[currentLevel].questions
  answer = dataset[currentLevel].answers
  table = dataset[currentLevel].TableName


}



function verifyAnswer() {


  if (items.ans_1.text.toString() == answer[0]) {

    score_cnt = score_cnt + 1
    items.img_1.source = url + "right.svg"
    items.img_1.visible = true



  } else {

    items.img_1.visible = true
    items.img_1.source = url + "wrong.svg"

  }




  if (items.ans_2.text.toString() == answer[1]) {

    score_cnt = score_cnt + 1
    items.img_2.source = url + "right.svg"
    items.img_2.visible = true

  } else {

    items.img_2.source = url + "wrong.svg"
    items.img_2.visible = true
  }



  if (items.ans_3.text.toString() == answer[2]) {

    score_cnt = score_cnt + 1
    items.img_3.source = url + "right.svg"
    items.img_3.visible = true

  } else {

    items.img_3.source = url + "wrong.svg"
    items.img_3.visible = true
  }



  if (items.ans_4.text.toString() == answer[3]) {

    score_cnt = score_cnt + 1
    items.img_4.source = url + "right.svg"
    items.img_4.visible = true

  } else {

    items.img_4.source = url + "wrong.svg"
    items.img_4.visible = true
  }




  if (items.ans_5.text.toString() == answer[4]) {

    score_cnt = score_cnt + 1
    items.img_5.source = url + "right.svg"
    items.img_5.visible = true
  } else {

    items.img_5.source = url + "wrong.svg"
    items.img_5.visible = true
  }



  if (items.ans_6.text.toString() == answer[5]) {

    score_cnt = score_cnt + 1
    items.img_6.source = url + "right.svg"
    items.img_6.visible = true

  } else {

    items.img_6.source = url + "wrong.svg"
    items.img_6.visible = true
  }




  if (items.ans_7.text.toString() == answer[6]) {

    score_cnt = score_cnt + 1
    items.img_7.source = url + "right.svg"
    items.img_7.visible = true

  } else {

    items.img_7.source = url + "wrong.svg"
    items.img_7.visible = true
  }




  if (items.ans_8.text.toString() == answer[7]) {

    score_cnt = score_cnt + 1
    items.img_8.source = url + "right.svg"
    items.img_8.visible = true

  } else {

    items.img_8.source = url + "wrong.svg"
    items.img_8.visible = true
  }




  if (items.ans_9.text.toString() == answer[8]) {
    score_cnt = score_cnt + 1
    items.img_9.source = url + "right.svg"
    items.img_9.visible = true
  } else {

    items.img_9.source = url + "wrong.svg"
    items.img_9.visible = true
  }



  if (items.ans_10.text.toString() == answer[9]) {
    score_cnt = score_cnt + 1
    items.img_10.source = url + "right.svg"
    items.img_10.visible = true
  } else {

    items.img_10.source = url + "wrong.svg"
    items.img_10.visible = true
  }



  items.score.text = qsTr("Your Score :-  %1").arg(score_cnt.toString())

}




function nextLevel() {
  if (numberOfLevel <= ++currentLevel) {
    currentLevel = 0
  }
  initLevel();
  resetvalue();
  items.score.visible = false
  items.time.text = qsTr("--")
}

function previousLevel() {
  if (--currentLevel < 0) {
    currentLevel = numberOfLevel - 1
  }
  initLevel();
  resetvalue();
  items.score.visible = false
  items.time.text = qsTr("--")
}
