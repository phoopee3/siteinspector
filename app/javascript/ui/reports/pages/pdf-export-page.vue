<!-- filepath: /home/user/Desktop/siteinspector/app/javascript/ui/reports/pages/pdf-export-page.vue -->
pdf-export-page.vue
<template>
  <div>
    <PdfReport :website="website" />
  </div>
</template>

<script>
import PdfReport from '../components/pdf-report'

export default {
  name: 'PdfExportPage',
  components: {
    PdfReport
  },
  props: {
    website: {
      type: Object,
      required: true
    }
  }
}
</script>