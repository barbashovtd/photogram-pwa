<template>
  <q-layout view="hHh lpR lFf">
    <q-header
      reveal
      elevated
      bordered
      class="shadow-up-1 qheader rounded-borders"
    >
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />
        <q-toolbar-title> Photogram </q-toolbar-title>
      </q-toolbar>
    </q-header>

    <q-drawer :overlay="true" v-model="leftDrawerOpen" :width="400" side="left">
      <PhotoGallery />
      <q-card>
        <q-list padding bordered>
          <EssentialLink
            v-for="(mesh, index) in modelsList"
            :key="index"
            :meshModel="mesh"
          />
        </q-list>
      </q-card>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { computed, ref, onMounted } from "vue";
import EssentialLink from "components/EssentialLink.vue";
import PhotoGallery from "components/PhotoGallery.vue";
import { api } from "src/boot/axios";
import { useMeshStore } from "src/stores/meshStore";
import { MutationType } from "pinia";

const modelsList = ref(null);

onMounted(async () => {
  const response = await api.get("models/");
  modelsList.value = response.data;
});

const meshStore = useMeshStore();

meshStore.$subscribe((mutation, state) => {
  if (mutation.type === MutationType.patchObject) {
    async () => {
      const response = await api.get("models/");
      modelsList.value = response.data;
    };
  }
});

const qDrawerWidth = computed(() => window.width * 0.5);

const leftDrawerOpen = ref(true);
function toggleLeftDrawer() {
  leftDrawerOpen.value = !leftDrawerOpen.value;
}
</script>
<style lang="scss">
.q-drawer {
  background: transparent;
  padding-top: 1rem;
  padding-left: 1rem;
}
.q-item__label {
  color: #eaeaea;
}
.q-item__label--caption {
  color: #c1c1c1;
}
</style>
