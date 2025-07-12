<template>
  <div>
    <v-navigation-drawer
      v-model="drawer"
      class="sticky-menu"
      permanent
      :rail="mini"
    >
      <v-list-item min-height="60">
        <v-btn
          v-if="mini"
          class="ml-1 mb-2"
          density="compact"
          flat
          icon="mdi-chevron-right"
          @click.stop="mini = !mini"
        />
        <template #append>
          <v-btn
            v-if="!mini"
            density="compact"
            flat
            icon="mdi-chevron-left"
            @click.stop="mini = !mini"
          />
        </template>
      </v-list-item>

      <v-divider />

      <v-list v-if="!mini" dense>
        <v-list-item
          v-for="item in edList"
          :key="item.title"
          :disabled="mini"
          link
          prepend-icon="mdi-book-open-variant"
          @click="pushURL(item.xsl, item.xml)"
          @click.stop="mini = !mini"
        >
          <v-list-item-title>{{ item.title }}</v-list-item-title>
          <v-list-item-subtitle>{{ item.author }}</v-list-item-subtitle>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <!-- <div ref="parent" /> -->
    <component :is="EditedText" />

  </div>
</template>

<script setup>
  import { defineComponent, onMounted, ref, shallowRef, watch } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useTheme } from 'vuetify'
  import * as components from 'vuetify/components'
  const router = useRouter()
  onMounted (() => {
    const route = useRoute()
    if (route.query.xsl && route.query.xml) {
      pushURL(route.query.xsl, route.query.xml)
      mini.value = true
    }
  })
  const props = defineProps({
    edList: Array,
  })
  const theme = useTheme()
  const isDark = ref(theme.global.name.value === 'dark')
  watch(() => isDark.value, (newVal) => {
    theme.global.name.value = newVal ? 'dark' : 'light'
  })
  const EditedText = shallowRef(defineComponent({
    template: '<div></div>',
  }))
  let xml = ''
  let xsl = ''
  let doc = {}
  const drawer = ref(true)
  const mini = ref(false)
  async function getConvertedText () {
    try {
      const responseXML = await fetch(`${import.meta.env.BASE_URL}tei/${xml}.xml`)
      const xmlStr = await responseXML.text()
      const responseXSL = await fetch(`${import.meta.env.BASE_URL}xslt/${xsl}.sef.json`)
      const xslStr = await responseXSL.text()

      try {
        const options = {
          stylesheetText: xslStr,
          sourceText: xmlStr,
          destination: 'application'
        }
        const result = await SaxonJS.transform(options, 'async')
        doc = result.principalResult
      } catch (error) {
        console.error(error)
        throw new Error('ERROR in converting')
      }
      // Conversions that XSLT cannot deal with
      while (!!doc.querySelector('#vslot')) {
        doc.querySelector('#vslot').setAttribute('v-slot:activator', '{ props }')
        doc.querySelector('#vslot').removeAttribute('id')
      }
      while (!!doc.querySelector('#v-menu-config')) {
        doc.querySelector('#v-menu-config').setAttribute(':nudge-width', '150')
        doc.querySelector('#v-menu-config').setAttribute(':close-on-content-click', 'false')
        doc.querySelector('#v-menu-config').removeAttribute('id')
      }

      const serializer = new XMLSerializer()
      const convertedStr = serializer.serializeToString(doc).replaceAll('template-to-be', 'template')
      EditedText.value = createDynamicComponent(convertedStr)
    } catch (error) {
      console.error(error)
      throw new Error('ERROR in rendering')
    }
  }

  function converting (xslin, xmlin) {
    xml = xmlin
    xsl = xslin
    getConvertedText()
  }

  function pushURL (xsl, xml) {
    router.push({
      path: 'edition',
      query: {
        xsl: xsl,
        xml: xml,
      }
    })
    converting(xsl, xml)
  }
  function createDynamicComponent (templateStr) {
    return defineComponent({
      components: {
        components,
      },
      template: templateStr,
    })
  }
</script>

<style>
  div.double-space {
    line-height: 2.5;
  }
  p.first-line-indent {
    text-indent: 80px;
  }
</style>
