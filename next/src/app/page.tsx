"use client";

import { useEffect, useState } from "react";
import styles from "./page.module.css";

const apis = {
  update: "http://192.168.0.105:8081/update",
};

type item = {
  id: string;
  count: number;
  craftable: boolean;
};

export default function Home() {
  const [items, setItems] = useState<item[]>([]);

  useEffect(() => {
    fetch(apis.update, {
      method: "GET", // или "GET", если сервер это поддерживает
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((res) => res.json())
      .then((data) => {
        console.log("Получены данные:", data);
        setItems(data);
      })
      .catch((err) => console.error("Ошибка при загрузке:", err));
  }, []);

  // useEffect(() => {
  //   setItems([{ id: "gtceu:lapis_dust", count: 140, craftable: false }]);
  // }, []);

  return (
    <div className={styles.page}>
      <h1>Инвентарь</h1>
      <ul>
        {items.map((item) => (
          <li key={item.id}>
            <strong>{item.id}</strong> — {item.count} шт.{" "}
            {item.craftable ? "(создаётся)" : ""}
          </li>
        ))}
      </ul>
    </div>
  );
}
