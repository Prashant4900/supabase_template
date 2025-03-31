.PHONY: splash
splash:
	flutter pub get
	dart run flutter_native_splash:create

.PHONY: gen
gen:
	dart run build_runner build --delete-conflicting-outputs

.PHONY: env
env: env_reader --input=".env" --output="assets/env/" --key="MyOptionalSecretKey" --model="lib/gen/env/env_model.dart" --null-safety