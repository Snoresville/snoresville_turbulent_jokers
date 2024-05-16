export type Rarity =
  | "Common"
  | "Uncommon"
  | "Rare"
  | "Legendary"
  | "Joker"
  | "Tarot"
  | "Planet"
  | "Spectral"
  | "Voucher"
  | "Pack"
  | "Enhancement"
  | "Edition"
  | "Seal"
  | "Deck"
  | "Sticker"
  | "Boss Blind"
  | "Showdown";

export type NamedColour =
  | "MULT"
  | "CHIPS"
  | "MONEY"
  | "XMULT"
  | "FILTER"
  | "ATTENTION"
  | "BLUE"
  | "RED"
  | "GREEN"
  | "PALE_GREEN"
  | "ORANGE"
  | "IMPORTANT"
  | "GOLD"
  | "YELLOW"
  | "CLEAR"
  | "WHITE"
  | "PURPLE"
  | "BLACK"
  | "L_BLACK"
  | "GREY"
  | "CHANCE"
  | "JOKER_GREY"
  | "BOOSTER"
  | "DARK_EDITION"
  | "ETERNAL"
  | "INACTIVE"
  | "HEARTS"
  | "DIAMONDS"
  | "SPADES"
  | "CLUBS"
  | "ENHANCED"
  | "JOKER"
  | "TAROT"
  | "PLANET"
  | "SPECTRAL"
  | "VOUCHER"
  | "EDITION";

export type CardImageDef = {
  image_url: `${string}.png`;
  soul_url?: `${string}.png`;
};

export type CardDef = {
  name: string;
  text: string[];
  image: CardImageDef;
  rarity: Rarity;
};

export type LinkButton = {
  name: string;
  link: string;
};

export type CardSectionProps = {
  title: string;
  cards: CardDef[];
};
