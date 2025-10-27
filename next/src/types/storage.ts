export type Item = {
  id: string;
  displayName: string;
  count: number;
  craftable: boolean;
};

export type EnrichedItem = {
  image_file: string;
  local_name: string;
} & Item;

export type MetaItem = {
  id: string;
  local_name: string;
  image_file: string;
  type: string;
};

export type Store = EnrichedItem[];
