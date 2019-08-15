FROM sdrik/android-build:base

RUN \
	$ANDROID_HOME/tools/bin/sdkmanager "platforms;android-26" && \
	$ANDROID_HOME/tools/bin/sdkmanager "platforms;android-27" && \
	$ANDROID_HOME/tools/bin/sdkmanager "build-tools;28.0.3"
