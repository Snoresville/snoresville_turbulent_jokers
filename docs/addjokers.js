let jokers = [
    {
        name: "Brick Wall",
        text: [
            "Add {C:attention}20%{} of the",
            "remaining required {C:blue}chips{}",
            "at the start of a blind",
        ],
        image_url: "img/j_snoresville_brick_wall.png",
        rarity: "Common",
    },
    {
        name: "Emergence",
        text: [
            "If a scoring card is not a",
            "{C:red}Red Seal{} {C:dark_edition}Polychrome{} {C:attention}Steel{} {C:hearts}King of Hearts{},",
            "partially transform the card towards it,",
            "{C:green}1 in 8{} chance of breaking the card instead.",
        ],
        image_url: "img/j_snoresville_emergence.png",
        rarity: "Common",
    },
    {
        name: "Field Doctor",
        text: [
            "At the start of a blind,",
            "gain extra hands based on",
            "{C:blue}50%{} of the base hands,",
            "rounded up",
        ],
        image_url: "img/j_snoresville_medic.png",
        rarity: "Common",
    },
    {
        name: "Negative Joker",
        text: ["{C:red}+4{} Mult,", "{C:dark_edition}+1{} Joker slot"],
        image_url: "img/j_snoresville_negative_joker.png",
        rarity: "Common",
    },
    {
        name: "Seasonings",
        text: [
            "When a card is scored,",
            "give a random card in hand either",
            "{C:blue}+2 chips, {C:red}+0.5 Mult,",
            "{X:mult,C:white}+X0.1{C:red} Mult, {X:mult,C:white}+X0.05{C:red} Hand Mult,",
            "or {C:money}+$1 on score{}",
        ],
        image_url: "img/j_snoresville_seasonings.png",
        rarity: "Common",
    },
    {
        name: "True Gamer",
        text: [
            "At the start of a blind,",
            "fight all {C:attention}True Gamer{}s,",
            "and double the {C:blue}Chips{} scored",
            "for each {C:attention}True Gamer{} beaten",
            "{C:inactive}(Currently {C:blue}+25 Chips{C:inactive})",
        ],
        image_url: "img/j_snoresville_true_gamer.png",
        rarity: "Common",
    },
    {
        name: "Ordered Library",
        text: [
            "Whenever possible, you will",
            "draw cards of {C:attention}unique rank{}",
        ],
        image_url: "img/j_snoresville_neat_library.png",
        rarity: "Uncommon",
    },
    {
        name: "Pi",
        text: [
            "This Joker gains {X:mult,C:white}X0.2{} Mult",
            "every time a scored card's rank",
            "matches the next rank of Pi.",
            "Next ranks are: {C:attention}3, Ace, 4, Ace, 5{}",
            "{C:inactive}(Currently {X:mult,C:white}X1{C:inactive} Mult)",
        ],
        image_url: "img/j_snoresville_pi.png",
        rarity: "Uncommon",
    },
    {
        name: "Protagonist",
        text: [
            "Count other Jokers as {X:mult,C:white}X0.8{} Mult.",
            "Total the left and right sides separately",
            "and {C:attention}multiply{} them together. Score that amount.",
            "{C:inactive}(Currently {X:mult,C:white}X0{C:inactive} Mult)",
        ],
        image_url: "img/j_snoresville_protagonist.png",
        rarity: "Uncommon",
    },
    {
        name: "Tag Team",
        text: [
            "{C:green}1 in 2 chance{} to",
            "gain a {C:attention}Double Tag{} for every",
            "{C:attention}two cards{} of the {C:attention}same rank{}",
            "contained in a played hand",
        ],
        image_url: "img/j_snoresville_tag_team.png",
        rarity: "Uncommon",
    },
    {
        name: "Vault",
        text: [
            "After every hand played,",
            "increase this Joker's sell price",
            "by {C:attention}2%{}, rounded up",
            "{C:inactive}(Current interest: {C:money}$1{C:inactive})",
        ],
        image_url: "img/j_snoresville_vault.png",
        rarity: "Uncommon",
    },
    {
        name: "Logistics",
        text: [
            "Apply the sum of",
            "{C:attention}after-hand{} {C:blue}Joker {C:red}Bonuses{}",
            "every time a card is scored",
        ],
        image_url: "img/j_snoresville_logistics.png",
        rarity: "Rare",
    },
    {
        name: "Milky Way",
        text: [
            "When playing a hand, set the",
            "played poker hand's {C:attention}level{} equal to the ",
            "{C:attention}sum of all other poker hands' levels + 1{}",
            "contained in the full hand.",
        ],
        image_url: "img/j_snoresville_milky_way.png",
        rarity: "Rare",
    },
    {
        name: "The Blunt",
        text: [
            "Unscored cards are fed into {C:green}The Blunt{}.",
            "Adds {C:blue}Chips{} and {C:red}Mult{} everytime",
            "a card is scored in {C:attention}High Card{} hands.",
            "{C:inactive}(Currently {C:blue}+10 Chips{C:inactive} and {C:red}+1 Mult{C:inactive})",
        ],
        image_url: "img/j_snoresville_the_blunt.png",
        rarity: "Rare",
    },
    {
        name: "Mr. Hands",
        text: [
            "{C:attention}Draw your entire deck{}",
            "into your hand",
            "at the start of the blind",
        ],
        image_url: "img/j_snoresville_mr_hands.png",
        rarity: "Legendary",
    },
];

