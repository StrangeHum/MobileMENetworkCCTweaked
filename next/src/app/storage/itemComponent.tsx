"use client";

import { Item } from "./types";
import Image from "next/image";

type Props = {
  item: Item;
};

export default function ItemComponent({ item }: Props) {
  const id = item.id.replace(":", "/");

  return (
    <div className="aspect-square rounded-lg h-24 w-24 m-4">
      <Image
        alt={"/textures_out/" + id + ".png"}
        src={"/textures_out/" + id + ".png"}
        width={50}
        height={50}
      ></Image>
      {/* <h1>{item.count}</h1> */}
      {/* <strong>{item.displayName}</strong> — {item.count} шт. */}
      {/* <h1>{item.craftable ? "Можно создать" : ""}</h1> */}
    </div>
  );
}
