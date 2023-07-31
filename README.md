# multivendor_clean_architecture_starter
Multivendor starter and example for new Flutter project based on Clean Architecture.\
As an example, a display of facts about cats and dogs is implemented :)\
The starter uses an public [Cat-Facts API](https://alexwohlbruck.github.io/cat-facts/docs/) to get facts about animals.

## Getting Started
- [Vendor](#vendor)
  - [Benefits](#benefits)
  - [Requirements](#requirements)
  - [Before starting work with vendors](#before-starting-work-with-vendors)
  - [Add new vendor](#add-new-vendor)
  - [Switch vendor](#switch-vendor)
  - [Config registration](#config-registration)
  - [Why not flavors](#why-not-flavors)
- [Clean Architecture](#clean-architecture)
  - [Basis](#basis)
  - [Examples](#examples)
- [Project](#project)
  - [Used patterns](#used-patterns)
  - [Unrecommended patterns](#unrecommended-patterns)
  - [Structure](#structure)
- [Approaches](#approaches)
  - [Interfaces](#interfaces)
  - [Models](#models)
  - [Generation](#generation)
  - [Components](#components)
  - [Presentation](#presentation)
- [Misconceptions](#misconceptions)
- [Packages](#packages)
  - [Recomended packages](#recomended-packages)
  - [Unrecommended packages](#unrecomended-packages)
- [CLI](#cli)
  - [Build runner](#build-runner)
  - [Vendor](#vendor)
  - [Build](#build)

## Vendor
This project has the ability to completely change the vendor environment.\
Under vendors, not only specific vendors of one application can be implemented (for example, as an implementation of an "white-label" application), but also a canonical approach to "Development" and "Production" environments.
### Benefits
It allows you to have one project that can change the complete application environment depending on the vendor, while having only one Dart codebase.\
The environment change is implemented by [a shell script](https://github.com/ivangalkindeveloper/multi_vendor_starter/blob/master/lib/vendor/core/switch_vendor.sh).\
Current script changes the following environment properties:
- Project identificators (Android package, iOS bundleID, Linux applicationId, macOS bundleID);
- Application name (Android, iOS, Lunix, macOS, Web, Windows);
- Application icon (Android, iOS, Lunix, macOS, Web, Windows);
- Application splash screen (Android, iOS, Web);
- Third-party services.

And there are also examples of changing identifiers for [Facebook Events](https://pub.dev/packages/facebook_app_events) and [FreshchatSDK](https://pub.dev/packages/freshchat_sdk).
### Requirements
Make sure you have the [GNU sed](https://www.gnu.org/software/sed/) stream text editor installed.\
You can work with scripts from any available shell.
### Before starting work with vendors
Please carefully study how the core [script](https://github.com/ivangalkindeveloper/multi_vendor_starter/blob/master/lib/vendor/core/switch_vendor.sh) works to change the environment.\
You should modify this script to suit your needs so that the script uses only the materials and services you need.\
The script contains an example of using [Facebook Events](https://pub.dev/packages/facebook_app_events) and [FreshchatSDK](https://pub.dev/packages/freshchat_sdk) - these lines are commented out for your understanding, so that you also comment or add the necessary lines for your project to work.\
Also pay attention to [the vendor scripts](https://github.com/ivangalkindeveloper/multi_vendor_starter/blob/master/lib/vendor/VendorCat/switch.sh), which pass parameters for the operation of the core script.
### Add new vendor
In order to create a new vendor environment, you need the following:
1. Create a folder with the vendor name in the directory ./lib/vendor/;
2. Collect the following materials in the created folder:\
  2.1. Firebase services files - google-services.json, GoogleService-Info.plist.\
  2.2. Application icon:\
The recommended size - 1024x1024.\
The required name - icon.png.\
  2.3. Splash screen background for light and dark theme:\
The recommended size - 375x812.\
The required names - splash_background.png, splash_background_dark.png.\
  2.4. Splash screen logo for Android 12 for light and dark theme:\
The recommended size - 1152x1152.\
The required names - splash_logo_android_12.png, splash_logo_android_12_dark.png.\
  2.5. Splash screen logo for light and dark theme:\
The recommended size - no more than 400 in height.\
The required names - splash_logo.png, splash_logo_dark.png.\
3. Add a script to change the environment.\
Repeat already created scripts for the environment and fill in the parameters that need to be updated.\
The last line is sure to run the core script.\
The required name - switch.sh.\
4. Add a command to change the vendor in this README in the CLI section for quick convenience:
```sh
bash ./vendor/<new-vendor-folder-name>/switch.sh
```

About launcher icon see details [here](https://pub.dev/packages/flutter_launcher_icons) or splash screen see details [here](https://pub.dev/packages/flutter_native_splash).
### Switch vendor
To start the vendor environment change, run:
```sh
bash ./vendor/<vendor-folder-name>/switch.sh
```
### Config registration
Registration of the config occurs in different main fucntions through the arguments of the runner and initializer utilities in order to be able to change the environment locally and look at the generated application materials by running only the development environment.\
Made for the convenience for launching in VS Сode and not through run commands.
### Why not flavors
Flavors are not able to generate vendor application materials and do not know how to work with third-party services, but simply control the launch of the application only in the config part.\
This applies to the following packages:
* [flutter_flavorizr](https://pub.dev/packages/flutter_flavorizr);
* [flutter_flavor](https://pub.dev/packages/flutter_flavor);
* [flavor](https://pub.dev/packages/flavor);
* [flavor_text](https://pub.dev/packages/flavor_text);
* [enviroment_flavor](https://pub.dev/packages/enviroment_flavor);
* [go_flavor](https://pub.dev/packages/go_flavor);
* [flavor_config](https://pub.dev/packages/flavor_config);
* [flutter_app_environment](https://pub.dev/packages/flutter_app_environment);
* [environment_config](https://pub.dev/packages/environment_config).

## Clean Architecture
The starter is based on [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).\
Clean Architecture - a combination of concepts, principles and approaches taken from all past architectures (Layered, Screaming, DDD, Hexagonal and Onion) to be combined into one architecture that ensures the correct delegation of responsibility and, as a result, easy scaling of the project.\
This is clearly reflected in the interaction of the main layers of the project, the chosen dependency stack and even the directory structure.\
At the moment, this is the best architecture that is suitable not only for enterprise projects, but also for any Flutter projects for proper project scalability.
### Basis
The main concept - the allocation of business rules as the core, low connectivity of modules and interaction with dependency inversion.\
Main layers of architecture:\
![](https://hsto.org/r/w1560/web/22b/033/c50/22b033c50a144c7491662c8cd292fbab.jpg)\

There is a rule in architecture - Dependency Rule.\
The rule interprets that the inner layers should not depend on the outer ones. That is, our business logic and application logic should not depend on presenters, UI, databases, etc. On the original diagram, this rule is depicted with arrows pointing inward.\
If we cut the layers according to this rule, we will get the following picture:\
![](https://hsto.org/r/w1560/web/fe8/c82/a32/fe8c82a32b1548b1a297187e24ae755a.png)

When applied to real projects, we get the following scheme, which is more clearly reflected in the interaction of layers:\
![](https://hsto.org/r/w1560/web/531/04c/89d/53104c89d9cf44a59c95e351b7485574.png)
### Examples
Many well-known companies and service products use clean architecture, for example:\
* [Tivi](https://github.com/chrisbanes/tivi) - android application for watching series and movies. Tivi developers use the MVP architecture (Model-View-Presenter) for the practical implementation of Clean Architecture. They use the main activity, which is the View component, the Presenter component, which is in the middle layer and contains the business logic of the application, and the model component, which is in the lowest layer and processes data and network requests. Each of the layers in a Tivi application is as independent as possible from each other, so changes in one layer do not lead to unpredictable results in other components.
* [Saleor](https://github.com/saleor/saleor) - Python project, which is an open source electronic trading platform.
It is fully consistent with the principles and concepts of clean architecture. This project uses the Django framework as a complete model for implementing the Clean Architecture. In a Saleor project, each of the application components is divided into separate layers that manage separate aspects of the application logic.\
* Draw - example of using Clean Architecture in C# projects. The developers decided to divide the system into three separate layers. The first layer contains the user interface and the data presentation layer. The next layer includes the application logic and the business logic application. The last layer contains classes related to data storage. Each of the layers in Draw is completely independent and can be easily changed without changing other layers.

If we are talking about a flutter project, there are repositories with good examples:
* [flutter-tdd-clean-architecture-course](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course);
* [flutter_clean_architecture](https://github.com/ShadyBoukhary/flutter_clean_architecture).

## Project
The main project directories are well suited for separating them into separate application modules.\
The project does not use the Presenter pattern, logic controllers using the popular BLoC state management are allocated as a separate "logic" directory.\
The BLoC is not a presenter, but is distinguished as a separate business layer:\

![](https://madewithflutter.net/wp-content/uploads/2022/11/architecture.png)
### Used patterns
The starter used the following programming patterns:
* Controller - classes that implement logic only for further data representing;
* Command - class-commands that explicitly display the purpose of use. Use cases are a special case of this pattern. Use cases are used in the layer as application business rules to explicitly show the entire operation of the application at the interaction level with all business rules embedded.
* Interactor - business logic implementation class, used as a replacement for use cases in favor of multiple class commands.
* Repository - a layer of interaction with data from different data sources;
* Data Access Object (DAO) - separates a data resource's client interface from its data access mechanisms.
### Unrecommended patterns
* Service Locator - the global typemap is an antipattern, since anything can happen to the objects inside the locator during the entire life cycle of the program, which leads to weakly tracked errors.
### Structure
The structure of the project clearly reflects the interaction of the layers of the architecture:\
```
lib/
├── generated/    - directory of all generated files (should be in .gitignore);
├── main/     - main functions that launch the runner/initializer utility.
└── src/    - main source directory;
    ├── core/     - core directory, here is two independent layers - data and domain, as common data and datasources from the point of view of the program core, and domain - business entities and rules from the point of view of architecture;
    │   ├─── data/     - common data and datasources of the program core;
    │   │    ├─── client/     - clents classes, for example - API client;
    │   │    │    └───── interceptor/    - interceptors for API client;
    │   │    │
<I>-------------------------------------------↓-<IHttpClient / IApiClient>
    │   │    │
    │   │    ├─── data/   - data models;
    │   │    ├─── repository/     - repositories for working with datasources;
    │   │    │
<I>-------------------------------------------↓-<IApi & IDao>
    │   │    │
    │   │    └─── source/     - datasources directory;
    │   │         ├───── api/    - api directory;
    │   │         └───── database/     - database directory;
    │   │                ├─────── dao/    - DAO(CRUD) database models;
    │   │                └─────── table/    - tables of database;
    │   │
<I>-------------------------------------------↓-<IRepository>
    │   │
    │   └─── domain/     - directory of domain (enterprise) business entities and logic;
    │        ├───── entity/     - entities directory;
    │        ├───── interactor/     - interactor directory;
    │        └───── use_case/     - use cases directory;
    │
<I>-------------------------------------------↑-<IUseCase / IInteractor>
    │
    ├── logic/    - directory of application business logic for further presentation;
    │
<I>-------------------------------------------↑-<IState>
    │
    ├── presentation/     - widget/view layer;
    │       ├─────── application/    - root application widget;
    │       ├─────── component/    - components directory;
    │       ├─────── l10n/     - localization arb files and untranslated fields;
    │       ├─────── router/     - router(s) of application;
    │       └─────── view/    - main directory of presentation activities and presenters;
    │                ├─── dialog/     -  dialogs directory;
    │                ├─── modal/    -  modals directory;
    │                ├─── page/     - pages directory;
    │                └─── picker/     -  dateTime or timeOfDay pickers directory;
    │
    └── utility/    - utilities or helpers directory;
        ├────── extension/    - extension directory (BuildContext, types and other);
        ├────── initializer/    - initialization library-utility;
        ├────── logger/     - application ligger;
        ├────── mixin/    - classes mixins;
        ├────── opener/     - open datasources library-utility;
        └────── runner/     - runner application library-utility;

vendor/     - directory vendor for materials and scripts;
```

## Approaches
Existing good approaches to the implementation of the project, which help to better navigate the project code:
#### Interfaces
All interface classes are written with an "I" prefix.\
This helps to determine that a given class is definitely an interface and cannot be an object.\
there is also an approach to add the "Impl" postfix for classes that are implementations of this interface, but the author does not consider this mandatory, since it is clear that any class without the "I" prefix is ​​some kind of implementation and model, even without an interface.
It makes no sense to separate the interfaces on which implementations in the singular are implemented into different files.\
Put the interface itself and its only implementation in one file, it's more convenient.
#### Models
It is desirable to use the generation of deserialization and serialization of models - that gives minimization of errors associated with this process.\
It is customary to share the following data names and their responsibility:\
Data Tranfser Object (DTO postfix) - data received only from the API;\
Data Access Object (DAO postfix) - data access only from database;\
"Config" / "InitializatonStep" / "Database" - only core data of program;\
"Profile" / "Remittance"  "DocumentRequirements" - only domain business models and business rules;\
"Runner" / "Initializer" / "Mapper" / "Parser" - only utilities or helpers. 
#### Generation
Never mix generation code with main code.\
Keep the generation in a separate directory that is not tracked by GIT.
#### Components
Always make widget components with a prefix that specifies only the name of the project or target group of projects to understand that this component is custom from the standard Flutter widgets.\
For example, project name "financial_wallet" - FW:\
FWAppBar, FWPrimaryButton, FWText...\
Components should not contain business logic, but should only provide an API to manage them.\
You can pass any model to a component only if the model properties are needed only to display the component.
#### Presentation
No need to create separate services for modals, dialogs and pickers.\
You just need separate widget classes, with static "show" method, in which the required field will be BuildContext.

## Misconceptions
A few misconceptions about Clean Architecture:
#### "Mandatory mapping between layers"
If you have a complex application with business logic and application logic, and/or different people working on different layers, then it's better to separate the data between layers (and map them).\
It is also worth doing if the server API is clumsy.\
But if you are working on a project alone, and it is a simple application, then do not complicate it with unnecessary mapping.\
This project has only DTO, DAO and business entities, ViewModels here, since this function is essentially performed by the BLoC as a presenter.
#### "Mapping only in the interactor"
Mapping of models should take place in the layer that should be provided to another in a form convenient for him.\
This is stated in [the original article](https://blog.cleancoder.com/uncle-bob/2011/11/22/Clean-Architecture.html).\
"So when we pass data across a boundary, it is always in the form that is most convenient for the inner circle."\
Therefore, the data should get into the Interactor in the form it needs. Mapping takes place in the Interface Adapters layer, that is, in the Presenter and Repository.
#### "UseCases is useless"
The main problem is that use cases are special cases of the command pattern and a legacy of flashy architecture.\
This pattern and architecture are designed to explicitly display by classes which business functions and rules your application uses, so the options used are required to solve not technical problems, but architectural ones.\
If it seems to the developer that this approach is too tedious and useless, in this case, he can always combine all the business rules into an interactor.
#### "Clean Architecture is not needed in small projects"
There is an opinion that it is not desirable to implement Clean Architecture on small projects, since its implementation can lead to a lot of time and effort spent on a small project that does not require much architectural attention.\
The author of this package does not agree with this opinion and believes that it is better to implement architecture on absolutely any applications, since any project will always be subject to scaling, development or just refinement.
#### "Clean Architecture is the correct construction of project directories"
Clean Architecture does not interpret the principles of building folders and directories.\
The main concept is written in the chapter above.

## Packages
### Recomended packages
Utility:
- [build_runner](https://pub.dev/packages/build_runner);

Data:
- [freezed](https://pub.dev/packages/freezed);
- [json_annotation](https://pub.dev/packages/json_annotation);
- [equatable](https://pub.dev/packages/equatable);

Asynchrony:
- [stream_transform](https://pub.dev/packages/stream_transform);
- [rxdart](https://pub.dev/packages/rxdart);
- [isolated_worker](https://pub.dev/packages/isolated_worker);

Networking:
- [dio](https://pub.dev/packages/dio);
- [web_socket_channel](https://pub.dev/packages/web_socket_channel);
- [signalr_core](https://pub.dev/packages/signalr_core);

Database:
- [sqflite](https://pub.dev/packages/sqflite);
- [drift](https://pub.dev/packages/drift);
- [shared_preferences](https://pub.dev/packages/shared_preferences);

State managment:
- [bloc](https://pub.dev/packages/bloc);
- [flutter_bloc](https://pub.dev/packages/flutter_bloc);

Presentation:
- [flutter_platform_component](https://pub.dev/packages/flutter_platform_component);
- [animations](https://pub.dev/packages/animations);
- [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations);
- [rive](https://pub.dev/packages/rive);
- [funvas](https://pub.dev/packages/funvas);
- [graphx](https://pub.dev/packages/graphx);
- [auto_size_text](https://pub.dev/packages/auto_size_text);
- [pinput](https://pub.dev/packages/pinput);
- [flutter_svg](https://pub.dev/packages/flutter_svg);
- [lottie](https://pub.dev/packages/lottie);
- [dotted_border](https://pub.dev/packages/dotted_border);
- [badges](https://pub.dev/packages/badges);

Platform:
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash);
- [geolocator](https://pub.dev/packages/geolocator);
- [permission_handler](https://pub.dev/packages/permission_handler);
- [camera](https://pub.dev/packages/camera);
- [url_launcher](https://pub.dev/packages/url_launcher);
- [path](https://pub.dev/packages/path);
- [path_provider](https://pub.dev/packages/path_provider);
- [intl](https://pub.dev/packages/intl);
- [connectivity_plus](https://pub.dev/packages/connectivity_plus);
- [share_plus](https://pub.dev/packages/share_plus);
- [package_info_plus](https://pub.dev/packages/package_info_plus);
- [device_info_plus](https://pub.dev/packages/device_info_plus);
- [image_picker](https://pub.dev/packages/image_picker);
- [file_picker](https://pub.dev/packages/file_picker);

Service:
- [firebase_messaging](https://pub.dev/packages/firebase_messaging);
- [firebase_analytics](https://pub.dev/packages/firebase_analytics);
- [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics);
- [firebase_performance](https://pub.dev/packages/firebase_performance);
- [firebase_app_check](https://pub.dev/packages/firebase_app_check);
- [sentry](https://pub.dev/packages/sentry);
### Unrecomended packages
Data:
- [get_it](https://pub.dev/packages/get_it):\
A global type map that implements the Service-Locator pattern.\
Flutter is a DI framework that has a build context, so locator templates for these applications make no sense.

Database:
- [hive](https://pub.dev/packages/hive):\
A huge set of problems - complex testing, complex queries, migrations, performance and reliability problems (a known problem with database crashes in production).
- [isar](https://pub.dev/packages/isar):\
The problematic legacy of Hive.

State managment:
- [get](https://pub.dev/packages/get):\
The whole package is an anti-pattern, which itself is also based on the Service Locator.\
The package tries to be a state manager, a configurator and a repository at the same time. A huge bastard object, which is already a ban for use.\
Previously, it also had bugs that could only be discovered in production.
- [riverpod](https://pub.dev/packages/riverpod):\
Implementation of global variables and states.
- [hydrated_bloc](https://pub.dev/packages/hydrated_bloc):\
Implementation and stores of global states.

Presentation:
- [flutter_hooks](https://pub.dev/packages/flutter_hooks):\
Violation of the functional programming paradigm, which in turn talks about the clean of functions, which should be clean, not affect any external variables and states.\
The build function in widgets should always be clean.

## CLI
#### Build runner
```
dart run build_runner build --delete-conflicting-outputs
dart run build_runner build
```
#### Vendor
```sh
bash ./vendor/VendorCat/switch.sh
bash ./vendor/VendorDog/switch.sh
```
#### Build
```
flutter build web -t lib/main/main_vendor_cat.dart --release --no-tree-shake-icons
flutter build web -t lib/main/main_vendor_dog.dart --release --no-tree-shake-icons

flutter build web -t lib/main/main_vendor_cat.dart --release
flutter build web -t lib/main/main_vendor_dog.dart --release

flutter build web -t lib/main/main_vendor_cat.dart
flutter build web -t lib/main/main_vendor_dog.dart
```