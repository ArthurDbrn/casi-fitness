# casi-fitness
Fitness tracking system accessible through a mobile app and a web dashboard.

This app include two script that can generate data for testing purposes. See the `Generating data` section.

## Installation
### Install gradle
First to make any modification or build the project, you need `gradle` installed. If you have not installed `gradle` on your machine yet run the following command :
```
sudo snap install gradle --classic
```

### Install flutter
If you want to try the mobile app you will need to have `flutter` installed as well. To install it run the following command :

```
sudo snap install flutter --classic
```

As stated by `flutter`, you will also need `Android Studio`. To install it, click [here](https://developer.android.com/studio/index.html) and follow the instructions.

Run `flutter doctor` and resolve any issue stated by by flutter.

### Build the apps
Go to `./server` and build it :

```
cd ./server
./gradlew war
```

Go to `./web_app` and build it :

```
cd ../web_app
./gradlew war
```

## Deploy
### Deploy the servere and the web app
To try the app you will need to deploy the server and the web application. To do so, you must install `glassfish` or any other server management tool. To install glassfish, click [here]().
Before deploying the apps and server, make sure you have built them. See the `Installation` section.

Place the glassfish reppository inside the main repository and run the following commands.
```
cd glassfish/
./bin/asadmin start-domain
./bin/asadmin start-database
./bin/asadmin deploy --force ../server/server/build/libs/server.war
./bin/asadmin deploy --force ../web_app/app/build/libs/app.war
```
If evrything worked properly, the web app should be available at http://localhost:8080/app/.

### Try the mobile app
To try the mobile app, you will need an android device plugged to your computer or an emulator running on your computer.
To launch the app, launch your emulator or plug your device and type :
```
cd ./mobile_app
flutter run
```

## Generating data
To generate data, you'll need python installed. If you have everything installed, make sure the server is running and run the following commands :
- To generate activities : `python ./generate_activities.py` (This will generate 2000 activities. If you want less activities to be generated, feel free to edit the code.)
- To generate goals : `python ./generate_goals.py` (Same as for activities)
