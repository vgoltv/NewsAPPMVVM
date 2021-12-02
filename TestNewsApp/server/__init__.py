# -*- coding: utf-8 -*-
from flask import Flask
from flask import jsonify
from flask import request
from flask import render_template
import socket

app = Flask(__name__,
        static_url_path='', 
        static_folder='web/static',
        template_folder='web/templates')
    
app.config['APP_PORT'] = 5001

@app.route("/")
def home():
    """Landing page route."""
    nav = [
        {"name": "Github project", "url": "https://github.com/vgoltv/NewsAPPMVVM"},
    ]
    return render_template(
        "home.html",
        nav=nav,
        title="NewsAPPMVVM",
        description="Sample project to learn how to use swiftui 2.0 with Combine, we look into using SwiftUI MVVM, also interact with an API to get our newsfeed, use SPM(Swift Package Manager) to speed up our development flow and handle swiftui layout with views such as VStack.",
    )

@app.route("/summary")
def summary():
    null = ""
    ip_address = request.host_url
    return jsonify({
"articles": [
    {
        "author": "TMZ Staff",
        "source": "TMZ",
        "title": "Joel McHale Says Alleged Don Lewis Doc Doesn't Exonerate Carole Baskin - TMZ",
        "image": ip_address+"images/quick-way-to-find-active-php-ini-file.jpg",
        "date": "2021-11-27T08:50:00Z",
        "description": "If Don Lewis is actually alive, Joel doesn't think Carole's in the clear.",
        "url": "https://www.tmz.com/2021/11/27/joel-mchale-don-lewis-document-tiger-king-carole-baskin/"
    },
    {
        "author": "Ken Sweet",
        "source": "Associated Press",
        "title": "Stocks sink on new COVID variant; Dow loses 905 points - apnews.com",
        "image": ip_address+"images/3000.jpg",
        "date": "2021-11-27T08:30:05Z",
        "description": "NEW YORK (AP) — Stocks sank Friday, with the Dow Jones Industrial Average briefly falling more than 1,000 points, as a new coronavirus variant first detected in South Africa appeared to be spreading across the globe.",
        "url": "https://apnews.com/article/coronavirus-pandemic-health-business-asia-stock-markets-7aa5c5acef16621e72d33212e77924f2"
    },
    {
        "author": "",
        "source": "Reuters",
        "title": "Broadway legend Stephen Sondheim, whose work transformed musical theater, dead at 91 - Reuters",
        "image": ip_address+"images/UOIDU2QLHVMLXBNIJJUMJRXQHE.jpg",
        "date": "2021-11-27T07:34:00Z",
        "description": "Broadway composer and lyricist Stephen Sondheim, who helped American musical theater evolve beyond pure entertainment and reach new artistic heights with such works as \"West Side Story,\" \"Into the Woods\" and \"Sweeney Todd,\" died early Friday at the age of 91,…",
        "url": "https://www.reuters.com/world/us/broadway-legend-stephen-sondheim-dead-91-2021-11-26/"
    },
    {
        "author": "",
        "source": "YouTube",
        "title": "Group of suspects stole hammers, crowbars at The Home Depot in Lakewood - FOX 11 Los Angeles",
        "image": ip_address+"images/hqdefault.jpg",
        "date": "2021-11-27T06:55:57Z",
        "description": "A robbery incident is under investigation at The Home Depot in Los Angeles County.Subscribe to FOX 11 Los Angeles: https://www.youtube.com/channel/UCHfF8wFni...",
        "url": "https://www.youtube.com/watch?v=taUGYGTj134"
    },
    {
        "author": "Amy Cheng",
        "source": "The Washington Post",
        "title": "Omicron covid variant feared at Amsterdam airport as the Netherlands enters night-time lockdown - The Washington Post",
        "image": ip_address+"images/1440.jpg",
        "date": "2021-11-27T06:35:44Z",
        "description": "The Netherlands is bracing for dozens of cases off two flights from South Africa and researchers are racing to determine if passengers are infected with the omicron variant.",
        "url": "https://www.washingtonpost.com/world/2021/11/27/amsterdam-omicron-covid-variant-lockdown/"
    },
    {
        "author": "",
        "source": "KABC-TV",
        "title": "324 Riverside County residents received Pfizer COVID-19 vaccine stored in freezer longer than recommended - KABC-TV",
        "image": ip_address+"images/1600.jpg",
        "date": "2021-11-27T06:24:09Z",
        "description": "More than 300 people who received Pfizer's COVID-19 vaccine recently in Riverside County may not be as fully protected from the virus as they thought.",
        "url": "https://abc7.com/riverside-county-pfizer-covid-vaccine-frozen-doses/11273603/"
    },
    {
        "author": "ESPN staff",
        "source": "ESPN",
        "title": "Duke beats Gonzaga: What we learned from Friday's elite-level college basketball showcase - ESPN",
        "image": ip_address+"images/D9.jpg",
        "date": "2021-11-27T06:18:08Z",
        "description": "Duke took down No. 1 Gonzaga 84-81 in a championship-caliber top-5 matchup in Las Vegas on Friday night. Here's everything we learned.",
        "url": "https://www.espn.com/mens-college-basketball/story/_/id/32723735/duke-beats-gonzaga-learned-friday-elite-level-college-basketball-showcase"
    },
    {
        "author": "Andy Rose, CNN",
        "source": "CNN",
        "title": "1 person shot at Tacoma Mall in Washington state, authorities say - CNN",
        "image": ip_address+"images/takoma.jpg",
        "date": "2021-11-27T05:22:00Z",
        "description": "One person was shot at the Tacoma Mall in Washington state on Friday night, sending shoppers scrambling for safety, officials said.",
        "url": "https://www.cnn.com/2021/11/27/us/washington-state-tacoma-mall-shooting/index.html"
    },
    {
        "author": "Jennifer Zhan",
        "source": "Vulture",
        "title": "Ye Is Praying That He and Kim Kardashian Get Back Together - Vulture",
        "image": ip_address+"images/rsocial.jpg",
        "date": "2021-11-27T04:47:21Z",
        "description": "“All I think about every day is how I get my family back together and how I heal the pain that I’ve caused.”",
        "url": "http://www.vulture.com/2021/11/kanye-west-kim-kardashian-thanksgiving-prayer.html"
    },
    {
        "author": "Brenda Gregorio-Nieto",
        "source": "NBC 7 San Diego",
        "title": "Investigation Underway After Person With Knife Shot, Killed at Base Entrance: MCRD - NBC 7 San Diego",
        "image": ip_address+"images/MCRD.jpg",
        "date": "2021-11-27T04:28:50Z",
        "description": "A person was shot and killed at a Marine Corps Recruit Depot entrance gate Friday after approaching base personnel with a knife in a hostile intent, Marine…",
        "url": "https://www.nbcsandiego.com/news/local/military-police-officer-shoots-kills-person-at-marine-corps-recruit-depot-sdpd/2802684/"
    },
    {
        "author": "Rich Johnston",
        "source": "Bleeding Cool News",
        "title": "Empty Tables But Smiles Behind The Masks At San Diego Comic-Con 2021 - Bleeding Cool News",
        "image": ip_address+"images/IMG_20211126_114133697-1200x628.jpg",
        "date": "2021-11-27T04:07:10Z",
        "description": "So this is the biggest discussion I have had with people at San Diego Comic-Con: Special Edition yesterday, specifically comic book creators and publishers. And it is one of appreciation for something they remembered but had partially forgotten. Because this …",
        "url": "https://bleedingcool.com/comics/empty-tables-but-smiles-behind-the-masks-at-san-diego-comic-con-2021/"
    },
    {
        "author": "Eric Song",
        "source": "IGN",
        "title": "Last Minute Black Friday Dell Deal: Alienware Aurora RTX 3080 Ti Gaming PC for $2699 - IGN - IGN",
        "image": ip_address+"images/bfnewalienware-1637980832939.jpg",
        "date": "2021-11-27T04:06:59Z",
        "description": "Alternatively, the Alienware RTX 3090 PC is $3199",
        "url": "https://www.ign.com/articles/best-black-friday-dell-deal-alienware-rtx-3080-gaming-pc"
    },
    {
        "author": "Daniel Villarreal",
        "source": "Newsweek",
        "title": "'It's Coming': N.Y. Gov. Kathy Hochul Issues Omicron Warning, Declares State of Emergency - Newsweek",
        "image": ip_address+"images/new-york-kathy-hochul-omicron-variant-emergency.jpg",
        "date": "2021-11-27T03:29:37Z",
        "description": "New York became the center of the COVID-19 pandemic when it first began. The Omicron variant threatens to repeat that trend.",
        "url": "https://www.newsweek.com/its-coming-ny-gov-kathy-hochul-issues-omicron-warning-declares-state-emergency-1653658"
    },
    {
        "author": "Brianna Abbott",
        "source": "The Wall Street Journal",
        "title": "Omicron Coronavirus Variant Raises Questions Among Scientists - The Wall Street Journal",
        "image": ip_address+"images/social.jpg",
        "date": "2021-11-27T03:25:00Z",
        "description": "Researchers are investigating whether mutations might make variant more infectious or evade immune response",
        "url": "https://www.wsj.com/articles/omicron-coronavirus-variant-raises-questions-among-scientists-11637954249"
    },
    {
        "author": "Guardian staff reporter",
        "source": "The Guardian",
        "title": "Brooks Koepka takes down Bryson DeChambeau in made-for-TV match - The Guardian",
        "image": "",
        "date": "2021-11-27T03:21:00Z",
        "description": "Brooks Koepka defeated his rival and compatriot Bryson DeChambeau 4 and 3 in a 12-hole edition of ‘The Match’ Friday at Wynn Golf Club in Las Vegas",
        "url": "https://amp.theguardian.com/sport/2021/nov/26/brooks-koepka-bryson-dechambeau-golf-matchc"
    },
    {
        "author": "Monique Beals",
        "source": "The Hill",
        "title": "Old Spice and Secret recall sprays after cancer-causing chemical detected | TheHill - The Hill",
        "image": ip_address+"images/oldspice_spray_042914_ap.jpg",
        "date": "2021-11-27T02:45:41Z",
        "description": "Procter & Gamble Co. is recalling some of its Old Spice and Secret aerosol antiperspiran...",
        "url": "https://thehill.com/business-a-lobbying/583225-old-spice-and-secret-sprays-recalled-after-cancer-causing-chemical"
    },
    {
        "author": "Manas Mishra, Reuters, Michael Erman, Reuters",
        "source": "KSL.com",
        "title": "Merck's COVID-19 pill significantly less effective in new analysis - KSL.com",
        "image": ip_address+"images/28520112.jpg",
        "date": "2021-11-27T02:24:46Z",
        "description": "Merck & Co said on Friday updated data from its study of its experimental COVID-19 pill showed the drug was significantly less effective in cutting hospitalizations and deaths than previously reported.",
        "url": "https://www.ksl.com/article/50292040/mercks-covid-19-pill-significantly-less-effective-in-new-analysis"
    },
    {
        "author": "Al Jazeera",
        "source": "Al Jazeera English",
        "title": "Three bodies found after days of unrest in Solomon Islands - Aljazeera.com",
        "image": ip_address+"images/000_9TE9C2.jpg",
        "date": "2021-11-27T02:13:42Z",
        "description": "Australian police are now helping patrol Honiara, the capital, which was relatively calm on Saturday morning.",
        "url": "https://www.aljazeera.com/news/2021/11/27/three-bodies-found-after-days-of-unrest-in-solomon-islands"
    },
    {
        "author": "Isaiah Hole",
        "source": "USA Today",
        "title": "Michigan football posts epic hype video before Ohio State game - WolverinesWire",
        "image": ip_address+"images/michigan-ohio-state-6420.jpg",
        "date": "2021-11-27T01:54:00Z",
        "description": "This is guaranteed to give you goosebumps!",
        "url": "https://wolverineswire.usatoday.com/2021/11/26/michigan-football-vs-ohio-state-hype-video/"
    },
    {
        "author": "",
        "source": "NPR",
        "title": "Retail sales surged this Black Friday, though the day's impact is diluted - NPR",
        "image": ip_address+"images/ap21330758217725_wide-1cb8450745286782b8d0a18a7019420158229c6d.jpg",
        "date": "2021-11-27T01:30:28Z",
        "description": "The day after Thanksgiving drew hefty crowds of shoppers in real life, though it has lost stature as shopping has shifted online and discounts are extended for several days.",
        "url": "https://www.npr.org/2021/11/26/1059427267/retail-sales-surged-this-black-friday-though-the-days-impact-is-diluted"
    }
]
})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=app.config['APP_PORT'])