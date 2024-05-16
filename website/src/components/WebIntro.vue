<script setup lang="ts">
import INTRODUCTION from "../config/introduction.ts";
</script>

<template>
  <div class="mod-intro-container">
    <img
      v-if="INTRODUCTION.logo !== undefined && INTRODUCTION.logo != ''"
      :src="INTRODUCTION.logo"
    />
    <h1 v-if="INTRODUCTION.title !== undefined" class="mod-title">
      {{ INTRODUCTION.title }}
    </h1>
    <div class="mod-description">
      <div v-for="d in INTRODUCTION.description">
        {{ d }}
      </div>
    </div>
  </div>
</template>

<style scoped>
.mod-intro-container {
  margin-bottom: 2rem;
}
.mod-title {
  font-size: 4rem;
  margin: 1.4rem;
}
.mod-description {
  font-size: 2rem;
}
</style>
