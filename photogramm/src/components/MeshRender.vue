// TODO: Split to mesh.vue with useGLTF and ModelRender.vue (because of
Suspense)
<template>
  <TresCanvas v-bind="gl" window-size>
    <TresPerspectiveCamera :position="[4, 2, 4]" />
    <OrbitControls />
    <Suspense>
      <GLTFModel :path="meshStore.mesh" :key="meshStore.name" draco />
    </Suspense>
    <TresDirectionalLight :position="[1, 1, 1]" :intensity="0.75" cast-shadow />
  </TresCanvas>
</template>

<script setup lang="ts">
import { Suspense, defineProps, shallowRef, ref } from "vue";
import { TresCanvas, useRenderLoop } from "@tresjs/core";
import { GLTFModel, OrbitControls } from "@tresjs/cientos";
import { BasicShadowMap, SRGBColorSpace, NoToneMapping } from "three";
import { useMeshStore } from "stores/meshStore";

const meshStore = useMeshStore();

const gl = {
  clearColor: "#eaeaea",
  shadows: true,
  alpha: false,
  shadowMapType: BasicShadowMap,
  outputColorSpace: SRGBColorSpace,
  toneMapping: NoToneMapping,
};
// const camera = {x:4, y:2, z:4};
// const camera = new THREE.Vector3(4, 2, 4);

// const props = defineProps({
//   meshPath: String,
// });
</script>
