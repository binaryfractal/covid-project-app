![Covid App](https://covid.binaryfractal.com/assets/coronavirus.svg)

# Covid App
_Covid App es una aplicación para android que ayuda a llevar un control de tu estado de salud respecto al COVID-19, permitiendote realizar check ups de manera constante._

_Conoce más acerca de __[Covid App](https://covid.binaryfractal.com/).___

## Pre-requisitos 📋

_Es necesario que tengas corriendo el proyecto de firebase [covid-project-backend](https://github.com/binaryfractal/covid-project-backend) el cual expone los métodos que consume la app, para mayores detalles acerca de estas funciones ir al repositorio [covid-project-backend](https://github.com/binaryfractal/covid-project-backend)._

_Debe agregar el proyecto firebase a su proyecto android, en el siguiente enlace están los pasos para poder lograrlo. __[Pasos](https://firebase.google.com/docs/android/setup?hl=es-419)___

## Comenzando 🚀
_Una vez clonado el repositorio deberá ejecutar el siguiente comando sobre la raíz del proyecto para poder obtener los paquetes que utiliza la aplicación._

```
flutter pub get
```
_En el archivo `covid-project-application/lib/src/core/api_url.dart` cambiar la etiqueta `{url_project}` de la variable `url_base` por la de tu proyecto de firebase ejemplo:_

```
static const url_base = 'https://covid-app.cloudfunctions.net/api';
```

__Listo ya puede ejecutar el proyecto!!!__

## Construido con 🛠️

* [flutter](https://flutter-es.io/)_: Es el kit de herramientas de UI de Google para realizar hermosas aplicaciones._
* [bloc](https://bloclibrary.dev/#/)_: Una biblioteca de manejo de estado predecible que ayuda a implementar el patrón de diseño de BLoC._

## Versiones 📌
__Version 1.0.0+1:__ _Se cambiaron texto de la aplicación_  
__Versión 1.0.1:__ _Se cambio el calculo para casos activos._

## Autores 📖
* [César](https://www.linkedin.com/in/cesaralbertonavachavez)
* [René](https://www.linkedin.com/in/rene-santiago-resendiz)
* [Mel](https://www.linkedin.com/in/mel-almanza-8869aa50/)

- - -
__[binaryfractal](https://binaryfractal.com/)__  
![Covid App](https://binaryfractal.com/assets/img/binaryfractal.png)
