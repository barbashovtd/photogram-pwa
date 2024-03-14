<template>
  <q-item clickable v-ripple @click="changeCurrentMesh" :active="isActiveItem">
    <q-item-section>
      <q-item-label>{{ meshModel.name }}</q-item-label>
      <q-item-label caption lines="1">{{
        captionDate(meshModel.date_created)
      }}</q-item-label>
    </q-item-section>
  </q-item>
</template>

<script setup>
import { ref } from "vue";
import { useMeshStore } from "src/stores/meshStore";
import { MutationType } from "pinia";

const props = defineProps({
  meshModel: {
    name: {
      type: String,
      required: true,
    },
    mesh: {
      type: String,
    },
    date_created: { type: String },
  },
});

const meshStore = useMeshStore();

const isActiveItem = ref(false);

meshStore.$subscribe((mutation, state) => {
  if (mutation.type == MutationType.patchObject) {
    isActiveItem.value = isCurrentMesh();
  }
});

function isCurrentMesh() {
  return meshStore.name == props.meshModel.name;
}

const changeCurrentMesh = () => {
  if (!isCurrentMesh()) {
    meshStore.$patch(props.meshModel);
  }
  isActiveItem.value = isCurrentMesh();
};

function captionDate(date) {
  const d = new Date(date);
  return `${d.getDay()}.${d.getMonth()}.${d.getFullYear()}`;
}
</script>
