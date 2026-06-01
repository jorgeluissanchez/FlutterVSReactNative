import { useQuery } from "@tanstack/react-query";
import { igdbHeaders } from "../constants/api";
import type { IGame } from "../types";
import { measureFetch } from "../utils";

const useGame = (id: string) => {
  const getGame = async () => {
    const query = `
      fields name, cover.image_id, rating, genres.name, summary, platforms.name, release_dates.human,
      involved_companies.company.name,
      similar_games.name, similar_games.cover.image_id,
      screenshots.image_id;
      where id = ${id};
    `;

    const { data, durationMs } = await measureFetch<IGame[]>(
      "https://api.igdb.com/v4/games",
      {
        method: "POST",
        headers: igdbHeaders,
        body: query,
      },
    );

    return { game: data[0], durationMs };
  };

  return useQuery({
    queryKey: ["game", id],
    queryFn: getGame,
    enabled: !!id,
  });
};

export default useGame;
