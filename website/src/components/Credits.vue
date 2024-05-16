<script setup lang="ts">
import CREDITS from "../config/credits";
</script>

<template>
    <div class="template-container credits-container">
        <h2>Credits</h2>
        <div v-for="c in CREDITS" class="credit">
            <h3 class="credit-person">{{ c.person }}</h3>
            <div class="credit-description" v-html="c.description"></div>
        </div>
    </div>
</template>

<style scoped>
.credits-container {
    margin: 20px auto;
    max-width: 550px;
}

.credit {
    padding: 10px;
    margin-bottom: 20px;
    background-color: rgb(109, 109, 109);
}

.credit-person {
    margin: 0;
    margin-bottom: 5px;
}

.credit-description {
    font-size: 1.5rem;
    color: darkgray;
}
</style>
