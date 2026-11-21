FROM registry.access.redhat.com/ubi9/openjdk-17@sha256:7c71bf6a9eebdff3738453ec2833b542393e5be226b0af7a94eb7277d890b103 AS build

WORKDIR /tmp
COPY --chmod=0644 ["Java Code/HelloWorld.java", "./"]
RUN javac HelloWorld.java && jar --create --file hello.jar --main-class HelloWorld HelloWorld.class

FROM registry.access.redhat.com/ubi9/openjdk-17-runtime@sha256:0d5736bab543ab8fa6e18fc71581b279cf995e61ef5858986523dc1bdbe9e32d

WORKDIR /app
COPY --from=build --chmod=0644 /tmp/hello.jar .
USER 185:0
ENTRYPOINT ["java", "-jar", "hello.jar"]
