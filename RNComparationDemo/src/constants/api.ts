const clientId = process.env.EXPO_PUBLIC_IGDB_CLIENT_ID;
const authToken = process.env.EXPO_PUBLIC_IGDB_AUTH_TOKEN;

if (!clientId || !authToken) {
  throw new Error(
    "Faltan variables de entorno IGDB. Copia .env.example a .env y configura EXPO_PUBLIC_IGDB_CLIENT_ID y EXPO_PUBLIC_IGDB_AUTH_TOKEN.",
  );
}

export const igdbHeaders = {
  "client-id": clientId,
  Authorization: authToken,
  "Content-Type": "text/plain",
  Accept: "application/json",
};
