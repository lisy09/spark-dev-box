scalaVersion := "2.12.12"
val sparkVersion = "3.0.1"

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
    "org.apache.spark" %% "spark-streaming-kafka-0-10" % sparkVersion % "provided",
)

libraryDependencies += "com.typesafe" % "config" % "1.4.1"

parallelExecution in ThisBuild := false
test in assembly := {}
assemblyJarName := s"${name.value}-assembly-${version.value}.jar"