FROM maven:3.10.0-eclipse-temurin-25

LABEL maintainer="Stephan Krusche <krusche@tum.de>"

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends gnupg && \
    rm -rf /var/lib/apt/lists/*

ENV M2_HOME=/usr/share/maven

RUN curl --version \
    && gpg --version \
    && git --version \
    && mvn --version \
    && java --version

# Resolve the plugins and dependencies of the Kotlin test template (Kotlin compiler, Ares, JUnit), so that exercises build without
# downloading them from Maven Central
ADD artemis-kotlin-template /opt/artemis-kotlin-template
RUN cd /opt/artemis-kotlin-template && mvn -B clean test && rm -rf /opt/artemis-kotlin-template

# detekt is the static code analysis tool of Kotlin exercises. Artemis runs it as `detekt` and reads its SARIF report.
ARG DETEKT_VERSION=1.23.8
ARG DETEKT_SHA256=3afe89a11120303c73c9bdda3d8fe558dd9070a6937d27819ddc04b275381245
RUN mkdir -p /opt/detekt \
    && curl -fsSL -o /opt/detekt/detekt-cli-all.jar "https://repo1.maven.org/maven2/io/gitlab/arturbosch/detekt/detekt-cli/${DETEKT_VERSION}/detekt-cli-${DETEKT_VERSION}-all.jar" \
    && echo "${DETEKT_SHA256}  /opt/detekt/detekt-cli-all.jar" | sha256sum -c -
COPY detekt /usr/local/bin/detekt
RUN chmod +x /usr/local/bin/detekt && detekt --version

CMD ["mvn"]
