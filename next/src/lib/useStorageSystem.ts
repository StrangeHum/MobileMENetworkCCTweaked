"use client";

import { useEffect, useState } from "react";
import { Store } from "@/types/storage";

const fetchStorage = async (): Promise<Store> => {
  const res = await fetch("/api/update", { cache: "no-store" });

  if (!res.ok) throw new Error("Ошибка загрузки данных");

  return res.json();
};
type returnProps = [Store | undefined, string];

export const useUpdateStoreage = (): returnProps => {
  const [items, setItems] = useState<Store>();
  const [error, setError] = useState<string>("");

  useEffect(() => {
    fetchStorage()
      .then((data) => setItems(data))
      .catch((error) => {
        setError(error);
      });
  }, []);
  return [items, error];
};
