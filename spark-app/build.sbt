scalaVersion := "2.12.12"
val sparkVersion = "3.0.1"
val kafkaVersion = "2.6.0"

name := "spark-dev-box"
version := "1.0"
javaOptions += "-Dfile.encoding=UTF-8"
javaOptions += "-DXX:+UseCompressedOops"

assemblyMergeStrategy in assembly := {
    case PathList("META-INF", xs @ _*) => MergeStrategy.discard
    case "application.conf" => MergeStrategy.concat
    case "reference.conf" => MergeStrategy.concat
    case x => MergeStrategy.first
}

libraryDependencies ++= Seq(
    // https://index.scala-lang.org/apache/spark/spark-core
    "org.apache.spark" %% "spark-core" % sparkVersion % "provided",
    "org.apache.spark" %% "spark-sql" % sparkVersion % "provided",
    "org.apache.spark" %% "spark-streaming" % sparkVersion % "provided",
    "org.apache.spark" %% "spark-streaming-kafka-0-10" % sparkVersion,
)

//https://github.com/scopt/scopt
libraryDependencies += "com.github.scopt" %% "scopt" % "4.0.0"

libraryDependencies += "org.scalaj" %% "scalaj-http" % "2.4.2"
libraryDependencies += "org.json4s" %% "json4s-native" % "3.6.10"

parallelExecution in ThisBuild := false
test in assembly := {}
assemblyJarName := s"${name.value}-assembly-${version.value}.jar"