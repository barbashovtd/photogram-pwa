<template>
  <!-- <q-card class="shadow-3 uploader">
    <q-card-section> -->
  <q-card class="card">
    <q-form @submit="uploadGallery" class="justify-center q-pa-md">
      <q-input
        placeholder=" Имя модели"
        v-model="galleryName"
        type="text"
        class="row"
        :rules="[
          (val) => !!val || 'Обязательное поле',
          (val) => val != '404' || 'Имя уже используется',
        ]"
        lazy-rules
      />
      <div class="row justify-center">
        <q-uploader
          ref="uploader"
          :url="apiUploadURL"
          :form-fields="[{ name: 'gallery', value: galleryName }]"
          accept="image/*"
          max-total-size="104857600"
          max-files="20"
          label="Фото"
          text-color="#eaeaea"
          no-thumbnails
          multiple
          hide-upload-btn
          flat
        />
        <div class="row justify-center">
          <q-btn label="Создать" type="submit" flat />
        </div>
      </div>
    </q-form>
  </q-card>
  <!-- </q-card-section>
  </q-card> -->
</template>

<script setup>
import axios, { api } from "src/boot/axios";
import { ref } from "vue";
import { useMeshStore } from "src/stores/meshStore";
const apiUploadURL = process.env.API_BASE + "/image/";
const galleryUploadURL = process.env.API_BASE + "/gallery/";

const galleryName = ref("");
const uploader = ref(null);
const meshStore = useMeshStore();

function uploadFactory(files) {
  return {
    url: apiUploadURL,
    method: "POST",
  };
}

async function uploadGallery() {
  const created = await api.post("/gallery/", { name: galleryName.value });
  if (created) {
    const uploaded = await uploader.value.upload();
    const modelCreated = await api.post("/model/", {
      name: galleryName.value,
    });
    meshStore.$patch({ name: modelCreated.name, mesh: modelCreated.mesh });
  }
}
</script>

<style lang="scss">
.card {
  background-color: $primary;
  .q-btn {
    color: #eaeaea;
  }
}
</style>
