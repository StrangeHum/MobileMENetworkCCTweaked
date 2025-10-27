import { url } from "@/app/api/apis";
import { MetaItem, EnrichedItem, Item } from "@/types/storage";
import itemMetaData from "@/data/icon-exports-metadata.json";

export async function GET() {
  const res = await fetch(`${url}/update`, { cache: "no-store" });
  if (!res.ok) {
    return Response.json(
      { error: "Ошибка запроса к серверу" },
      { status: res.status }
    );
  }

  const serverItems: Item[] = await res.json();

  const metaItems: MetaItem[] = itemMetaData.meta;

  const enriched: EnrichedItem[] = serverItems.map((item) => {
    const meta = metaItems.find((m) => m.id === item.id);
    return {
      ...item,
      local_name: meta?.local_name,
      image_file: meta?.image_file,
    };
  });

  return Response.json(enriched);
}
