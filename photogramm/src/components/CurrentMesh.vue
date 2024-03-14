<template>
  <Suspense>
    <primitive :object="scene" />
  </Suspense>
</template>

<script setup lang="ts">
import { useGLTF } from "@tresjs/cientos";

const props = defineProps({ mesh: { type: String, required: true } });
const { scene } = await useGLTF(props.mesh, { draco: true });
</script>
