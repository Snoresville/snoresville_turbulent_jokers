import { NamedColour, Rarity } from "./types";

type Colour = `#${string}`;

const NamedColours: Record<NamedColour, Colour> = {
    MULT: "#FE5F55",
    CHIPS: "#009dff",
    MONEY: "#f3b958",
    XMULT: "#FE5F55",
    FILTER: "#ff9a00",
    ATTENTION: "#ff9a00",
    BLUE: "#009dff",
    RED: "#FE5F55",
    GREEN: "#4BC292",
    PALE_GREEN: "#56a887",
    ORANGE: "#fda200",
    IMPORTANT: "#ff9a00",
    GOLD: "#eac058",
    YELLOW: "#ffff00",
    CLEAR: "#00000000",
    WHITE: "#ffffff",
    PURPLE: "#8867a5",
    BLACK: "#374244",
    L_BLACK: "#4f6367",
    GREY: "#5f7377",
    CHANCE: "#4BC292",
    JOKER_GREY: "#bfc7d5",
    BOOSTER: "#646eb7",
    DARK_EDITION: "#5d5dff",
    ETERNAL: "#c75985",
    INACTIVE: "#44444499",
    HEARTS: "#f03464",
    DIAMONDS: "#f06b3f",
    SPADES: "#403995",
    CLUBS: "#235955",
    ENHANCED: "#8389DD",
    JOKER: "#708b91",
    TAROT: "#a782d1",
    PLANET: "#13afce",
    SPECTRAL: "#4584fa",
    VOUCHER: "#fd682b",
    EDITION: "#4ca893",
};

const Rarities: Record<Rarity, Colour> = {
    Common: "#009dff",
    Uncommon: "#4BC292",
    Rare: "#fe5f55",
    Legendary: "#b26cbb",
    Joker: "#708b91",
    Tarot: "#a782d1",
    Planet: "#13afce",
    Spectral: "#4584fa",
    Voucher: "#fd682b",
    Pack: "#9bb6bd",
    Enhancement: "#8389DD",
    Edition: "#4ca893",
    Seal: "#4584fa",
    Deck: "#9bb6bd",
    Sticker: "#5d5dff",
    "Boss Blind": "#5d5dff",
    Showdown: "#4584fa",
};

function shadeColor(color: Colour, percent: number): Colour {
    let R = parseInt(color.substring(1, 3), 16);
    let G = parseInt(color.substring(3, 5), 16);
    let B = parseInt(color.substring(5, 7), 16);

    R = (R * (100 + percent)) / 100;
    G = (G * (100 + percent)) / 100;
    B = (B * (100 + percent)) / 100;

    R = R < 255 ? R : 255;
    G = G < 255 ? G : 255;
    B = B < 255 ? B : 255;

    R = Math.round(R);
    G = Math.round(G);
    B = Math.round(B);

    let RR = R.toString(16).length == 1 ? "0" + R.toString(16) : R.toString(16);
    let GG = G.toString(16).length == 1 ? "0" + G.toString(16) : G.toString(16);
    let BB = B.toString(16).length == 1 ? "0" + B.toString(16) : B.toString(16);

    return `#${RR + GG + BB}`;
}

const RaritiesShadow = Object.entries(Rarities).reduce(
    (rarityMap: Record<Rarity, Colour>, rarityEntry) => {
        rarityMap[rarityEntry[0] as Rarity] = shadeColor(rarityEntry[1], -20);
        return rarityMap;
    },
    {} as Record<Rarity, Colour>
);

export { type Colour, NamedColours, Rarities, RaritiesShadow };
