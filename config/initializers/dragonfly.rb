require 'dragonfly'
app = Dragonfly[:images]

app.configure_with(:imagemagick)
app.configure_with(:rails)
app.configure_with(:heroku, 'nsake') if Rails.env.production?

app.define_macro(ActiveRecord::Base, :image_accessor)

# require 'dragonfly/rails/images'
# require 'dragonfly'

# app = Dragonfly[:images]
# app.configure_with(:rails)

# app.define_macro(ActiveRecord::Base, :image_accessor)