// works the same.
let consumables = [
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/j_joker.png",
    //   rarity: "Tarot"
    // },
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/j_joker.png",
    //   rarity: "Planet"
    // },
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/j_joker.png",
    //   rarity: "Spectral"
    // },
];

let card_modifications = [
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/j_joker.png",
    //   rarity: "Enhancement"
    // },
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/j_joker.png",
    //   rarity: "Edition"
    // },
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/sticker_example.png",
    //   rarity: "Seal"
    // },
];

let decks = [
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/j_joker.png",
    //   rarity: "Deck"
    // },
];

let stickers = [
    // {
    //   name: "Joker",
    //   text: [
    //     "{C:mult}+4{} Mult"
    //   ],
    //   image_url: "img/sticker_example.png",
    //   rarity: "Sticker"
    // },
];

let blinds = [
    // {
    //   name: "The Wall",
    //   text: [
    //     "Extra large blind",
    //     "{C:inactive}({C:red}4x{C:inactive} Base for {C:attention}$$$$${C:inactive})",
    //     "{C:inactive}(Appears from Ante 2)"
    //   ],
    //   image_url: "img/the_wall.png",
    //   rarity: "Boss Blind"
    // },
    // {
    //   name: "Violet Vessel",
    //   text: [
    //     "Very large blind",
    //     "{C:inactive}({C:red}6x{C:inactive} Base for {C:attention}$$$$$$$${C:inactive})",
    //     "{C:inactive}(Appears from Ante 8)"
    //   ],
    //   image_url: "img/violet_vessel.png",
    //   rarity: "Showdown"
    // },
];

let shop_items = [
    // {
    //     name: "Joker",
    //     text: ["{C:mult}+4{} Mult"],
    //     image_url: "img/j_joker.png",
    //     rarity: "Voucher",
    // },
    // {
    //     name: "Joker",
    //     text: ["{C:mult}+4{} Mult"],
    //     image_url: "img/j_joker.png",
    //     rarity: "Pack",
    // },
];

let cols = {
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
    VOUCHER: "#cb724c",
    BOOSTER: "#646eb7",
    EDITION: "#ffffff",
    DARK_EDITION: "#5d5dff",
    ETERNAL: "#c75985",
    INACTIVE: "#ffffff99",
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

let rarities = {
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

regex = /{([^}]+)}/g;

let add_cards_to_div = (jokers, jokers_div) => {
    for (let joker of jokers) {
        console.log("adding joker", joker.name);

        joker.text = joker.text.map((line) => {
            return line + "{}";
        });

        joker.text = joker.text.join("<br/>");
        joker.text = joker.text.replaceAll("{}", "</span>");
        joker.text = joker.text.replace(
            regex,
            function replacer(match, p1, offset, string, groups) {
                let classes = p1.split(",");

                let css_styling = "";

                for (let i = 0; i < classes.length; i++) {
                    let parts = classes[i].split(":");
                    if (parts[0] === "C") {
                        css_styling += `color: ${
                            cols[parts[1].toUpperCase()]
                        };`;
                    } else if (parts[0] === "X") {
                        css_styling += `background-color: ${
                            cols[parts[1].toUpperCase()]
                        }; border-radius: 5px; padding: 0 5px;`;
                    }
                }

                return `</span><span style='${css_styling}'>`;
            }
        );

        let joker_div = document.createElement("div");
        joker_div.classList.add("joker");
        if (joker.rarity === "Sticker" || joker.rarity == "Seal") {
            joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" class="hasback" />
        <h4 class="rarity" style="background-color: ${
            rarities[joker.rarity]
        }">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
        } else if (joker.soul) {
            joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <span class="soulholder">
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-bg" />
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-top" />
        </span>
        <h4 class="rarity" style="background-color: ${
            rarities[joker.rarity]
        }">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
        } else {
            joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" />
        <h4 class="rarity" style="background-color: ${
            rarities[joker.rarity]
        }">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
        }

        jokers_div.appendChild(joker_div);
    }
};

if (jokers.length === 0) {
    document.querySelector(".jokersfull").style.display = "none";
} else {
    let jokers_div = document.querySelector(".jokers");
    add_cards_to_div(jokers, jokers_div);
}

if (consumables.length === 0) {
    document.querySelector(".consumablesfull").style.display = "none";
} else {
    let consumables_div = document.querySelector(".consumables");
    add_cards_to_div(consumables, consumables_div);
}

if (card_modifications.length === 0) {
    document.querySelector(".cardmodsfull").style.display = "none";
} else {
    let cardmods_div = document.querySelector(".cardmods");
    add_cards_to_div(card_modifications, cardmods_div);
}

if (decks.length === 0) {
    document.querySelector(".decksfull").style.display = "none";
} else {
    let decks_div = document.querySelector(".decks");
    add_cards_to_div(decks, decks_div);
}

if (stickers.length === 0) {
    document.querySelector(".stickersfull").style.display = "none";
} else {
    let stickers_div = document.querySelector(".stickers");
    add_cards_to_div(stickers, stickers_div);
}

if (blinds.length === 0) {
    document.querySelector(".blindsfull").style.display = "none";
} else {
    let blinds_div = document.querySelector(".blinds");
    add_cards_to_div(blinds, blinds_div);
}

if (shop_items.length === 0) {
    document.querySelector(".shopitemsfull").style.display = "none";
} else {
    let shopitems_div = document.querySelector(".shopitems");
    add_cards_to_div(shop_items, shopitems_div);
}
