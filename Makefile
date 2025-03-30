.PHONY: splash
splash:
	flutter pub get
	dart run flutter_native_splash:create

.PHONY: gen
gen:
	dart run build_runner build --delete-conflicting-outputs