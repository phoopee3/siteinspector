<template>
  <div>
    <div class="d-flex justify-content-between align-items-end">
      <h1>
        <span class="d-inline d-md-none">Report</span>
        <span class="d-none d-md-inline">Error report</span>
      </h1>
      <div>
        <IButton
          role="exportPdfBtn"
          size="large"
          class="bg-white me-3"
          type="primary"
          icon="md-download"
          ghost
          @click="openExportPdfModal"
        >
          <span class="d-none d-md-inline">Export as PDF</span>
        </IButton>
        <IButton
          role="shareReporBtn"
          size="large"
          class="bg-white"
          type="primary"
          icon="md-share"
          ghost
          @click="openShareModal"
        >
          <span class="d-none d-md-inline">Share Report</span>
        </IButton>
      </div>
    </div>
    <Website
      v-for="website in websites"
      :key="website.id"
      :website="website"
      :collapse="websites.length > 1"
      class="mt-3"
    />
  </div>
</template>

<script>
import Website from '../components/website'
import ShareForm from '../components/share'
import ExportPdfForm from '../components/export-pdf-form'
import { Modal } from 'view3/src/plugins/dynamic-components'

export default {
  name: 'ReportsIndex',
  components: {
    Website
  },
  computed: {
    websites () {
      return [...this.$store.getters.websites].sort((a, b) => b.id - a.id)
    }
  },
  methods: {
    openShareModal () {
      Modal.open(ShareForm, {
        onClose: (data) => {
          Modal.remove()
        }
      }, {
        title: 'Share report',
        closable: true
      })
    },
    openExportPdfModal () {
      Modal.open(ExportPdfForm, {
        onClose: (data) => {
          Modal.remove()
        }
      }, {
        title: 'Export report as PDF',
        closable: true
      })
    }
  }
}
</script>
