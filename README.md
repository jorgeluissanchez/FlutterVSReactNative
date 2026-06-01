# GamesExplorer — Comparación Flutter vs React Native

Proyecto de la asignatura de desarrollo móvil: la misma aplicación implementada en **React Native (Expo)** y **Flutter**, con el fin de comparar rendimiento, tiempos de desarrollo y experiencia técnica.

Referencia original: `lynxjsDemo` (Lynx JS).

---

## Contenido del repositorio

| Carpeta | Stack | Descripción |
|---------|--------|-------------|
| [`RNComaparacionDemo`](./RNComaparacionDemo) | React Native + Expo | App **GamesExplorer RN** |
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

---

## Variables de entorno

Cada proyecto tiene su propio `.env` (copiar desde `.env.example`).

**React Native (Expo):**
```env
EXPO_PUBLIC_IGDB_CLIENT_ID=tu_client_id
EXPO_PUBLIC_IGDB_AUTH_TOKEN=Bearer tu_access_token
```

**Flutter:**
```env
IGDB_CLIENT_ID=tu_client_id
IGDB_AUTH_TOKEN=Bearer tu_access_token
```

Reinicia el servidor de desarrollo después de modificar el `.env`.

---

## Cómo ejecutar

### GamesExplorer RN

```bash
cd RNComaparacionDemo
npm install
npm start
```

Abrir con **Expo Go** escaneando el QR (misma red Wi‑Fi).

### GamesExplorer Flutter

**No ejecutar en Chrome/Edge (web):** IGDB bloquea las peticiones por CORS → `ClientException: Failed to fetch`.

```bash
cd FlutterComparationDemo
flutter pub get
flutter run -d windows
```

O en Android: `flutter run -d android`

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
| React Native | _pendiente_ | `eas build` / build release local |
| Flutter | _pendiente_ | `flutter build apk --release` |

### 2. Tiempo de respuesta API

Medir desde la solicitud hasta que los datos se muestran en pantalla (promedio de varias ejecuciones). Ambas apps muestran el valor en ms en detalle de juego y búsqueda.

| Escenario | React Native (ms) | Flutter (ms) |
|-----------|-------------------|--------------|
| Detalle de juego | | |
| Búsqueda | | |

### 3. Fluidez de la interfaz

| Criterio | React Native | Flutter |
|----------|--------------|---------|
| Scroll en listas horizontales/verticales | | |
| Navegación entre pantallas | | |
| Evidencia (video / profiling) | | |

### 4. Tiempo de compilación

| Métrica | React Native | Flutter |
|---------|--------------|---------|
| Build release (primera vez) | | |
| Build release (incremental) | | |
| Recarga en desarrollo (hot reload / hot restart) | | |

### 5. Cold start

Tiempo desde abrir la app (completamente cerrada) hasta la primera pantalla usable.

| Medición | React Native | Flutter |
|----------|--------------|---------|
| Promedio (≥ 5 runs) | | |
| Dispositivo / emulador | | |

---

## Análisis comparativo (borrador)

_Espacio para la conclusión del informe: facilidad de desarrollo, curva de aprendizaje, rendimiento percibido, tamaño del bundle, ecosistema, etc._

---

## Notas

- Los comentarios CRUD **no** llaman a IGDB; solo viven en RAM.
- Los GET de juegos y eventos **sí** usan la API real para poder medir latencia de red.
- La app Lynx original (`lynxjsDemo`) sirve como referencia de UI y queries; no incluye CRUD de comentarios.

---

## Autores

Sandro Daniel Torres Gutierrez.
Jorge Luis Sanchez Barreneche.
