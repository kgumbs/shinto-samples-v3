package tech.mrwconsulting.springboot

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
@RestController
class MyApplication

fun main(args: Array<String>) {
	runApplication<MyApplication>(*args)

	@GetMapping("/")
	index() {
		return "Welcome to Shinto pipeline samples";
	}
}
