.PHONY: repair clean upgrade pod-install build-runner pre-build
.SILENT:

repair:
	~/tools/flutter/bin/flutter pub cache repair && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_database && ~/tools/flutter/bin/flutter pub cache repair && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_rest && ~/tools/flutter/bin/flutter pub cache repair && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_utility && ~/tools/flutter/bin/flutter pub cache repair && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_widget && ~/tools/flutter/bin/flutter pub cache repair && ~/tools/flutter/bin/flutter pub get

clean:
	rm -rf ~/Library/Caches/CocoaPods
	rm -rf ~/Library/Application\ Support/Code/Cache/*
	rm -rf ~/Library/Application\ Support/Code/CachedData/*
	rm -rf pubspec.lock
	~/tools/flutter/bin/flutter clean && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_database && rm -rf pubspec.lock && ~/tools/flutter/bin/flutter clean && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_rest && rm -rf pubspec.lock && ~/tools/flutter/bin/flutter clean && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_utility && rm -rf pubspec.lock && ~/tools/flutter/bin/flutter clean && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_widget && rm -rf pubspec.lock && ~/tools/flutter/bin/flutter clean && ~/tools/flutter/bin/flutter pub get

upgrade:
	~/tools/flutter/bin/flutter pub upgrade && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_database && ~/tools/flutter/bin/flutter pub upgrade && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_rest && ~/tools/flutter/bin/flutter pub upgrade && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_utility && ~/tools/flutter/bin/flutter pub upgrade && ~/tools/flutter/bin/flutter pub get
	cd package/mvs_widget && ~/tools/flutter/bin/flutter pub upgrade && ~/tools/flutter/bin/flutter pub get

pod-install:
	cd ios && rm -rf Pods && rm -rf Podfile.lock && rm -rf Flutter/Flutter.podspec
	cd ios && pod deintegrate && sudo gem uninstall cocoapods && sudo gem uninstall cocoapods-core && sudo gem uninstall cocoapods-downloader && sudo gem install cocoapods
	cd ios && pod setup && pod install --repo-update && pod cache clean --all && pod update
	~/tools/flutter/bin/flutter clean && ~/tools/flutter/bin/flutter pub get && ~/tools/flutter/bin/flutter pub cache repair && ~/tools/flutter/bin/flutter pub get

build-runner:
	find . -name '\*.g.~/tools/flutter/bin/dart' -type f -delete
	~/tools/flutter/bin/dart run build_runner clean
	~/tools/flutter/bin/dart run build_runner build --delete-conflicting-outputs
	cd package/mvs_database && ~/tools/flutter/bin/dart run build_runner clean
	cd package/mvs_database && ~/tools/flutter/bin/dart run build_runner build --delete-conflicting-outputs
	cd package/mvs_rest && ~/tools/flutter/bin/dart run build_runner clean
	cd package/mvs_rest && ~/tools/flutter/bin/dart run build_runner build --delete-conflicting-outputs

pre-build: clean build-runner


switch-cat:
	bash ./vendor/cat/switch.sh

switch-dog:
	bash ./vendor/dog/switch.sh



build-cat-apk: pre-build switch-cat
	bash ./vendor/core/build.sh "cat" "apk"

build-cat-appbundle: pre-build switch-cat
	bash ./vendor/core/build.sh "cat" "appbundle"

build-cat-ipa: pre-build switch-cat
	bash ./vendor/core/build.sh "cat" "ipa"

build-cat-linux: pre-build switch-cat
	bash ./vendor/core/build.sh "cat" "linux"

build-cat-macos: pre-build switch-cat
	bash ./vendor/core/build.sh "cat" "macos"

build-cat-web: pre-build switch-cat
	bash ./vendor/core/build.sh "cat" "web"



build-dog-apk: pre-build switch-dog
	bash ./vendor/core/build.sh "dog" "apk"

build-appbundle-dog: pre-build switch-dog
	bash ./vendor/core/build.sh "dog" "appbundle"

build-ipa-dog: pre-build switch-dog
	bash ./vendor/core/build.sh "dog" "ipa"

build-linux-dog: pre-build switch-dog
	bash ./vendor/core/build.sh "dog" "linux"

build-macos-dog: pre-build switch-dog
	bash ./vendor/core/build.sh "dog" "macos"

build-web-dog: pre-build switch-dog
	bash ./vendor/core/build.sh "dog" "web"