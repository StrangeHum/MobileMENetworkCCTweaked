import { EnrichedItem } from "@/types/storage";
import Image from "next/image";

type Props = {
  item: EnrichedItem;
};

export default function ItemDisplayComponent({ item }: Props) {
  return (
    <div className="aspect-square rounded-lg  m-4">
      <Image
        alt={item.id}
        src={"/icon/" + item.image_file}
        title={item.id}
        width={32}
        height={32}
        onDragStart={(e) => e.preventDefault()}
      ></Image>
    </div>
  );
}
