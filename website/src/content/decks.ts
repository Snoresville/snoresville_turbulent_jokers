import { CardDef } from "../types";

const DECKS: CardDef[] = [
    {
        name: "Ethereal Vault",
        text: [
            "Start with an {C:attention}Eternal {C:dark_edition}Negative{C:attention} Vault",
        ],
        image: { image_url: "img/b_snoresville_ethereal_vault.png" },
        rarity: "Deck",
    },
    {
        name: "High Deck",
        text: [
            "Start with an {C:attention}Eternal {C:dark_edition}Polychrome Blunt",
        ],
        image: { image_url: "img/b_snoresville_high_deck.png" },
        rarity: "Deck",
    },
    {
        name: "Metamorphosis Deck",
        text: [
            "Start with an {C:attention}Eternal{} {C:dark_edition}Negative{} {C:attention}Emergence{}, and a Deck full of {C:attention}Ace of Spades{}",
        ],
        image: { image_url: "img/b_snoresville_metamorphosis.png" },
        rarity: "Deck",
    },
    {
        name: "Pi Delivery",
        text: [
            "Start with an {C:attention}Eternal Pi{} and an {C:attention}Eternal Logistics",
        ],
        image: { image_url: "img/b_snoresville_pi_delivery.png" },
        rarity: "Deck",
    },
    {
        name: "Shortcut to Library",
        text: [
            "Start with a {C:attention}Eternal Shortcut{} and an {C:attention}Eternal Ordered Library{}",
        ],
        image: { image_url: "img/b_snoresville_shortcut_to_library.png" },
        rarity: "Deck",
    },
    {
        name: "Tag Fanatics",
        text: ["Start with 5 {C:attention}Eternal{} Tag Teams"],
        image: { image_url: "img/b_snoresville_tag_fanatics.png" },
        rarity: "Deck",
    },
    {
        name: "Gamer's Journey",
        text: [
            "Start with 4 {C:attention}True Gamer{}s, and a {C:attention}Showman",
        ],
        image: { image_url: "img/b_snoresville_ultimate_gamer.png" },
        rarity: "Deck",
    },
];

DECKS.sort((a, b) => {
    return a.name < b.name ? -1 : 1;
});

export default DECKS;
