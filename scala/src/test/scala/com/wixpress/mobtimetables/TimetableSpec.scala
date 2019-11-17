package com.wixpress.mobtimetables

import org.scalatest.FlatSpec
import org.scalatest._

class TimetableSpec extends FlatSpec {
  "Timetable" should "transform CAT into DOG" in {
    val now = "CAT"
    val next = "DOG"
    val rotors = 1 :: 13 :: 27 :: Nil
    val flap = Timetable.flap(now, rotors)
    val flapRotors = Timetable.calcRotations(now, next)
    assert(flap === next)
    assert(rotors === flapRotors)
  }

  it should "transform KBP/TLV into KBP/FUE" in {
    val now =  "PS 0779   18:55    TEL-AVIV         B7    ON TIME"
    val next = "WX XXXX   16:20    FUERTEVENTURA    A1    ON TIME"
    val rotors = List(7, 52, 49, 33, 47, 0, 52, 30, 0, 0, 0, 52, 2, 51, 52, 5, 0, 0, 0, 40, 30, 31, 38, 42, 18, 30, 24, 4, 6, 1, 51, 37, 26, 0, 0, 0, 53, 49, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    val flap = Timetable.flap(now, rotors)
    val flapRotors = Timetable.calcRotations(now, next)
    assert(flap === next)
    assert(rotors === flapRotors)
  }

}
