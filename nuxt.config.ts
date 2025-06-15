import tailwindcss from "@tailwindcss/vite";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },

  future: {
    compatibilityVersion: 4
  },

  modules: [
    '@nuxt/eslint',
    '@nuxt/fonts',
    '@nuxt/image',
    '@nuxt/content',
    '@sidebase/nuxt-auth',
    '@prisma/nuxt',
    'shadcn-nuxt',
    '@formkit/auto-animate/nuxt',
  ],

  auth: {
    provider: {
      type: 'authjs',
      trustHost: false,
      defaultProvider: 'github',
      addDefaultCallbackUrl: true
    }
  },

  runtimeConfig: {
    auth: {
      secret: process.env.AUTH_SECRET,
      providers: {
        github: {
          clientId: process.env.OAUTH_GITHUB_CLIENT_ID,
          clientSecret: process.env.OAUTH_GITHUB_CLIENT_SECRET,
        }
      }
    }
  },

  css: ['@/assets/css/main.css'],
  vite: {
    plugins: [
      tailwindcss(),
    ],
  },

    shadcn: {
    /**
     * Prefix for all the imported component
     */
    prefix: '',
    /**
     * Directory that the component lives in.
     * @default "./app/components/ui"
     */
    componentDir: './app/components/ui'
  }
})