import { useQuery } from "@tanstack/react-query";
import { igdbHeaders } from "../constants/api";
import type { IGamePreview } from "../types";
import { measureFetch } from "../utils";

export interface SearchResult {
  id: number;
  game: IGamePreview;
}

const escapeSearchTerm = (value: string) => value.replace(/\\/g, "\\\\").replace(/"/g, '\\"');

const useSearch = (searchTerm: string) => {
  const searchGame = async () => {
    const query = `
      fields game.id, game.cover.image_id, game.name;
      search "${escapeSearchTerm(searchTerm)}";
      limit 30;
    `;

    const { data, durationMs } = await measureFetch<SearchResult[]>(
      "https://api.igdb.com/v4/search",
      {
        method: "POST",
        headers: igdbHeaders,
        body: query,
      },
    );

    const results = data.filter((item) => item.game?.name);

    return { results, durationMs };
  };

  return useQuery({
    queryKey: ["search", searchTerm],
    queryFn: searchGame,
    enabled: searchTerm.length > 0,
  });
};

export default useSearch;
