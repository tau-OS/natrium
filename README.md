# Natrium Typeface

Natrium is a typeface for tauOS, it is a modified version of the [Geist](https://vercel.com/font) typeface from Vercel.

This repository simply contains scripts to modify the Geist typeface to create Natrium

## Why?

We wanted to use Geist as the new typeface for tauOS, but
we wanted to force on specific font features and glyphs to make it more suitable
under the design guidelines.

Initially, we simply used Geist and then enforced our own features over
`font-feature-settings`, but this causes an issue since enforcing
arbitrary features in the stylesheet can lead to unexpected results and inconsistencies, especially when
the user is using a different system font.

In our case, since Helium is based on GTK4 the default system font is set to **Adwaita Sans**, a fork of **Inter**
which had different stylistic features than what we wanted. We didn't want to enforce the typeface
by default in the stylesheet, but rather let the user choose their own font and override the default font settings.
