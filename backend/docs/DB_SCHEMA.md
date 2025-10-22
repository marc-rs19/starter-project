# Firestore Database Schema — Symmetry App

Este documento define la estructura de la base de datos utilizada por el backend de la aplicación **Symmetry**, desarrollada con Firebase Firestore.  
Cada artículo se almacena como un documento dentro de la colección `articles`.  
Las miniaturas y otros recursos multimedia se guardan en **Firebase Cloud Storage**, en la carpeta `media/articles/`.

---

# Collection: `articles`

Cada documento representa un artículo de la aplicación.  
Incluye metadatos, contenido, y referencias a recursos externos almacenados en Cloud Storage.

| Campo             | Tipo de dato        | Requerido | Descripción                                                                                           |
| :---------------- | :-----------------: | :-------: | :---------------------------------------------------------------------------------------------------- |
| `id`              |       `string`      |    ✅    | Identificador único del artículo. Puede coincidir con el ID del documento en Firestore.                |
| `title`           |       `string`      |    ✅    | Título visible del artículo mostrado en la app.                                                        |
| `slug`            |       `string`      |    ✅    | Versión del título apta para URL, ej: `entrenamiento-funcional-para-principiantes`.                    |
| `authorId`        |       `string`      |    ✅    | ID del usuario que creó el artículo (referencia a `users/{userId}`).                                   |
| `category`        |       `string`      |    ✅    | Categoría temática principal (`entrenamiento`, `nutrición`, `salud`, etc.).                            |
| `tags`            |   `array<string>`   |    ❌    | Palabras clave que facilitan la búsqueda (`["fuerza", "movilidad"]`).                                  |
| `content`         |       `string`      |    ✅    | Cuerpo completo del artículo (texto o HTML).                                                           |
| `thumbnailURL`    |       `string`      |    ✅    | URL pública de la miniatura almacenada en Cloud Storage (`media/articles/{articleId}/thumbnail.jpg`).  |
| `mediaFolderPath` |       `string`      |    ✅    | Ruta completa en Storage para los archivos del artículo (`media/articles/{articleId}/`).               |
| `readingTime`     |       `number`      |    ❌    | Tiempo estimado de lectura (en minutos).                                                               |
| `isPublished`     |      `boolean`      |    ✅    | Indica si el artículo está publicado y visible al público.                                             |
| `createdAt`       |     `timestamp`     |    ✅    | Fecha de creación (usando `FieldValue.serverTimestamp()`).                                             |
| `updatedAt`       |     `timestamp`     |    ✅    | Fecha de última actualización (actualizada en cada edición).                                           |


---

# Ejemplo de documento

```json
{
  "id": "article_001",
  "title": "Entrenamiento funcional para principiantes",
  "slug": "entrenamiento-funcional-para-principiantes",
  "authorId": "user_123",
  "category": "entrenamiento",
  "tags": ["fuerza", "movilidad", "principiantes"],
  "content": "El entrenamiento funcional mejora la movilidad, la fuerza y la coordinación...",
  "thumbnailURL": "https://firebasestorage.googleapis.com/v0/b/symmetry-backend-b089a.appspot.com/o/media%2Farticles%2Farticle_001%2Fthumbnail.jpg?alt=media",
  "mediaFolderPath": "media/articles/article_001/",
  "readingTime": 5,
  "isPublished": true,
  "createdAt": "2025-10-22T12:00:00.000Z",
  "updatedAt": "2025-10-22T12:00:00.000Z"
}
