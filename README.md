
<div align="center">

🕙 `Last Sync: 11/14/2024 02:32 UTC`

</div>

---

<br />

- [About](#about)
  - [★ Severity Rating ★](#-severity-rating-)
- [Main Lists](#main-lists)
- [Privacy Lists](#privacy-lists)
- [Spam Lists](#spam-lists)
- [Geographical (Continents \& Countries)](#geographical-continents--countries)
- [Transmission (BitTorrent Client)](#transmission-bittorrent-client)
- [Install](#install)
  - [ConfigServer Firewall Users](#configserver-firewall-users)

<br />

---

<br />

# About
This repository contains a collection of dynamically updated blocklists which can be utilized to filter out traffic from communicating with your server.

<br />

These blocklists can be used with:
- ConfigServer Firewall
- FireHOL
- Crowdsec
- Transmission (BitTorrent Client)
- OPNsense
- Many others

<br />

Blocklist and statistics are updated daily, and some are updated multiple times a day depending on the category of blocklist. Others may only update once per day depending on how often they refresh.

<br />

## ★ Severity Rating ★
The **Severity Rating** is a column shown below for each blocklist. This score is calculated depending on how many "abusive" IP addresses exist within that ipset file.

<br />

As an example, the **Cloudflare CDN** has a score of `★★★⚝⚝ 3 or higher`, due to the fact that many people are reporting that servers hosted by Cloudflare seem to be involved in a lot of abusive activity such as port scanning and SSH bruteforce attacks. The more reports that the Ips in the Cloudflare file have, the higher the severity rating will rise. This score is based on the mean (average) report history of all IPs in the list.

<br />

This rating is calculated once a day.

<br />

---

<br />

# Main Lists
These are the primary lists that most people will be interested in. They contain a large list of IP addresses which have been reported in the last 360 days for abusive behavior. These statistics are gathered from numerous websites such as [AbuseIPDB](https://www.abuseipdb.com/) and [IPThreat](https://ipthreat.net/). IPs on this list have a 70-100% confidency level of engaging in the following:

- SSH Bruteforcing
- Port Scanning
- DDoS Attacks
- IoT Targeting
- Phishing

<br />

| Set Name | Description | Severity | View |
| --- | --- | --- | --- |
| `01_master.ipset` | <sub>Abusive IP addresses which have been reported for port scanning and SSH bruteforcing. HIGHLY recommended. <br> Includes [AbuseIPDB](https://www.abuseipdb.com/), [IPThreat](https://ipthreat.net/), [CinsScore](https://cinsscore.com), [GreensNow](https://blocklist.greensnow.co/greensnow.txt)</sub> | ★★★★★ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/01_master.ipset) |
| `01_highrisk.ipset` | <sub>IPs with highest risk to your network and have a possibility that the activity which comes from them are going to be fraudulent.</sub> | ★★★★⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/01_highrisk.ipset) |

<br />

---

<br />

# Privacy Lists
These blocklists give you more control over what 3rd party services can access your server, and allows you to remove bad actors or services hosting such services.

<br />

| Set | Description | Severity | View |
| --- | --- | --- | --- |
| `02_privacy_general.ipset` | <sub>Servers which scan ports for data collection and research purposes. List includes [Censys](https://censys.io), [Shodan](https://www.shodan.io/), [Project25499](https://blogproject25499.wordpress.com/), [InternetArchive](https://archive.org/) </sub> | ★★★★⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_general.ipset) |
| `02_privacy_ahrefs.ipset` | <sub>Ahrefs SEO and services</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_ahrefs.ipset) |
| `02_privacy_amazon_aws.ipset` | <sub>Amazon AWS</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_amazon_aws.ipset) |
| `02_privacy_amazon_ec2.ipset` | <sub>Amazon EC2</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_amazon_ec2.ipset) |
| `02_privacy_applebot.ipset` | <sub>Apple Bots</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_applebot.ipset) |
| `02_privacy_bing.ipset` | <sub>Microsoft Bind and Bing Crawlers / Bots</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_bing.ipset) |
| `02_privacy_bunnycdn.ipset` | <sub>Bunny CDN</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_bunnycdn.ipset) |
| `02_privacy_cloudflarecdn.ipset` | <sub>Cloudflare CDN</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_cloudflarecdn.ipset) |
| `02_privacy_cloudfront.ipset` | <sub>Cloudfront DNS</sub> | ★⚝⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_cloudfront.ipset) |
| `02_privacy_duckduckgo.ipset` | <sub>DuckDuckGo Web Crawlers / Bots</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_duckduckgo.ipset) |
| `02_privacy_facebook.ipset` | <sub>Facebook Bots & Trackers</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/02_privacy_facebook.ipset) |
| `02_privacy_fastly.ipset` | <sub>Fastly CDN</sub> | ★⚝⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_fastly.ipset) |
| `02_privacy_google.ipset` | <sub>Google Crawlers</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_google.ipset) |
| `02_privacy_pingdom.ipset` | <sub>Pingdom Monitoring Service</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_pingdom.ipset) |
| `02_privacy_rssapi.ipset` | <sub>RSS API Reader</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_rssapi.ipset) |
| `02_privacy_stripe_api.ipset` | <sub>Stripe Payment Gateway API</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_stripe_api.ipset) |
| `02_privacy_stripe_armada_gator.ipset` | <sub>Stripe Armada Gator</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_stripe_armada_gator.ipset) |
| `02_privacy_stripe_webhooks.ipset` | <sub>Stripe Webhook Service</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_stripe_webhooks.ipset) |
| `02_privacy_telegram.ipset` | <sub>Telegram Trackers and Crawlers</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_telegram.ipset) |
| `02_privacy_uptimerobot.ipset` | <sub>Uptime Robot Monitoring Service</sub> | ★⚝⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_uptimerobot.ipset) |
| `02_privacy_webpagetest.ipset` | <sub>Webpage Test Services</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/02_privacy_webpagetest.ipset) |

