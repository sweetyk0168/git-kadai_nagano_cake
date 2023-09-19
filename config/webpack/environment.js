const { environment } = require('@rails/webpacker')

module.exports = environment

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.Provideplugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    popper: 'popper.js'
  })
  )
