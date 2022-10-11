import requests
from requests import status_codes
import lxml.html as html
import os
import datetime

HOME_URL = 'https://diarioelsalvador.com/'

XPATH_LINK_TO_ARTICLE = '//h3[@class="jeg_post_title"]/a/@href'
XPATH_TITLE = '//div[@class="entry-header"]/h1[@class="jeg_post_title"]/text()'
XPATH_SUBTITLE = '//div[@class="entry-header"]/h2[@class="jeg_post_subtitle"]/text()'
XPATH_BODY = '//div[@class="content-inner "]/p[not(@class)]/text()'

def run():
    _parse_home()


def _parse_home():
    
    try:
        response = requests.get(HOME_URL)
        if response.status_code == 200:
            home = response.content.decode('utf-8')
            parsed = html.fromstring(home)
            links_to_notices = parsed.xpath(XPATH_LINK_TO_ARTICLE)
            # print(links_to_notices)
            
            today = datetime.date.today().strftime('%d-%m-%Y')
            
            if not os.path.isdir(today):
                os.mkdir(today)
            
            for link in links_to_notices:
                _parse_notice(link, today)
        else:
            raise ValueError(f'Error {response.status_code}')
        
    except ValueError as ve:
        print(f'There was an error:\n\t{ve}')


def _parse_notice(link, today):
    try:
        response = requests.get(link)
        if response.status_code == 200:
            notice = response.content.decode('utf-8')
            parsed = html.fromstring(notice)
            
            try:
                title = parsed.xpath(XPATH_TITLE)[0]
                title = title.replace('\"','')
                subtitle = parsed.xpath(XPATH_SUBTITLE)[0]
                body = parsed.xpath(XPATH_BODY)
            except IndexError:
                return
            
            with open(f'{today}/{title}.txt', 'w', encoding='utf-8') as f:
                f.write(title)
                f.write('\n\n')
                f.write(subtitle)
                f.write('\n\n')
                for p in body:
                    f.write(p)
                    f.write('\n')
        else:
            raise ValueError(f'Error: {response.status_code}')
    except ValueError as ve:
        print(ve)


if __name__ == '__main__':
    run()