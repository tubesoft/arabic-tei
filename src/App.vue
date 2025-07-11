<template>
  <v-app>
    <v-main>
      <v-app-bar>
        <v-toolbar-title class="text-h5 ml-5 font-weight-bold">Arabic Alchemical Literature Studies</v-toolbar-title>
        <template #append>
          <v-switch
            v-model="isONBool"
            class="pr-15 mt-2"
            color="secondary"
            hide-details
            :label="`Dark Mode: ${isON}`"
            @update:model-value="alterTheme"
          />
          <v-text-field
            append-inner-icon="mdi-magnify"
            class="pr-10"
            density="compact"
            disabled
            hide-details
            label="Search (Under Construction)"
            min-width="300"
            single-line
            variant="underlined"
          />
        </template>
        <template #extension>
          <v-tabs v-model="selectedTab">
            <v-tab to="/" value="home">Home</v-tab>
            <v-tab
              v-for="item in contents"
              :key="item.text"
              :to="item.href"
              :value="item.text"
            >{{ item.text }}</v-tab>
          </v-tabs>
        </template>
      </v-app-bar>
      <router-view :contents="contents" :ed-list="editionList" />
    </v-main>
    <v-spacer />
    <v-container>
      <AppFooter :contents="contents" />
    </v-container>
  </v-app>
</template>

<script setup>
  import { ref } from 'vue'
  import { useRoute } from 'vue-router'
  import { useTheme } from 'vuetify'
  import AppFooter from './components/AppFooter.vue'
  const theme = useTheme()
  const route = useRoute()
  const selectedTab = ref(route.path.slice(1))
  const editionList = []
  const contents = [
    {
      text: 'About',
      href: '/about',
    },
    {
      text: 'Edition',
      href: '/edition',
    },
    {
      text: 'Translation',
      href: '/translation',
    },
    {
      text: 'Glossary',
      href: '/glossary',
    },
    {
      text: 'Analysis',
      href: '/analysis',
    },
  ]

  let res = null
  let isON = ''
  let isONBool = false
  let themeName = '';

  (async () => {
    const isDeviceDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    if (isDeviceDark) {
      themeName = 'dark'
      isON = 'ON'
      isONBool = true
    } else {
      themeName = 'light'
      isON = 'OFF'
      isONBool = false
    }
    theme.global.name.value = themeName
    try {
      let num = 1
      const responseXSL = await fetch('src/assets/xslt/make-title-list.sef.json')
      const xslStr = await responseXSL.text()

      while (true) {
        const responseXML = await fetch('src/assets/tei/AMI' + ('00000' + num).slice(-5) + '.xml')
        const xmlStr = await responseXML.text()
        num++
        try {
          const options = {
            stylesheetText: xslStr,
            sourceText: xmlStr,
            destination: 'application'
          }
          const result = await SaxonJS.transform(options, 'async')
          res = result.principalResult
        } catch {
          throw new Error('EOD')
        }
        const doc = res
        const title = doc.querySelector('#title').textContent
        const author = doc.querySelector('#author').textContent
        const fileName = doc.querySelector('#file-name').textContent
        const arrayItem = { title: title, author: author, xml: fileName, xsl: 'tei-to-vue' }
        editionList.push(arrayItem)
      }
    } catch {
      console.log('TEI files has been listed')
    }
  })()

  function alterTheme () {
    themeName = themeName === 'light' ? 'dark' : 'light'
    isON = isON === 'OFF' ? 'ON' : 'OFF'
    isONBool = isON === 'ON' ? true : false
    theme.global.name.value = themeName
  }
</script>
