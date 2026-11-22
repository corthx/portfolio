<script setup lang="ts">
import { useFlag } from "@unleash/proxy-client-vue";

const displayEyesPopup = ref<boolean>(false);
const displayLanguageSwitcher = ref<boolean>(false);
const displayThemeSwitcher = ref<boolean>(false);

const head = useLocaleHead();
useHead(() => ({ link: head.value.link, meta: head.value.meta }));
const config = useConfig();

onMounted(() => {
  const displayAnimatedEyesFlag = useFlag("display-animated-eyes");
  const displayLanguageSwitcherFlag = useFlag("display-language-switcher");
  const displayThemeSwitcherFlag = useFlag("display-theme-switcher");

  syncRef(displayEyesPopup, displayAnimatedEyesFlag, { direction: "rtl" });
  syncRef(displayLanguageSwitcher, displayLanguageSwitcherFlag, { direction: "rtl" });
  syncRef(displayThemeSwitcher, displayThemeSwitcherFlag, { direction: "rtl" });
});
</script>

<template>
  <Html :dir="head.htmlAttrs?.dir" :lang="head.htmlAttrs?.lang">
    <Head>
      <Link rel="shortcut icon" href="/favicon.ico" />
      <Link rel="manifest" href="/site.webmanifest" />
      <Meta :content="config.seo.description.default" name="description" />
      <Meta :content="config.seo.description.default" property="og:description" />
      <Meta :content="config.seo.description.default" name="twitter:description" />
      <Meta :content="config.seo.name.default" property="og:title" />
      <Meta :content="config.seo.name.default" name="twitter:title" />
      <Meta :content="config.seo.url" name="twitter:site" />
      <Meta :content="config.seo.color" name="msapplication-TileColor" />
      <Meta :content="config.seo.image" name="msapplication-TileImage" />
      <Meta :content="config.seo.color" name="theme-color" />
    </Head>
    <Body>
      <EyesPopup
        :class="{ invisible: !displayEyesPopup || (!displayLanguageSwitcher && !displayThemeSwitcher) }"
        :display-language-switcher="displayLanguageSwitcher"
        :display-theme-switcher="displayThemeSwitcher"
      />
      <slot />
    </Body>
  </Html>
</template>
