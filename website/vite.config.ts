import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
    base: "/snoresville_turbulent_jokers/",
    plugins: [vue()],
    resolve: {
        alias: [],
    },
});
