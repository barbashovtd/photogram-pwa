<template>
  <q-page class="flex flex-center">
    <!-- <q-no-ssr> -->
    <!-- <Suspense> -->
    <MeshRender />
    <!-- </Suspense> -->
    <!-- </q-no-ssr> -->
  </q-page>
</template>

<script setup>
// import { defineComponent } from "vue";
import { ref } from "vue";
import MeshRender from "components/MeshRender.vue";
// import { api } from "boot/axios";

// const isOk = api
//   .get("/models/1")
//   .then((response) => {
//     model.value = response.data;
//   })
//   .catch(() => {
//     model.value.mesh = "~assets/404.glb";
//   });

// export default defineComponent({
//   name: "IndexPage",
// });
</script>
