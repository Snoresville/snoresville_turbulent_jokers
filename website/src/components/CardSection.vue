<script setup lang="ts">
import Card from "./Card.vue";
import { CardSectionProps } from "../types";

const { title, cards } = defineProps<CardSectionProps>();
</script>

<template>
    <h3 class="card-section-title">
        {{ title }}
    </h3>
    <div class="card-section">
        <Card
            v-for="c in cards"
            :name="c.name"
            :text="c.text"
            :rarity="c.rarity"
            :image="c.image"
        />
    </div>
</template>

<style scoped>
.card-section-title {
    margin-bottom: 1rem;
}

.card-section {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    gap: 1rem;
    overflow: visible;
    justify-content: center;

    /* width: min(100vw, 1470px); */
    margin: 0 auto;
}
</style>
