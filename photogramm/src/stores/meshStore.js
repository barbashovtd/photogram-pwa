import { defineStore } from 'pinia'

export const useMeshStore = defineStore('mesh', {
  state: () => ({
    name: '404',
    mesh: './src/assets/404.glb'
  }),

  getters: {
    currentMesh(state) {
      return { name: state.name, mesh: state.mesh }
    }
  },

  // actions: {
  //   increment() {
  //     this.counter++
  //   }
})
