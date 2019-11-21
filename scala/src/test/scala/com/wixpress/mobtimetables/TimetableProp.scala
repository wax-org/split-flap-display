package com.wixpress.mobtimetables

import org.scalacheck.Prop.forAll
import org.scalacheck._

object TimetableProp extends Properties("Timetable") {

  case class Input(display: String, flapped: String)

  property("flap input (rotations input target) == target") = forAll { (input: Input) =>
    Timetable.flap(input.display, Timetable.calcRotations(input.display, input.flapped)) == input.flapped
  }

  def stringGen(size: Int): Gen[String] =
    Gen.listOfN(size, Gen.oneOf(Timetable.alphabet.toCharArray.toList)).map(_.mkString)

  val inputGen: Gen[Input] = Gen.sized { size =>
    for {
      display <- stringGen(size)
      flapped <- stringGen(size)
    } yield Input(display, flapped)
  }

  implicit val arbInput: Arbitrary[Input] = Arbitrary[Input](inputGen)
}
