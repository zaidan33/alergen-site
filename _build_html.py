#!/usr/bin/env python3
"""Wrap the raw fragment (title + style + body markup) into a full HTML5 document.

The original file from the zip has no doctype/head/body and no viewport meta,
which breaks mobile rendering. This script is the single source of truth for the
document shell; run it whenever the fragment changes.
"""
import pathlib

SRC = pathlib.Path("/tmp/index.orig.html")
OUT = pathlib.Path(__file__).with_name("index.html")
DOMAIN = "https://alergen.airlangga.link"

raw = SRC.read_text(encoding="utf-8")

# split: fragment = announce/style part + markup part
style_end = raw.index("</style>")
head_part = raw[: style_end + len("</style>")]
body_part = raw[style_end + len("</style>") :]

head_extra = f"""
<link rel="canonical" href="{DOMAIN}/">
<meta name="robots" content="index,follow">
<meta property="og:type" content="website">
<meta property="og:locale" content="id_ID">
<meta property="og:site_name" content="Alergen">
<meta property="og:url" content="{DOMAIN}/">
<meta property="og:title" content="Patch Diagnostik Alergen — sepuluh alergen, satu patch">
<meta property="og:description" content="Patch diagnostik 10 alergen dan tablet sublingual desensitisasi, dalam pengembangan. Informasi untuk klinisi dan mitra.">
<meta property="og:image" content="{DOMAIN}/images/hero-patch.webp">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Patch Diagnostik Alergen">
<meta name="twitter:description" content="Sepuluh alergen, satu patch. Informasi untuk klinisi dan mitra.">
<meta name="twitter:image" content="{DOMAIN}/images/hero-patch.webp">
<meta name="theme-color" content="#ffffff" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#060909" media="(prefers-color-scheme: dark)">
<link rel="icon" href="/favicon.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="/favicon.svg">
<script type="application/ld+json">
{{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Alergen",
  "url": "{DOMAIN}/",
  "email": "info@alergen.unair.ac.id",
  "description": "Pengembangan patch diagnostik 10 alergen dan tablet sublingual desensitisasi. Informasi untuk tenaga kesehatan dan mitra.",
  "address": {{
    "@type": "PostalAddress",
    "addressLocality": "Surabaya",
    "addressRegion": "Jawa Timur",
    "addressCountry": "ID"
  }}
}}
</script>
<style>
/* Accessibility/robustness fixes layered on top of the source fragment. */
[hidden] {{ display: none !important; }}
section[id], footer[id] {{ scroll-margin-top: 16px; }}

/* Mobile nav: brand + CTA on one row, links become a scrollable strip.
   (Source fragment let the nav wrap into three ragged rows under 640px.) */
@media (max-width: 640px) {{
  .nav {{ display: grid; grid-template-columns: minmax(0, 1fr) auto; align-items: center; gap: 10px 12px; padding-block: 16px; }}
  .nav-links {{ grid-column: 1 / -1; grid-row: 2; flex-wrap: nowrap; gap: 18px; overflow-x: auto; padding-bottom: 2px;
                scrollbar-width: none; -webkit-overflow-scrolling: touch; }}
  .nav-links::-webkit-scrollbar {{ display: none; }}
  .nav-links a {{ white-space: nowrap; }}
  .nav .btn.light {{ min-height: 38px; padding: 0 16px; font-size: 12.5px; }}
  .announce {{ font-size: 11px; padding: 8px 14px; }}
  .cta h2 {{ max-width: 22ch; }}
}}
</style>
"""

doc = (
    "<!DOCTYPE html>\n"
    '<html lang="id">\n<head>\n'
    '<meta charset="utf-8">\n'
    '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
    + head_part.replace('<meta name="claude:viewport-fit-sides" content="cover">\n', "")
    + head_extra
    + "</head>\n<body>\n"
    + body_part.lstrip("\n")
    + "</body>\n</html>\n"
)

OUT.write_text(doc, encoding="utf-8")
print(f"wrote {OUT} ({len(doc)} bytes)")
