<script setup lang="ts">
import { CardDef } from "../types";
import CardRarity from "./CardRarity.vue";
import CardImage from "./CardImage.vue";
import CardDescription from "./CardDescription.vue";

const { name, text, rarity, image } = defineProps<CardDef>();
</script>

<template>
  <div class="card">
    <div class="card-title">
      {{ name }}
    </div>
    <CardImage :name="name" :image="image" />
    <CardDescription :text="text" />
    <CardRarity :rarity="rarity" />
  </div>
</template>

<style scoped>
.card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  padding-bottom: 1.5rem;
  margin-bottom: auto;

  background-color: #374244;
  border-radius: 1rem;
  border: 4px solid white;
  box-shadow: 0px 4px rgb(133, 133, 133);
}

.card-title {
  font-size: 2rem;
}

.card-text {
  color: white;
}
</style>
