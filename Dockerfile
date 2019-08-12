ARG GRADLE_VERSION=4.6

FROM gradle:${GRADLE_VERSION}-jdk8

ARG ANDROID_SDK_BUILD=4333796
ARG ANDROID_PLATFORMS="26 27"
ARG ANDROID_BUILD_TOOLS="28.0.3"

USER root

ENV SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_BUILD}.zip" \
	ANDROID_HOME="/usr/local/android-sdk" \
	ANDROID_PLATFORMS="${ANDROID_PLATFORMS}" \
	ANDROID_BUILD_TOOLS="${ANDROID_BUILD_TOOLS}"

RUN mkdir "$ANDROID_HOME" .android \
	&& cd "$ANDROID_HOME" \
	&& curl -o sdk.zip $SDK_URL \
	&& unzip sdk.zip \
	&& rm sdk.zip \
	&& mkdir "$ANDROID_HOME/licenses" || true \
	&& echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "$ANDROID_HOME/licenses/android-sdk-license"
#	&& yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

RUN $ANDROID_HOME/tools/bin/sdkmanager --update
RUN ( \
	for platform in $ANDROID_PLATFORMS; do echo "platforms;android-$platform"; done; \
	for tools in $ANDROID_BUILD_TOOLS; do echo "build-tools;$tools"; done; \
	) | xargs $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" 

RUN apt-get update \
	&& apt-get install -y \
		build-essential \
		file \
		apt-utils \
	&& rm -rf /var/lib/apt/lists/*
