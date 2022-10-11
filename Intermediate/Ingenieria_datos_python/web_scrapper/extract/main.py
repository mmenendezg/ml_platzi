import argparse
import logging
import re
import datetime
import csv

from requests.exceptions import HTTPError
from urllib3.exceptions import MaxRetryError

# Regular expressions to evaluate if the link is correct
is_well_link = re.compile(r'^https?://.+/.+$')
is_root_path = re.compile(r'^/.+$')

logging.basicConfig(level=logging.INFO)

from common import config
import news_page_object as news

logger = logging.getLogger(__name__)

def _news_scraper(news_site_uid):
    host = config()['news_sites'][news_site_uid]['url']
    
    logging.info(f'Beginning scraper for {host}')
    homepage = news.HomePage(news_site_uid, host)
    
    articles = []
    for link in homepage.article_links:
        article = _fetch_article(news_site_uid, host, link)

        if article:
            logger.info('Article Fetched!')
            articles.append(article)
    
    _save_articles(news_site_uid, articles)
        
def _fetch_article(news_site_uid, host, link):
    logger.info(f'Start fetching article at {link}')
    
    article = None

    try:
        article = news.ArticlePage(news_site_uid, _build_link(host, link))
    except (HTTPError, MaxRetryError) as e:
        logging.warning('Error while fetching the article')
    
    if article and not article.body:
        logger.warning('Invalid article. There is no body')
        return None
    
    return article

def _build_link(host, link):
    
    if is_well_link.match(link):
        return link
    elif is_root_path.match(link):
        return f'{host}{link}'
    else:
        return f'{host}/{link}'

def _save_articles(news_site_uid, articles):
    
    now = datetime.datetime.now().strftime('%Y_%m_%d')
    file_name = f'{news_site_uid}_{now}_articles.csv'
    csv_headers = list(filter(lambda property: not property.startswith('_'), dir(articles[0])))
    
    with open(file_name, mode='w+') as f:
        writer = csv.writer(f)
        writer.writerow(csv_headers)
        for article in articles:
            row = [str(getattr(article, prop)) for prop in csv_headers]
            writer.writerow(row)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    
    news_site_choices = list(config()['news_sites'].keys())
    parser.add_argument(
        'news_site',
        help = 'The news site you want to scrape',
        type = str,
        choices = news_site_choices
    )
    args = parser.parse_args()
    _news_scraper(args.news_site)