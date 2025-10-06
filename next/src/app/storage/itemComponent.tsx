"use client";

import { Item } from "./types";

type Props = {
  item: Item;
};

export default function ItemComponent({ item }: Props) {
  return (
    <div>
      <li key={item.id}>
        <strong>{item.name}</strong> — {item.count} шт.{" "}
        {item.craftable ? "(Можно создать)" : ""}
      </li>
    </div>
  );
}
