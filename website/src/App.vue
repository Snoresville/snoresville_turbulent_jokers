<script setup lang="ts">
import WebIntro from "./components/WebIntro.vue";
import Links from "./components/Links.vue";
import CardSection from "./components/CardSection.vue";
import Credits from "./components/Credits.vue";

import JOKERS from "./content/jokers";
import CONSUMABLES from "./content/consumables";
import CARD_MODIFIERS from "./content/card_modifiers";
import DECKS from "./content/decks";
import STICKERS from "./content/stickers";
import BLINDS from "./content/blinds";
import SHOP_ITEMS from "./content/shop_items";
</script>

<template>
  <WebIntro />
  <Links />
  <CardSection v-if="JOKERS.length > 0" title="Jokers" :cards="JOKERS" />
  <CardSection
    v-if="CONSUMABLES.length > 0"
    title="Consumables"
    :cards="CONSUMABLES"
  />
  <CardSection
    v-if="CARD_MODIFIERS.length > 0"
    title="Card Modifiers"
    :cards="CARD_MODIFIERS"
  />
  <CardSection v-if="DECKS.length > 0" title="Decks" :cards="DECKS" />
  <CardSection v-if="STICKERS.length > 0" title="Stickers" :cards="STICKERS" />
  <CardSection v-if="BLINDS.length > 0" title="Blinds" :cards="BLINDS" />
  <CardSection
    v-if="SHOP_ITEMS.length > 0"
    title="Shop Items"
    :cards="SHOP_ITEMS"
  />
  <Credits />
</template>

<style scoped></style>
