<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="mb-4">
        <p class="text-h2">About</p>
      </v-col>
    </v-row>
    <v-row class="text-center">
      <v-col class="mb-4">
        <v-expansion-panels multiple>
          <v-expansion-panel
            v-for="(next, i) in contents"
            :key="i"
          >
            <v-expansion-panel-title class="text-h5">
              {{ next.header }}
            </v-expansion-panel-title>
            <v-expansion-panel-text>
              <component :is="next.content" />
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import { defineComponent, shallowRef } from 'vue'
  export default {
    data: function () {
      return {
        contents: [
          {
            header: 'About This Website',
            content: shallowRef(defineComponent({
              template: `
              <p class="text-h5">Web App Description</p>
              <p>
                This webapp offers digital editions of Arabic alchemical literature. TEI P5 is used for the encoding.
                To render from TEI to the reader-friendly webpage, the app is designed with Vue.js (version 3),
                accompanied with Vuetify (version 3, a UI framework) and Saxon-js (version 2, a XSLT engine).
                <br /><br />
                In the future, translation and reference sources will be created in TEI as well.
                In addition, quantitative analysis will be made by taking advantage of TEI endoding.
                <br /><br />
                This webapp is all created by Takatomo Inoue, including editing Arabic sources and coding this webapp.
              </p>
              <br /><br /><br />
              <p class="text-h5">Edition</p>
              <p>
                The edited texts include roughly two types: diplomatic edition and (quasi-)critical edition.
                Bibliographical information, editorial notes, discrepancies, marginal notes are indicated with different colors.
                Some of them show further information by hovering the cursor.
              </p>
              <br /><br /><br />
              <p class="text-h5">Translation</p>
              <p>
                I am working on this now, please wait for a while!
              </p>
              <br /><br /><br />
              <p class="text-h5">Glossary</p>
              <p>
                I am working on this now, please wait for a while!
              </p>
              <br /><br /><br />
              <p class="text-h5">Analysis</p>
              <p>
                I am working on this now, please wait for a while!
              </p>
              `,
            })),
          },
          {
            header: 'About the Author',
            content: shallowRef(defineComponent({
              template: `
              <p>
                Takatomo Inoue<br/>
                Ph.D. (Department of History and Philosophy of Science and Medicine, Indiana University, Bloomington), 2025<br/>
                Dissertation Title: <a href="https://www.proquest.com/docview/3207573322?sourcetype=Dissertations%20&%20Theses" target="_blank">\"Alchemy in Medieval Islam and Abū Bakr al-Rāzī\"</a><br/><br/>
                M.A. (Institute of Islamic Studies, McGill University), 2018<br/>
                Thesis Title: <a href="https://escholarship.mcgill.ca/concern/theses/rx913s30p?locale=en" target="_blank">\"Avicennian Natural Philosophy and the Alchemical Theory of al-Ṭughrāʾī in <i>Ḥaqāʾiq al-istishhād</i>\"</a><br/><br/>
                M.A. (Graduate School of Asian and African Area Studies, Kyoyo University), 2011<br/><br/>
                B.A. (School of International Liberal Studies, Waseda University), 2009<br/><br/>
              </p>
              `,
            })),
          },
          {
            header: 'Author\'s Works (Selected)',
            content: shallowRef(defineComponent({
              data: function () {
                return {
                  books: [
                    `Hopefully soon!`,
                  ],
                  articles: [
                    `“Al-Kindī’s Attack on Alchemy and His Perfume Making,” <i>ORIENT</i>, 52, pp. 79–92, 2017.`,
                  ],
                  presentedPapers: [
                    `TBA`
                  ],
                  researchProjects: [
                    `Research Assistant and Web Developer in <a href="https://webapp1.dlib.indiana.edu/newton/" target="_blank">"Chymistry of Issac Newton Project,”</a> Department of History and Philosophy of Science and Medicine, Indiana University, Bloomington.`
                  ],
                  others: [
                    `"Poster Session: Distillation of Rose Water in Medieval Islamic Treatises: Reinterpretation of <i>Kīmiyāʾ</i>," International Conference on Islam and Multiculturalism: Exploring Islamic Studies within a Symbiotic Framework at Asia-Europe Institute, University of Malaya, Dec 13, 2014.`,
                  ],
                }
              },
              template: `
                <p class="text-h5">Books</p>
                <p v-for="item in books" v-html="item"></p>
                <br />
                <p class="text-h5">Articles</p>
                <p v-for="item in articles" v-html="item"></p>
                <br />
                <p class="text-h5">Presented Papers</p>
                <p v-for="item in presentedPapers" v-html="item"></p>
                <br />
                <p class="text-h5">Research Projects</p>
                <p v-for="item in researchProjects" v-html="item"></p>
                <br />
                <p class="text-h5">Others</p>
                <p v-for="item in others" v-html="item"></p>
              `,
            })),
          },
        ],
      }
    },
  }
</script>
