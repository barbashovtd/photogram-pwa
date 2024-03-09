<template>
  <q-layout view="hHh lpR fFf">
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

    <q-drawer
      :overlay="false"
      v-model="leftDrawerOpen"
      :width="400"
      side="left"
      class="left-menu"
    >
      <PhotoGallery />
      <q-list padding bordered>
        <EssentialLink
          v-for="(mesh, index) in modelsList"
          :key="index"
          :meshModel="mesh"
        />
      </q-list>
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
import { useQuasar } from "quasar";

const $q = useQuasar();
const isMobile = $q.platform.is.mobile;

const modelsList = ref(null);

onMounted(async () => {
  const response = await api.get("models/");
  modelsList.value = response.data;
});

const qDrawerWidth = computed(() => window.width * 0.5);

const leftDrawerOpen = ref(false);
function toggleLeftDrawer() {
  leftDrawerOpen.value = !leftDrawerOpen.value;
}
</script>
<!-- <style>
.left-menu {
  background-color: transparent;
}
.mesh-list {
  background-color: #187adc;
  color: #eaeaea;
  border: 3;
  /* border-radius: 50; */
  border-color: #0c64bc;
}
.rounded {
  border-radius: 50px;
}
.qheader {
  /* border-radius: 50; */
  width: 90%;
  align-content: center;
}
.q-separator {
  color: #eaeaea;
}
</style> -->
