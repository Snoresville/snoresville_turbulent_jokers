import { CardDef, Rarity } from "../types";

const JOKERS: CardDef[] = [
    {
        name: "Bazinga",
        text: [
            "{X:mult,C:white}X1{} Mult, {C:green}1 in 16{} chance to destroy all Jokers after playing a {C:blue}hand{}",
            "Increase by {X:mult,C:white}X1{} and {C:green}1 in 16{} chance after each {C:blue}hand{}",
        ],
        image: { image_url: "img/j_snoresville_bazinga.png" },
        rarity: "Common",
    },
    {
        name: "Bombsite Rusher",
        text: [
            "If this Joker is on the left half of owned Jokers, this scores {C:chips}Chips{}, otherwise it scores {C:mult}Mult{}",
            "Spend up to {C:money}$4{} at the start of each blind to gain {C:chips}+5{} Chips or {C:mult}+2{} Mult per {C:money}$1{}",
            "{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)",
        ],
        image: { image_url: "img/j_snoresville_1337_krew.png" },
        rarity: "Common",
    },
    {
        name: "Bug",
        text: [
            "Fixed {C:green}1 in 64{} chance to appear, does not require free space",
        ],
        image: { image_url: "img/j_snoresville_bug.png" },
        rarity: "Common",
    },
    {
        name: "Brick Wall",
        text: [
            "Add {C:attention}20%{} of the remaining required {C:blue}chips{} at the start of a blind",
        ],
        image: { image_url: "img/j_snoresville_brick_wall.png" },
        rarity: "Common",
    },
    {
        name: "Edgeworth",
        text: [
            "You can only win a blind at zero {C:blue}hands{} remaining",
            "Gain {C:money}$1{} if you would win",
        ],
        image: { image_url: "img/j_snoresville_edgeworth.png" },
        rarity: "Uncommon",
    },
    {
        name: "Emergence",
        text: [
            "If a scoring card is not a {C:red}Red Seal{} {C:dark_edition}Polychrome{} {C:inactive}Steel{} {C:hearts}King of Hearts{}, partially transform the card towards it, {C:green}1 in 8{} chance of breaking the card instead.",
        ],
        image: { image_url: "img/j_snoresville_emergence.png" },
        rarity: "Common",
    },
    {
        name: "Engineer",
        text: [
            "At the beginning of a blind, build or upgrade a {C:attention}Sentry Gun{}",
            "The Sentry Gun {C:attention}inherits{} the Engineer's {C:dark_edition}edition{}",
            "{C:inactive}(Must have room to build){}",
        ],
        image: { image_url: "img/j_snoresville_engineer.png" },
        rarity: "Uncommon",
    },
    {
        name: "Logistics",
        text: [
            "Apply the sum of {C:attention}after-hand{} {C:blue}Joker {C:red}Bonuses{} every time a card is scored",
        ],
        image: { image_url: "img/j_snoresville_logistics.png" },
        rarity: "Rare",
    },
    {
        name: "Field Doctor",
        text: [
            "At the start of a blind, gain extra hands based on {C:blue}50%{} of the base hands, rounded up",
        ],
        image: { image_url: "img/j_snoresville_medic.png" },
        rarity: "Common",
    },
    {
        name: "Milky Way",
        text: [
            "When playing a hand, set the played poker hand's {C:attention}level{} equal to the {C:attention}sum of all other poker hands' levels + 1{} contained in the full hand.",
        ],
        image: { image_url: "img/j_snoresville_milky_way.png" },
        rarity: "Rare",
    },
    {
        name: "Ordered Library",
        text: [
            "Whenever possible, you will draw cards of {C:attention}unique rank{}",
        ],
        image: { image_url: "img/j_snoresville_neat_library.png" },
        rarity: "Uncommon",
    },
    {
        name: "Negative Joker",
        text: ["{C:red}-4{} Mult,", "{C:dark_edition}+1{} Joker slot"],
        image: { image_url: "img/j_snoresville_negative_joker.png" },
        rarity: "Common",
    },
    {
        name: "Mr. Hands",
        text: [
            "{C:attention}Draw your entire deck{} into your hand at the start of the blind",
        ],
        image: {
            image_url: "img/j_snoresville_mr_hands_bg.png",
            soul_url: "img/j_snoresville_mr_hands_soul.png",
        },
        rarity: "Legendary",
    },
    {
        name: "Pi",
        text: [
            "This Joker gains {X:mult,C:white}X0.1{} Mult every time a scored card's rank matches the next rank of Pi",
            "Next ranks are: {C:attention}3, Ace, 4, Ace, 5{}",
            "{C:inactive}(Currently {X:mult,C:white}X1{C:inactive} Mult)",
        ],
        image: { image_url: "img/j_snoresville_pi.png" },
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
        image: { image_url: "img/j_snoresville_protagonist.png" },
        rarity: "Uncommon",
    },
    {
        name: "Tag Team",
        text: [
            "{C:green}1 in 4 chance{} to gain a {C:attention}Double Tag{} for every {C:attention}two cards{} of the {C:attention}same rank{} contained in a played hand",
        ],
        image: { image_url: "img/j_snoresville_tag_team.png" },
        rarity: "Rare",
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
        image: { image_url: "img/j_snoresville_seasonings.png" },
        rarity: "Common",
    },
    {
        name: "True Gamer",
        text: [
            "At the start of a blind, fight all {C:attention}True Gamer{}s, and double the {C:blue}Chips{} scored for each {C:attention}True Gamer{} beaten",
            "{C:inactive}(Currently {C:blue}+25 Chips{C:inactive})",
        ],
        image: { image_url: "img/j_snoresville_true_gamer.png" },
        rarity: "Common",
    },
    {
        name: "Sentry Gun",
        text: [
            "Retrigger a scoring card for each upgrade this Joker has",
            "{X:mult,C:white}Inactive! Engineer must be owned!{}",
            "{C:inactive}(Currently has {C:attention}1{C:inactive} upgrades)",
        ],
        image: { image_url: "img/j_snoresville_sentry_gun.png" },
        rarity: "Uncommon",
    },
    {
        name: "Vault",
        text: [
            "After every hand played, increase this Joker's sell price by {C:attention}2%{}, rounded up",
            "{C:inactive}(Current interest: {C:money}$1{C:inactive})",
        ],
        image: { image_url: "img/j_snoresville_vault.png" },
        rarity: "Uncommon",
    },
    {
        name: "The Blunt",
        text: [
            "Unscored cards are fed into {C:green}The Blunt{}.",
            "Adds {C:blue}Chips{} and {C:red}Mult{} every time a card is scored in {C:attention}High Card{} hands.",
            "{C:inactive}(Currently {C:blue}+10 Chips{C:inactive} and {C:red}+1 Mult{C:inactive})",
        ],
        image: { image_url: "img/j_snoresville_the_blunt.png" },
        rarity: "Rare",
    },
    {
        name: "Cyka Balatro",
        text: [
            "On each {C:blue}hand{} played, gamble {C:money}$1{} to gain the following:",
            "{C:green}1 in 5{} chance to score {C:mult}+20{} Mult",
            "{C:green}1 in 15{} chance to win {C:money}$20{}",
        ],
        image: { image_url: "img/j_snoresville_cyka_balatro.png" },
        rarity: "Common",
    },
];

const rarityValue: Partial<Record<Rarity, number>> = {
    Common: 1,
    Uncommon: 2,
    Rare: 3,
    Legendary: 4,
};

const sortFunction = (a: CardDef, b: CardDef) => {
    const rarityA = rarityValue[a.rarity];
    const rarityB = rarityValue[b.rarity];
    if (rarityA && rarityB && rarityA != rarityB) {
        return rarityA - rarityB;
    }

    return a.name < b.name ? -1 : 1;
};

JOKERS.sort(sortFunction);

export default JOKERS;
