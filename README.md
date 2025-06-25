
<div align="center">

🕙 `Last Sync: 06/25/2025 00:33 UTC`

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
These are the primary lists that most people will be interested in. They contain a large list of IP addresses which have been reported recently for abusive behavior. These statistics are gathered from numerous websites such as [AbuseIPDB](https://abuseipdb.com/) and [IPThreat](https://ipthreat.net/). IPs on this list have a 100% confidence level, which means you should get no false-positives from any of the IPs in these lists. IP addresses in these lists have been flagged for engaging in the following:

- SSH Bruteforcing
- Port Scanning
- DDoS Attacks
- IoT Targeting
- Phishing

<br />

For the majority of people, using the blocklists `master.ipset` and `highrisk.ipset` will be all you need. It is a massive collection, all with a 100% confidence level, which means you should get none or minimal false positives. 

<br />

| Set Name | Description | Severity | View |
| --- | --- | --- | --- |
| `master.ipset` | <sub>Abusive IP addresses which have been reported for port scanning and SSH brute-forcing. HIGHLY recommended. <br> Includes [AbuseIPDB](https://www.abuseipdb.com/), [IPThreat](https://ipthreat.net/), [CinsScore](https://cinsscore.com), [GreensNow](https://blocklist.greensnow.co/greensnow.txt)</sub> | ★★★★★ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/master.ipset) |
| `highrisk.ipset` | <sub>IPs with highest risk to your network and have a possibility that the activity which comes from them are going to be fraudulent.</sub> | ★★★★★ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/highrisk.ipset) |

<br />

---

<br />

# Privacy Lists
These blocklists give you more control over what 3rd party services can access your server, and allows you to remove bad actors or services hosting such services.

<br />

| Set | Description | Severity | View |
| --- | --- | --- | --- |
| `privacy_general.ipset` | <sub>Servers which scan ports for data collection and research purposes. List includes [Censys](https://censys.io), [Shodan](https://www.shodan.io/), [Project25499](https://blogproject25499.wordpress.com/), [InternetArchive](https://archive.org/), [Cyber Resilience](https://cyberresilience.io), [Internet Measurement](https://internet-measurement.com), [probe.onyphe.net](https://onyphe.net), [Security Trails](https://securitytrails.com) </sub> | ★★★★⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_general.ipset) |
| `privacy_ahrefs.ipset` | <sub>Ahrefs SEO and services</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/privacy/privacy_ahrefs.ipset) |
| `privacy_amazon_aws.ipset` | <sub>Amazon AWS</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_amazon_aws.ipset) |
| `privacy_amazon_ec2.ipset` | <sub>Amazon EC2</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_amazon_ec2.ipset) |
| `privacy_applebot.ipset` | <sub>Apple Bots</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_applebot.ipset) |
| `privacy_bing.ipset` | <sub>Microsoft Bind and Bing Crawlers / Bots</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_bing.ipset) |
| `privacy_bunnycdn.ipset` | <sub>Bunny CDN</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_bunnycdn.ipset) |
| `privacy_cloudflarecdn.ipset` | <sub>Cloudflare CDN</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_cloudflarecdn.ipset) |
| `privacy_cloudfront.ipset` | <sub>Cloudfront DNS</sub> | ★⚝⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_cloudfront.ipset) |
| `privacy_duckduckgo.ipset` | <sub>DuckDuckGo Web Crawlers / Bots</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_duckduckgo.ipset) |
| `privacy_facebook.ipset` | <sub>Facebook Bots & Trackers</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_facebook.ipset) |
| `privacy_fastly.ipset` | <sub>Fastly CDN</sub> | ★⚝⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_fastly.ipset) |
| `privacy_google.ipset` | <sub>Google Crawlers</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_google.ipset) |
| `privacy_pingdom.ipset` | <sub>Pingdom Monitoring Service</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_pingdom.ipset) |
| `privacy_rssapi.ipset` | <sub>RSS API Reader</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_rssapi.ipset) |
| `privacy_stripe_api.ipset` | <sub>Stripe Payment Gateway API</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_stripe_api.ipset) |
| `privacy_stripe_armada_gator.ipset` | <sub>Stripe Armada Gator</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_stripe_armada_gator.ipset) |
| `privacy_stripe_webhooks.ipset` | <sub>Stripe Webhook Service</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_stripe_webhooks.ipset) |
| `privacy_telegram.ipset` | <sub>Telegram Trackers and Crawlers</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_telegram.ipset) |
| `privacy_uptimerobot.ipset` | <sub>Uptime Robot Monitoring Service</sub> | ★⚝⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_uptimerobot.ipset) |
| `privacy_webpagetest.ipset` | <sub>Webpage Test Services</sub> | ★★⚝⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/privacy/privacy_webpagetest.ipset) |

