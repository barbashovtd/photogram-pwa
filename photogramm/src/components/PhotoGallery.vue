<template>
  <!-- <q-card class="shadow-3 uploader">
    <q-card-section> -->
  <q-form @submit="uploadGallery">
    <q-input
      placeholder=" Имя модели"
      v-model="galleryName"
      class="row justify-center"
      type="text"
      :rules="[(val) => !!val || 'Обязательное поле']"
    />
    <div class="row justify-center">
      <q-uploader
        ref="uploader"
        :url="apiUploadURL"
        :form-fields="[{ name: 'gallery', value: galleryName }]"
        accept="image/*"
        max-total-size="104857600"
        label="Фото"
        text-color="#eaeaea"
        bordered
        no-thumbnails
        multiple
        hide-upload-btn
      />
    </div>
    <div class="row justify-center">
      <q-btn label="Создать" type="submit" />
      <!-- class="q-ma-md" /> -->
    </div>
  </q-form>
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

function uploadFactory(files) {
  return {
    url: apiUploadURL,
    method: "POST",
  };
}
// Кнопка на создание модели, по ней MeshModelCreate на API, запуск meshroom

async function uploadGallery() {
  const created = await api.post("/gallery/", { name: galleryName.value });
  if (created) {
    const uploaded = await uploader.value.upload();
    const modelCreated = await api.post("/model/", {
      name: galleryName.value,
    });
  }
}
</script>

<!-- <style>
.uploader {
  background-color: #187adc;
  border-radius: 50;
  border-color: #0c64bc;
  width: auto;
}
</style> -->
