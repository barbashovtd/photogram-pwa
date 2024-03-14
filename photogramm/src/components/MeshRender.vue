<template>
  <TresCanvas v-bind="gl" window-size>
    <TresPerspectiveCamera :position="[4, 2, 4]" />
    <OrbitControls make-default />
    <Suspense>
      <CurrentMesh :mesh="meshStore.mesh" :key="meshStore.name" />
    </Suspense>
    <!-- <GLTFModel :path="meshStore.mesh" :key="meshStore.name" draco /> -->
    <TresDirectionalLight :position="[2, 2, 2]" :intensity="1" cast-shadow />
  </TresCanvas>
</template>

<script lang="ts" setup>
import { Suspense, defineProps, shallowRef, ref } from "vue";
import { TresCanvas, useRenderLoop } from "@tresjs/core";
import { OrbitControls, TransformControls } from "@tresjs/cientos";
import { BasicShadowMap, SRGBColorSpace, NoToneMapping } from "three";
import { useMeshStore } from "stores/meshStore";
import CurrentMesh from "./CurrentMesh.vue";

const meshStore = useMeshStore();

const gl = {
  clearColor: "#e7e7e7",
  shadows: true,
  alpha: false,
  shadowMapType: BasicShadowMap,
  outputColorSpace: SRGBColorSpace,
  toneMapping: NoToneMapping,
};

const isAutoRotating = ref(false);
const is404Model = () => {
  isAutoRotating.value = meshStore.name == "404";
};
// const camera = {x:4, y:2, z:4};
// const camera = new THREE.Vector3(4, 2, 4);

// const props = defineProps({
//   meshPath: String,
// });
</script>