<br />

---

<br />

# Spam Lists
These blocklists allow you to remove the possibility of spam sources accessing your server.

<br />

| Set | Description | Severity | View |
| --- | --- | --- | --- |
| `spam_forums.ipset` | <sub>List of known forum / blog spammers and bots</sub> | ★★★⚝⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/spam/spam_forums.ipset) |
| `spam_spamhaus.ipset` | <sub>Bad actor IP addresses registered with Spamhaus</sub> | ★★★★⚝ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/spam/spam_spamhaus.ipset) |

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
  - Paste the link to Transmission > Edit > Preferences > Privacy > Enable Blocklist

<br />

| Set | Description | Severity | View | Website |
| --- | --- | --- | --- | --- |
| `bt-transmission` | <sub>A large blocklist for the BitTorrent client [Transmission](https://transmissionbt.com/)</sub> | ★★★★★ | [view](https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/transmission/blocklist.ipset) | [view](https://transmissionbt.com/) |

<br />

---

<br />

# Install

This section explains how to use these blocklists within particular software titles.

<br />

## ConfigServer Firewall Users

This repository contains a set of ipsets which are automatically updated every `6 hours`. You may add these sets to your ConfigServer Firewall `/etc/csf/csf.blocklists` with the following new line:

```
CSF_MASTER|86400|0|https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/master.ipset
CSF_HIGHRISK|86400|0|https://raw.githubusercontent.com/Aetherinox/blocklists/main/blocklists/highrisk.ipset
```

<br />

The format for the above lines are `NAME|INTERVAL|MAX_IPS|URL`:

- **NAME**: List name with all uppercase alphabetic characters with no spaces and a maximum of 25 characters - this will be used as the iptables chain name
- **INTERVAL**: Refresh interval to download the list, must be a minimum of 3600 seconds (an hour).
  - `86400` (one day / 24 hours) should be more than enough
- **MAX_IPS**: This is the maximum number of IP addresses to use from the list, a value of 0 means all IPs. 
  - If you add an ipset with 50,000 IPs, and you set this value to 20,000; then you will only block the first 20,000.
- **URL**: The URL to download the ipset from

<br />

> [!NOTE]
> If you have not modified the settings of ConfigServer Firewall; the `MAX_IPS` value is limited by the setting `LF_IPSET_MAXELEM` which has a maximum value of `65536` IPs; even if you set the value in your lists above to 0, or anything above 65536.
>
> To allow for higher numbers of blocked IPs in an ipset; you must edit your CSF config file located in `/etc/csf/csf.conf` and set the setting `LF_IPSET_MAXELEM` to something higher than `65536`:
> ```ini
> # old value
> # LF_IPSET_MAXELEM = "65536"
> LF_IPSET_MAXELEM = "4000000"
> ```
>
> This setting can also be modified through the ConfigServer Firewall Admin WebUI if you have it installed.

<br />

Once you have added the line(s) above; you will need to give ConfigServer Firewall and LFD a restart.

```shell
sudo csf -ra
```

<br />

You can confirm that the ipset is installed by running the command:

```shell
sudo ipset --list -n
```

<br />

The above command will list all existing ipsets running on your firewall. As you can see in the list below; we have `bl_CSF_HIGHRISK`, `bl_6_CSF_HIGHRISK`, `bl_CSF_MASTER`, and `bl_6_CSF_MASTER`. Which are the lists we loaded above.

```console
chain_DENY
chain_6_DENY
chain_ALLOW
chain_6_ALLOW
bl_CSF_HIGHRISK
bl_6_CSF_HIGHRISK
bl_CSF_MASTER
bl_6_CSF_MASTER
```

<br />

To view all of the IPs in a specified ipset / list, run:

```shell
$ sudo ipset --list bl_CSF_HIGHRISK

Name: bl_CSF_HIGHRISK
Type: hash:net
Revision: 7
Header: family inet hashsize 1024 maxelem 4000000 bucketsize 12 initval 0x5f263e28
Size in memory: 24024
References: 1
Number of entries: 630
Members:
XX.XX.XX.XXX
XX.XX.XX.XXX
[ ... ]
```

<br />

If you modified the ConfigServer Firewall setting `LF_IPSET_MAXELEM` _(explained in the note above)_, you will see the new max limit value listed next to `maxelem`.

```shell
Header: family inet hashsize 1024 maxelem 4000000 
```

<br />

> [!NOTE]
> If you decide to use the blocklist `master.ipset`, you must ensure you increase the value of the setting `LF_IPSET_MAXELEM` in the file `/etc/csf/csf.conf` to at least `400000`.
> 
> On average, the `master.ipset` list normally contains `392,000` blocked IP addresses.