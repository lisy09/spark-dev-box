package com.lisy09.spark_dev_box.kafka_word_count

import java.io.File
import scopt.OptionParser
import org.apache.spark.SparkConf
import org.apache.spark.streaming.StreamingContext
import org.apache.spark.streaming.Seconds
import org.apache.kafka.clients.consumer.ConsumerConfig
import org.apache.kafka.common.serialization.StringDeserializer
import org.apache.spark.streaming.kafka010.KafkaUtils
import org.apache.spark.streaming.kafka010.LocationStrategies
import org.apache.spark.streaming.kafka010.ConsumerStrategies
import org.apache.spark.streaming.dstream.DStream
import scalaj.http.Http
import org.json4s._
import org.json4s.JsonDSL._
import org.json4s.jackson.JsonMethods._

case class Config(
    sparkAppName: String = "",
    batchDurationSeconds: Int = 60,
    kafkaTopics: String = "",
    kafkaBrokers: String = "",
    kafkaGroupId: String = "",
    wordCountUpdateUrl: String = "http://word-count-api:8001/v1/wordcount",
)

object Main extends App {
    val configParser = new OptionParser[Config]("KafkaWordCountExample") {
        head("KafkaWordCountExample", "1.0")
        opt[String]("spark.app.name")
            .required()
            .action((x,c) => c.copy(sparkAppName = x))
            .text("spark.app.name is the name of the spark application")
        opt[Int]("batch.duration.seconds")
            .action((x,c) => c.copy(batchDurationSeconds = x))
        opt[String]("kafka.brokers")
            .required()
            .action((x,c) => c.copy(kafkaBrokers = x))
        opt[String]("kafka.topics")
            .required()
            .action((x,c) => c.copy(kafkaTopics = x))
        opt[String]("kafka.groupId")
            .required()
            .action((x,c) => c.copy(kafkaGroupId = x))
        opt[String]("wordcount.update.url")
            .required()
            .action((x,c) => c.copy(wordCountUpdateUrl = x))
    }
    var conf = new Config()
    configParser.parse(this.args, conf) map { config =>
        conf = config
    } getOrElse {
        sys.exit(1)
    }

    println(conf)
    val sparkConf = new SparkConf()
    val sparkStreamingContext = new StreamingContext(
        conf=sparkConf,
        batchDuration=Seconds(conf.batchDurationSeconds)
    )

    val topicSet = conf.kafkaTopics.split(",").toSet
    val kafkaParams = Map[String,Object](
        ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG -> conf.kafkaBrokers,
        ConsumerConfig.GROUP_ID_CONFIG -> conf.kafkaGroupId,
        ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG -> classOf[StringDeserializer],
        ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG -> classOf[StringDeserializer],
    )
    val messages = KafkaUtils.createDirectStream[String,String](
        sparkStreamingContext,
        LocationStrategies.PreferConsistent,
        ConsumerStrategies.Subscribe[String,String](
            topicSet,
            kafkaParams
        )
    )
    val lines = messages.map(_.value)
    val words = lines.flatMap(_.split(" "))
    val wordCounts = words.map(x=>(x,1L)).reduceByKey(_+_)
    // wordCounts.print()
    wordCounts.foreachRDD{rdd =>
        val url = conf.wordCountUpdateUrl
        // println("url:", url)
        val data = rdd.collect()
        var dict = Map[String,Long]()
        data.foreach{params => 
            val (word,count) = params
            println(word, count)
            dict += (word -> count)
        }
        if (dict.size > 0) {
            val json = (
                "wordcount"->dict
            )
            val postData = compact(render(json))
            println("postdata:",postData)
            val request = Http(url)
                .postData(postData)
                .headers(Map[String,String](
                    "Content-Type" -> "application/json",
                    "Charset" -> "UTF-8"
                ))
            val resp = request.asString
        }
    }

    sparkStreamingContext.start()
    sparkStreamingContext.awaitTermination()
}