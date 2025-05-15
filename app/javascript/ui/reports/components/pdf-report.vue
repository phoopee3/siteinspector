<!-- filepath: /home/user/Desktop/siteinspector/app/javascript/ui/reports/components/pdf-report.vue -->
<template>
  <div>
    <h1>PDF Report for {{ website.domain }}</h1>
    <p>Total Pages: {{ stats.pages_count }}</p>
    <p>Total Errors: {{ stats.total_errors }}</p>
    <p>Uptime: {{ stats.uptime_percentage }}%</p>

    <h2>Pages</h2>
    <ul>
      <li v-for="page in report.pages" :key="page.id">
        <strong>{{ page.title }}</strong> - {{ page.url }}
        <ul>
          <li v-for="error in page.page_errors" :key="error.id">
            Error: {{ error.message }}
          </li>
          <li v-for="link in page.broken_links" :key="link.id">
            Broken Link: {{ link.url }}
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>

<script>
import api from 'ui/api'

export default {
  name: 'PdfReport',
  props: {
    website: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      stats: {},
      report: {}
    }
  },
  mounted () {
    this.loadReport({ withStats: true })
  },
  methods: {
    loadReport ({ withStats } = {}) {
      return api.get(`websites/${this.website.id}/report`, {
        params: {
          include: 'pages,pages.page_errors,pages.website_page_website_resources,pages.website_page_website_resources.broken_link,pages.custom_rule_results,pages.custom_rule_results.custom_rule',
          fields: {
            custom_rule: 'id,condition,pattern,website_id',
            report: withStats ? 'pages,stats' : 'pages'
          }
        }
      }).then(result => {
        this.report = this.normalizeReport(result.data.data)
        this.stats = result.data.data.stats
      })
    },
    normalizeReport (report) {
      report.pages.forEach((page) => {
        page.broken_links = []
        page.website_page_website_resources.forEach((wpwr) => {
          if (wpwr.broken_link) {
            page.broken_links.push({
              is_resolved: wpwr.is_resolved,
              website_page_website_resource_id: wpwr.id,
              ...wpwr.broken_link
            })
          }
        })
      })

      return report
    }
  }
}
</script>