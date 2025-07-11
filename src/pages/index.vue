<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="mb-4">
        <p class="text-h2">Arabic Alchemical Literature Studies
          <br />
          by Takatomo Inoue
        </p>
        <p class="heading font-weight-regular">
          Digital Editions and Translations of Primary Sources
          <br />
          Using TEI P5 Encording
        </p>
      </v-col>

      <v-col
        class="mb-5"
        cols="12"
      >
        <h2 class="headline font-weight-bold mb-10">
          Contents
        </h2>
        <v-row justify="center">
          <span
            v-for="(item, i) in contents"
            :key="i"
            class="mx-3"
          >
            <v-btn
              class="pa-10 pb-14 rounded-xl"
              size="x-large"
              :text="item.text"
              :to="item.href"
            />
          </span>
        </v-row>
      </v-col>

      <v-col
        class="mb-5"
        cols="12"
      >
        <h2 class="headline font-weight-bold my-7">
          Important Links
        </h2>

        <v-row justify="center">
          <span
            v-for="(item, i) in links"
            :key="i"
            class="mx-3"
          >
            <v-btn
              class="pa-10 pb-14 rounded-xl"
              :href="item.href"
              size="x-large"
              :text="item.text"
            />
          </span>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>
<script setup>
  const props = defineProps({
    contents: Array
  })
  const links = [
    {
      text: 'TEI',
      href: 'https://tei-c.org',
    },
    {
      text: 'P5 Guideline',
      href: 'https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html',
    },
  ]

</script>
