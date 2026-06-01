export const getImageUrl = (imageId: string) =>
  `https://images.igdb.com/igdb/image/upload/t_1080p/${imageId}.webp`;

export async function measureFetch<T>(
  url: string,
  options: RequestInit,
): Promise<{ data: T; durationMs: number }> {
  const start = performance.now();
  const response = await fetch(url, options);
  const durationMs = Math.round(performance.now() - start);

  if (!response.ok) {
    throw new Error(`Request failed: ${response.statusText}`);
  }

  const data = (await response.json()) as T;
  return { data, durationMs };
}
