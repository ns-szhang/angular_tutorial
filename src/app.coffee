express = require 'express'
html = require 'http'
swig = require 'swig'

swig.setDefaults
    varControls: ['{=', '=}']

app = express()

app.set 'views', __dirname + '/../views'
app.engine 'html', swig.renderFile
app.set 'view engine', 'html'

app.use '/static/js', express.static 'static/js'
app.use '/static/styles', express.static 'static/styles'


app.use '/', (req, res) ->
  res.render 'index'

server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port
  console.log 'Example app listening at https://%s:%s', host, port
