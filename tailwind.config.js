module.exports = {
  mode: 'jit',
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/javascript/**/*.js',
    './config/initializers/simple_form_tailwind.rb',
    './node_modules/flowbite/**/*.js'
  ],
  daisyui: {
      themes: [
        {
          mytheme: {
            "primary": "#4ade80",
            "secondary": "#8b5cf6",
            "accent": "#fde047",
            "neutral": "#3D4451",
            "base-100": "#FFFFFF",
            "info": "#3ABFF8",
            "success": "#36D399",
            "warning": "#FBBD23",
            "error": "#F87272",
          },
        },
      ],
    },
  plugins: [
   require("daisyui")
  ],
}
