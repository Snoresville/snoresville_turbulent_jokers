<script setup lang="ts">
import { Rarity } from "../types";
import { Rarities, RaritiesShadow } from "../colours";
import { computed } from "vue";

type Props = {
  rarity: Rarity;
};

const { rarity } = defineProps<Props>();
const rarityColour = computed(() => Rarities[rarity]);
const rarityShadowColour = computed(() => RaritiesShadow[rarity]);
</script>

<template>
  <h4
    class="rarity"
    :style="{
      backgroundColor: rarityColour,
      boxShadow: `0px 5px ${rarityShadowColour}`,
    }"
  >
    {{ rarity }}
  </h4>
</template>

<style scoped>
.rarity {
  color: white;
  box-shadow: 0px 5px #030303;

  width: 142px;
  border-radius: 8px;
  padding: 8px;
  font-size: 1.5rem;
  margin: 0;
}
</style>
