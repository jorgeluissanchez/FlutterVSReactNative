import { useQuery } from "@tanstack/react-query";
import { igdbHeaders } from "../constants/api";
import type { IGamePreview } from "../types";
import { measureFetch } from "../utils";

const useGameQuery = (query: string) => {
  const getQueriedGames = async () => {
    const { data, durationMs } = await measureFetch<IGamePreview[]>(
      "https://api.igdb.com/v4/games",
      {
        method: "POST",
        headers: igdbHeaders,
        body: query,
      },
    );

    return { games: data, durationMs };
  };

  return useQuery({
    queryKey: ["gameQuery", query],
    queryFn: getQueriedGames,
    refetchOnWindowFocus: false,
    refetchOnMount: false,
    staleTime: Infinity,
  });
};

export default useGameQuery;
