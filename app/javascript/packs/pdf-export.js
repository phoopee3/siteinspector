// filepath: /home/user/Desktop/siteinspector/app/javascript/packs/pdf-export.js
import { createApp } from 'vue'
import PdfExportPage from '../ui/reports/pages/pdf-export-page'

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('pdf-export-app')
  if (element) {
    const website = JSON.parse(element.getAttribute('data-website'))
    createApp(PdfExportPage, { website }).mount('#pdf-export-app')
  }
})