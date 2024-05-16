<script setup lang="ts">
import { CardImageDef } from "../types";

const { image } = defineProps<{ name: string; image: CardImageDef }>();
</script>

<template>
  <div class="card-image-container">
    <img class="card-image" :src="image.image_url" :alt="name" />
    <div v-if="image.soul_url" class="card-soul-resize">
      <img class="card-soul-image card-soul-rotate" :src="image.soul_url" />
    </div>
  </div>
</template>

<style scoped>
.card-image-container {
  position: relative;
}
.card-image {
  width: 142px;
  height: 190px;
  top: 0;
  left: 0;
}

.card-soul-image {
  position: absolute;
  width: 142px;
  height: 190px;
  top: 0;
  left: 0;
}

.card-soul-resize {
  position: absolute;
  top: 0;
  left: 0;
  animation: soul-resize 3s ease-in-out infinite alternate;
}

.card-soul-rotate {
  animation: soul-rotate 4s ease-in-out infinite alternate;
}

@keyframes soul-rotate {
  from {
    transform: rotateZ(-5deg);
  }
  to {
    transform: rotateZ(5deg);
  }
}
@keyframes soul-resize {
  from {
    transform: scale(0.95);
  }
  to {
    transform: scale(1.05);
  }
}
</style>