<br />

---

<br />

# Spam Lists
These blocklists allow you to remove the possibility of spam sources accessing your server.

<br />

| Set | Description | Severity | View |
| --- | --- | --- | --- |
| `03_spam_forums.ipset` | <sub>List of known forum / blog spammers and bots</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/03_spam_forums.ipset) |
| `03_spam_spamhaus.ipset` | <sub>Bad actor IP addresses registered with Spamhaus</sub> | ★★★★⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/03_spam_spamhaus.ipset) |

<br />

---

<br />

# Geographical (Continents & Countries)
These blocklists allow you to determine what geographical locations can access your server. These can be used as either a whitelist or a blacklist. Includes both **continents** and **countries**.

<br />

| Set | Description | Severity | View |
| --- | --- | --- | --- |
| `GeoLite2 Database` | <sub>Lists IPs by continent and country from GeoLite2 database. Contains both IPv4 and IPv6 subnets</sub> | ★★★★★ | [view](https://dev.maxmind.com/geoip/geolite2-free-geolocation-data/) |
| `Ip2Location Database` | <sub>Coming soon</sub> | ★★★★★ | [view](https://lite.ip2location.com/database-download) |

<br />

---

<br />

# Transmission (BitTorrent Client)
This section includes blocklists which you can import into the [bittorrent client Transmission](https://transmissionbt.com/).

<br />

- In this repo, copy the direct URL to the Transmission blocklist, provided below:
  - https://github.com/Aetherinox/blocklists/raw/main/blocklists/transmission/blocklist.gz
- Open your Transmission application; depending on the version you run, do ONE of the follow two choices:
  - Paste the link to Transmission > Settings > Peers > Blocklist
  - Paste the link to Transmission > Edit > Preferences > Privacy > Enable blocklist

<br />

| Set | Description | Severity | View |
| --- | --- | --- | --- |
| `bt-transmission` | <sub>A large blocklist for the BitTorrent client [Transmission](https://transmissionbt.com/)</sub> | ★★★★★ | [view](https://transmissionbt.com/) |

<br />

---

<br />

# Install
This section explains how to use these blocklists within particular software titles.

<br />

## ConfigServer Firewall Users
This repository contains a set of ipsets which are automatically updated every `6 hours`. You may add these sets to your ConfigServer Firewall `/etc/csf/csf.blocklists` with the following new line:

```
csf|86400|0|https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/01_master.ipset
```