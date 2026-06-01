# GamesExplorer — Comparación Flutter vs React Native

Proyecto de la asignatura de desarrollo móvil: la misma aplicación implementada en **React Native (Expo)** y **Flutter**, con el fin de comparar rendimiento, tiempos de desarrollo y experiencia técnica.

---

## Contenido del repositorio

| Carpeta | Stack | Descripción |
|---------|--------|-------------|
| [`RNComaparacionDemo`](./RNComparationDemo) | React Native + Expo | App **GamesExplorer RN** |
| [`FlutterComparationDemo`](./FlutterComparationDemo) | Flutter | App **GamesExplorer Flutter** |

---

## Funcionalidades (ambas apps)

- Consumo de **API REST** (IGDB: juegos y eventos).
- Datos de la API en **memoria** durante la sesión (sin persistencia en disco).
- Listas con scroll, navegación entre pantallas y detalle de juego.
- **Búsqueda** de juegos.
- **CRUD de comentarios simulado en memoria** (crear, leer, editar, eliminar) asociado a cada juego; no persiste al cerrar la app.
- **Medición de tiempo de respuesta API** visible en pantallas de detalle y búsqueda (`API: XXX ms`).

### Manejo de estado

| App | API (IGDB) | Comentarios (CRUD local) |
|-----|------------|---------------------------|
| React Native | React Query | Context + `useReducer` |
| Flutter | Caché en `IgdbService` | Provider + `ChangeNotifier` |


## Cómo ejecutar

### GamesExplorer RN

```bash
cd RNComaparacionDemo
npm install
npm start
```

Abrir con **Expo Go** escaneando el QR (misma red Wi‑Fi).

### GamesExplorer Flutter

**No ejecutar en Chrome/Edge (web) sin antes descargar una extension para evitar el bloqueo por CORS:** IGDB bloquea las peticiones por CORS → `ClientException: Failed to fetch`.
La puedes descargar aqui: https://chromewebstore.google.com/detail/allow-cors-access-control/lhobafahddgcelffkeicbaginigeejlf?pli=1

```bash
cd FlutterComparationDemo
flutter pub get
flutter run 
```

APK debug (opcional):

```bash
flutter build apk --debug
```

---

## Métricas de comparación

> Sección para documentar resultados de la actividad. Completar con mediciones reales del grupo.

### 1. Tamaño del APK (Release)

| Plataforma | Tamaño | Notas |
|------------|--------|--------|
| React Native | 45.3 MB | `eas build` / build release local |
| Flutter | 47.45 MB | `flutter build apk --release` |

### 2. Tiempo de respuesta API

Medir desde la solicitud hasta que los datos se muestran en pantalla (promedio de varias ejecuciones). Ambas apps muestran el valor en ms en detalle de juego y búsqueda.

| Escenario | React Native (ms) | Flutter (ms) |
|-----------|-------------------|--------------|
| Detalle de juego | 470| 491|
| Búsqueda | 2210|2236 |

### 3. Fluidez de la interfaz

| Criterio | React Native | Flutter |
|----------|--------------|---------|
| Scroll en listas horizontales/verticales |Fluido, sin saltos perceptibles |Fluido, con ligeras caídas en listas extensas |
| Navegación entre pantallas | Transiciones rapidas| Transiciones rapidas|

React Native en general se sintio ligeramente mas fluido.

### 4. Tiempo de compilación

| Métrica | React Native | Flutter |
|---------|--------------|---------|
| Build release (primera vez) | 6 min 45 s| 8 min 36 s|
| Build release (incremental) | 1 min 20 s| 1 min 45 s|
| Recarga en desarrollo (hot reload / hot restart) | 2–3 s (Fast Refresh)| 1–2 s (Hot Reload)|

### 5. Cold start

Tiempo desde abrir la app (completamente cerrada) hasta la primera pantalla usable.

| Medición | React Native | Flutter |
|----------|--------------|---------|
| Promedio (≥ 5 runs) | 2.1 s| 1.8 s|

Ambos se probaron en emuladores, pero claro esto está muy sujeto al equipo utilizado

---

## Análisis comparativo (borrador)

Durante el desarrollo de ambas aplicaciones se observó que la facilidad de uso y la curva de aprendizaje dependen en gran medida de la experiencia previa del equipo. Nosotros ya contabamos con conocimientos de TypeScript y React, por lo que la adaptación a React Native resultó más natural y requirió menos tiempo de aprendizaje.

En cuanto a la experiencia de desarrollo, React Native presentó ventajas al utilizar Expo Go, ya que permitió ejecutar y probar la aplicación de forma rápida sin configuraciones complejas. Además, durante las pruebas de consumo de APIs no se presentaron inconvenientes relacionados con restricciones de CORS, lo que facilitó el desarrollo y la depuración.

Por otro lado, Flutter ofreció una experiencia más integrada en el proceso de generación de aplicaciones para distribución. Aunque los tiempos de compilación inicial fueron superiores, la generación del APK resultó más directa y consistente, con menos dependencias externas y una configuración más centralizada dentro del propio framework.

Respecto al rendimiento percibido, ambas aplicaciones mostraron una experiencia fluida en la navegación entre pantallas, el desplazamiento de listas y la interacción general con la interfaz. De manera subjetiva, la versión desarrollada con React Native presentó una sensación ligeramente más ágil durante el uso cotidiano; sin embargo, las diferencias observadas no fueron lo suficientemente significativas como para concluir una superioridad clara de un framework sobre el otro.

Ambos frameworks demostraron ser alternativas maduras y capaces para el desarrollo multiplataforma. React Native puede resultar especialmente atractivo para equipos con experiencia previa en el ecosistema JavaScript y React, mientras que Flutter ofrece una solución más integrada y homogénea para la construcción y distribución de aplicaciones. La elección entre uno u otro dependerá principalmente de los conocimientos previos del equipo, los requisitos del proyecto y las preferencias del flujo de trabajo.

---

## Notas

- Los comentarios CRUD **no** llaman a IGDB; solo viven en RAM.
- Los GET de juegos y eventos **sí** usan la API real para poder medir latencia de red.

---

## Autores

Sandro Daniel Torres Gutierrez.
Jorge Luis Sanchez Barreneche.
