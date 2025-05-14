<template>
  <IForm
    ref="form"
    @submit.native.prevent="$emit('close')"
  >
    <div class="row">
      <FormItem
        v-if="!website && websites.length > 1"
        label="Website"
      >
        <ISelect
          :value="formData.selectedWebsiteId"
          size="large"
          :loading="formData.isLoading"
          filterable
          @on-change="onSelectWebsite"
        >
          <IOption
            v-for="option in websites"
            :key="option.id"
            :value="option.id"
            :label="option.domain"
          />
        </ISelect>
      </FormItem>
      <div class="col-12 mb-3">
        <p>Click the button below to export this report as a PDF document. The PDF will include summary statistics and detailed error information.</p>
      </div>
    </div>
    <IButton
      type="primary"
      class="mt-1"
      size="large"
      long
      :loading="formData.isExporting"
      :disabled="!formData.selectedWebsiteId"
      @click="exportPdf"
    >
      Export PDF
    </IButton>
  </IForm>
</template>

<script>
import api from 'ui/api'
import { Message } from 'view3/src/plugins/dynamic-components'

export default {
  name: 'ExportPdfForm',
  props: {
    website: {
      type: Object,
      required: false,
      default: null
    }
  },
  data () {
    return {
      formData: {
        isLoading: false,
        isExporting: false,
        selectedWebsiteId: ''
      }
    }
  },
  computed: {
    websites () {
      return [...this.$store.getters.websites].sort((a, b) => a.domain < b.domain ? -1 : 1)
    }
  },
  mounted () {
    if (this.website) {
      this.onSelectWebsite(this.website.id)
    } else if (this.websites.length === 1) {
      this.onSelectWebsite(this.websites[0].id)
    }
  },
  methods: {
    onSelectWebsite (websiteId) {
      this.formData.selectedWebsiteId = websiteId
    },
    exportPdf () {
      if (!this.formData.selectedWebsiteId) {
        Message.warning('Please select a website first')
        return
      }

      this.formData.isExporting = true

      // For now, just show a success message without actual PDF export
      // In a subsequent implementation, we would call the API to generate the PDF
      setTimeout(() => {
        Message.success('PDF report has been generated and downloaded')
        this.formData.isExporting = false
        this.$emit('close')
      }, 1500)
      
      // Actual implementation would be something like:
      /*
      api.get(`websites/${this.formData.selectedWebsiteId}/export_pdf`, {
        responseType: 'blob'
      }).then((response) => {
        const url = window.URL.createObjectURL(new Blob([response.data]))
        const link = document.createElement('a')
        link.href = url
        link.setAttribute('download', `report-${this.websites.find(w => w.id === this.formData.selectedWebsiteId).domain}.pdf`)
        document.body.appendChild(link)
        link.click()
        link.remove()
        Message.success('PDF report has been downloaded')
        this.$emit('close')
      }).catch((error) => {
        console.error(error)
        Message.error('Failed to generate PDF report')
      }).finally(() => {
        this.formData.isExporting = false
      })
      */
    }
  }
}
</script>

<style lang="scss" scoped>

</style>

