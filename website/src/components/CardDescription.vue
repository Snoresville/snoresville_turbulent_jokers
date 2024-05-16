<script setup lang="ts">
import { computed } from "vue";
import { formatDescription } from "../util";

const { text } = defineProps<{
    text: string[];
}>();

const formatted = computed(() => formatDescription(text));
</script>

<template>
    <div class="card-text-box">
        <div class="card-text" v-for="t of formatted" v-html="t"></div>
    </div>
</template>

<style scoped>
.card-text-box {
    --card-desc-background-colour: #ffffff;
    --card-desc-stripe-colour: #f0f0f0;
    --card-desc-stripe-gap: 8px;
    --card-desc-stripe-width: 8px;

    width: 240px;
    background: repeating-linear-gradient(
        var(--card-desc-background-colour),
        var(--card-desc-background-colour) var(--card-desc-stripe-gap),
        var(--card-desc-stripe-colour) var(--card-desc-stripe-gap),
        var(--card-desc-stripe-colour)
            calc(var(--card-desc-stripe-gap) + var(--card-desc-stripe-width))
    );
    font-size: 1.4rem;
    padding: 10px;

    border-radius: 8px;
    box-shadow: 0px 4px rgb(133, 133, 133);
}

.card-text {
    color: black;
    text-shadow: none;
}
</style>
