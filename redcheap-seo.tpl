{assign var=baseurl value="https://cloudbaseindia.com"}
<script type="application/ld+json">
{
 "@context": "https://schema.org",
 "@type": "Organization",
 "name": "CloudBaseIndia",
 "url": "https://cloudbaseindia.com",
 "logo": "https://cloudbaseindia.com/logo.png",
 "sameAs": [
   "https://facebook.com/",
   "https://instagram.com/"
 ]
}
</script>
<!-- BASIC SEO -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="canonical" href="{$baseurl}{$smarty.server.REQUEST_URI}">
<meta name="robots" content="index, follow">
<meta name="author" content="CloudBaseIndia">

<!-- ================= HOMEPAGE ================= -->
{if $templatefile == 'homepage'}

<title>{$companyname} | Fast & Secure Web Hosting in India</title>
<meta name="description" content="Get cheap web hosting in India with CloudBaseIndia. Fast SSD hosting, VPS servers, reseller hosting, domains & SSL with 99.9% uptime.">
<meta name="keywords" content="web hosting India, VPS hosting India, reseller hosting India">

<!-- OG -->
<meta property="og:title" content="CloudBaseIndia - Web Hosting India">
<meta property="og:description" content="Fast, secure and affordable hosting for everyone.">
<meta property="og:type" content="website">
<meta property="og:url" content="{$baseurl}">
<meta property="og:image" content="{$baseurl}/assets/img/og-image.jpg">

<!-- TWITTER -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="CloudBaseIndia Hosting">
<meta name="twitter:description" content="Reliable hosting solutions in India.">
<meta name="twitter:image" content="{$baseurl}/assets/img/og-image.jpg">

<!-- ================= SHARED HOSTING ================= -->
{elseif $filename eq "shared-hosting"}

<title>Shared Hosting India | {$companyname}</title>
<meta name="description" content="Affordable shared hosting with SSD, free SSL and 99.9% uptime.">
<meta name="keywords" content="shared hosting India, cheap hosting India">

<!-- ================= VPS ================= -->
{elseif $filename eq "vps-server"}

<title>VPS Hosting India | {$companyname}</title>
<meta name="description" content="Powerful VPS hosting with SSD storage and root access.">
<meta name="keywords" content="VPS hosting India, virtual private server">

<!-- ================= Reseller ================= -->
{elseif $filename eq "reseller-hosting"}

<title>Reseller Hosting India | {$companyname}</title>
<meta name="description" content="Scalable cloud hosting with high availability and performance.">

<!-- ================= DOMAIN ================= -->
{elseif $filename eq "domain-search"}

<title>Buy Domain India | {$companyname}</title>
<meta name="description" content="Register domain names at best price with instant activation.">

<!-- ================= DEFAULT ================= -->
{else}

<title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>
<meta name="description" content="{$companyname} provides secure and fast hosting services in India.">

{/if}
