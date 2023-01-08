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
  purge: {
    safelist: [
      'col-start-1',
      'col-start-2',
      'col-start-3',
      'col-start-4',
      'col-start-5',
      'col-start-6',
      'col-start-7',
      'col-start-8',
      'col-start-9',
      'col-end-1',
      'col-end-2',
      'col-end-3',
      'col-end-4',
      'col-end-5',
      'col-end-6',
      'col-end-7',
      'col-end-8',
      'col-end-9',
      'row-start-1',
      'row-start-2',
      'row-start-3',
      'row-start-4'
    ],
  },
}

