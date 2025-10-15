import { get } from "http";
import { useEffect, useState } from "react";
import { Store } from "./types";

export const updateStorage = (callback: any) => {
  fetch("/api/update")
    .then((res) => res.json())
    .then((data) => {
      console.log("Получены данные:", data);
      callback(data);
    })
    .catch((err) => console.error("Ошибка при загрузке:", err));
};

export const useUpdateStoreage = () => {
  const [items, setItems] = useState<Store>();

  useEffect(() => {
    updateStorage(setItems);
  }, []);
  return items;
};
