<script setup lang="ts">
import { LINK_BUTTONS } from "../config/links";
</script>

<template>
  <div class="downloads-container">
    <h2 class="download-title">Downloads</h2>
    <div class="download-links">
      <a
        class="download-button"
        v-for="b in LINK_BUTTONS"
        :href="b.link"
        target="_blank"
      >
        {{ b.name }}
      </a>
    </div>
  </div>
</template>

<style scoped>
.downloads-container {
  margin-bottom: 2rem;
}

.download-title {
  margin: 10px;
}

.download-links {
  display: flex;
  flex-direction: row;

  justify-content: center;
  gap: 1rem;
}

.download-button {
  font-size: 1.5rem;
  color: #374244;
  text-shadow: none;
  text-decoration: none;

  background-color: white;
  border-radius: 1rem;
  border: 4px solid white;
  box-shadow: 0px 4px rgb(133, 133, 133);
  padding: 1rem;
}

.download-button:hover {
  color: white;
  background-color: #374244;
  text-shadow: #000 2px 2px 2px;
}
</style>
../content/mod_links ../config/links
