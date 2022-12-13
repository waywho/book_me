module.exports = {
  mode: 'jit',
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/components/*.rb',
    './app/components/**/*.html.erb',
    './app/components/**/*.js',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './config/initializers/simple_form_tailwind.rb',
  ],
  theme: {
    container: {
      center: true,
    },
  },
  plugins: [
   require("daisyui")
  ],
}

