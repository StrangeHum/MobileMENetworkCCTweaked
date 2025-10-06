import { get } from "http";
import { useEffect, useState } from "react";
type item = {
  id: string;
  count: number;
  craftable: boolean;
};

const apis = {
  update: "http://192.168.0.105:8081/update",
};

export const updateStorage = (callback: any) => {
  fetch(apis.update, {
    method: "GET", // или "GET", если сервер это поддерживает
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((data) => {
      console.log("Получены данные:", data);
      callback(data);
    })
    .catch((err) => console.error("Ошибка при загрузке:", err));
};

export const useUpdateStoreage = () => {
  const [items, setItems] = useState<item[]>([]);

  useEffect(() => {
    updateStorage(setItems);
  }, []);
  return items;
};
