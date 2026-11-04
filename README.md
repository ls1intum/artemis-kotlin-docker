# artemis-kotlin-docker

Build image for Kotlin programming exercises in [Artemis](https://github.com/ls1intum/Artemis). It contains

- JDK 25, Maven and git (from `maven:3.10.0-eclipse-temurin-25`)
- the plugins and dependencies of the Artemis Kotlin test template, resolved at build time (see `artemis-kotlin-template`)
- [detekt](https://detekt.dev/) 1.23.8 as `detekt`, the static code analysis tool. Artemis reads its SARIF report.

Keep `artemis-kotlin-template/pom.xml` in sync with `src/main/resources/templates/kotlin/test/maven/projectTemplate/pom.xml` of Artemis when
the versions of Kotlin, Ares or the Maven plugins change.

### Build locally

	docker build -t artemis-kotlin-docker .

	docker run --rm artemis-kotlin-docker detekt --version

### Publish

The workflow `docker-publish.yml` builds the image on every push and pull request. Pushing a tag like `v1.0.0` publishes
`ghcr.io/ls1intum/artemis-kotlin-docker:v1.0.0`.
