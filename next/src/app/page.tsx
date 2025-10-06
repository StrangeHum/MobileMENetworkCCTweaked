"use client";

import { useEffect, useState } from "react";
import styles from "./page.module.css";
import { useUpdateStoreage } from "./storage/storageSystem";

export default function Home() {
  const storage = useUpdateStoreage();

  return (
    <div className={styles.page}>
      <h1>Инвентарь</h1>
      <ul>
        {storage.map((item) => (
          <li key={item.id}>
            <strong>{item.id}</strong> — {item.count} шт.{" "}
            {item.craftable ? "(создаётся)" : ""}
          </li>
        ))}
      </ul>
    </div>
  );
}
