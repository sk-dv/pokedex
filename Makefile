get:
	fvm flutter pub get

run:
	fvm flutter run

build: 
	fvm flutter packages pub run build_runner build --delete-conflicting-outputs

linters:
	fvm flutter pub run import_sorter:main lib\/* test\/*
	fvm flutter format .
	fvm flutter analyze

apk: 
	fvm flutter build apk --debug