# ./mvnw spring-boot:run
# export def run [] {
#  	./mvnw spring-boot:run
# }

export def mvn [
	arg: string = "boot",
	--v(-v)
] {
	if $v {
		try {
			mvn -v
		} catch {
			./mvnw -v
		}
	} else {
        if $arg == "boot" {
            try {
                mvn spring-boot:run
            } catch {
                ./mvnw spring-boot:run
            }
        } else {
            try {
                mvn $arg
            } catch {
                ./mvnw $arg
            }
        }
	}
}

# 寻找一个端口启动 springboot
export def "mvn new" [] {
	mut port = sp
	./mvnw spring-boot:run -Dspring-boot.run.jvmArguments=$"-Dserver.port=($port)"
}


def gra [
	arg: string = "boot",
	--v(-v)
] {
	if $v {
		try {
			gradle -v
		} catch {
			./gradlew -v
		}
	} else {
        if $arg == "boot" {
            try {
                gradle bootRun
            } catch {
                ./gradlew bootRun
            }
        } else {
            try {
                gradle $arg
            } catch {
                ./gradlew $arg
            }
        }
	}
}