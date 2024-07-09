const {
  Before,
  BeforeAll,
  AfterAll,
  After,
  setDefaultTimeout
} = require('@cucumber/cucumber')
const { webkit } = require('playwright')

setDefaultTimeout(6000)

// launch the browser
BeforeAll(async () => {
  global.browser = await webkit.launch({
    headless: true,
    slowMo: 1
  })
})

// close the browser
AfterAll(async () => {
  await global.browser.close()
})

// Create a new browser context and page per scenario
Before(async () => {
  global.context = await global.browser.newContext()// Crea un nuevo contexto/scenario (perfil)
  global.page = await global.context.newPage()// creas una nueva pagina
})

// Cleanup after each scenario
After(async () => {
  await global.page.close()
  await global.context.close()
})
