# My Aurora OS Application

Short description of my Aurora OS Application

The source code of the project is provided under
[the license](LICENSE.BSD-3-CLAUSE.md),
that allows it to be used in third-party applications.

## Project Structure

The project has a common structure
of an application based on C++ and QML for Aurora OS.

* **[ru.auroraos.DZ6.pro](ru.auroraos.DZ6.pro)** file
  describes the project structure for the qmake build system.
* **[icons](icons)** directory contains application icons for different screen resolutions.
* **[qml](qml)** directory contains the QML source code and the UI resources.
  * **[cover](qml/cover)** directory contains the application cover implementations.
  * **[icons](qml/icons)** directory contains the custom UI icons.
  * **[pages](qml/pages)** directory contains the application pages.
  * **[DZ6.qml](qml/DZ6.qml)** file
    provides the application window implementation.
* **[rpm](rpm)** directory contains the rpm-package build settings.
  **[ru.auroraos.DZ6.spec](rpm/ru.auroraos.DZ6.spec)** file is used by rpmbuild tool.
  It is generated from **[ru.auroraos.DZ6.yaml](rpm/ru.auroraos.DZ6.yaml)** file.
* **[src](src)** directory contains the C++ source code.
  * **[main.cpp](src/main.cpp)** file is the application entry point.
* **[translations](translations)** directory contains the UI translation files.
* **[ru.auroraos.DZ6.desktop](ru.auroraos.DZ6.desktop)** file
  defines the display and parameters for launching the application.