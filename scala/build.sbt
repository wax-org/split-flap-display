name := "Split-flap display"

scalacOptions += "-Ypartial-unification"

// Test dependencies
libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.8" % Test
libraryDependencies += "org.scalacheck" %% "scalacheck" % "1.14.1" % "test"
